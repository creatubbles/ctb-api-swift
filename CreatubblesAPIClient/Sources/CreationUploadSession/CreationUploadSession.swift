//  CreationUploadSession.swift
//  CreatubblesAPIClient
//
//  Copyright (c) 2017 Creatubbles Pte. Ltd.
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.

import UIKit

// REFACTORING NOTES:
// Sebastian: From my perspective refactoring effort should start with discussion on how should the upload work from user perspective: reporting progress (multi step?), reporting errors (currently just X - not useful), possibly error recovery options - we should know what is needed from the user perspective so that we can design a minimal upload API satisfying those requirements
// 0. current setup of upload classes is constrained by the fact, that it's located in the API client - it's higher level logic and we could consider moving it
//    (or more likely adding new one) to base app target
// 1. currently there are 2 methods of reporting progress - completion block and delegate - I think we should use just one, preferably, observers
// 2. right now upload session notifier subscribes pusher's "creation processing" events and handles notifying upload session FROM THE OUTSIDE, that it should update it's state
//    upload session should handle the monitoring and react to changes internally - all cases where a delegate/observer method might be called should be visible in the upload session
// 3. upload is multistage and complex mainly because some steps run independently from each other e.g. image/video processing and submitting to gallery
//    and even further submitting to gallery is optional (not all uploads include submission to gallery)) - it's very important to express that as clearly as possible and
//    handle error cases properly (pusher event about failed processing), as well as make the progress reporting as clear and reliable as possible (avoid duplicated or missed notifications for example)
// 4. in general, logic related to upload session itself should be separated e.g. it shouldn't handle file setup
//    all observer/delegate notifications should happen in that extracted code, so it's always visible which event causes given notification to be triggered
// 5. local processing completion block could probably be replaced with just an observer notification - previously uploads were added to list one by one as local processing was finished and it seemed to work well
// 6. the behavior of the upload session/service should be verified with tests
// 7. see UploadSessionsNotifier.swift for example of handling upload-related pusher events
// 8. how to determine failed processing if we miss pusher event (app killed before receiving notification)? do we need to support such case e.g. will current code retake the upload step, giving another go at the processing?

enum CreationUploadSessionState: Int {
    case initialized = 0
    case imageSavedOnDisk = 1
    case creationAllocated = 2
    case uploadPathObtained = 3
    case imageUploaded = 4
    case serverNotified = 5
    case submittedToGallery = 6
    case cancelled = 7
    case confirmedOnServer = 8
    case completed = 9
}

protocol CreationUploadSessionDelegate: class {
    func creationUploadSessionChangedState(_ creationUploadSession: CreationUploadSession)
    func creationUploadSessionUploadFailed(_ creationUploadSession: CreationUploadSession, error: Error)
    func creationUploadSessionChangedProgress(_ creationUploadSession: CreationUploadSession, completedUnitCount: Int64, totalUnitcount: Int64, fractionCompleted: Double)
}

class CreationUploadSession: NSObject, Cancelable {
    fileprivate let requestSender: RequestSender
    let localIdentifier: String
    let creationData: NewCreationData
    private(set) var imageFileName: String
    private(set) var relativeFilePath: String

    fileprivate (set) var state: CreationUploadSessionState
    fileprivate (set) var isActive: Bool
    fileprivate (set) var creation: Creation?               //Filled during upload flow
    fileprivate (set) var creationUpload: CreationUpload?    //Filled during upload flow
    fileprivate (set) var error: Error?

    var isAlreadyFinished: Bool { return state == .confirmedOnServer ||  state == .submittedToGallery || state == .completed}
    var isCancelled: Bool { return state == .cancelled }
    var isFailed: Bool { return error != nil }

    fileprivate var currentRequest: RequestHandler?

    fileprivate static let confirmedOnServerRecheckInterval: TimeInterval = 3.0 // [s]
    // not really sure what value to assign here - processing longer or higher quality videos might take more than this
    // we should probably discuss how to handle this cross-team - reporting different steps could be done locally
    // reporting processing progress for example would likely require some changes on the backend
    // users would definitely like to know the progress of processing or rather when will the upload really be completed, which we currently don't report (stuck at 95%)
    fileprivate static let confirmedOnServerRecheckTimeout: TimeInterval = 600.0 // [s]
    fileprivate var confirmedOnServerRefreshTimer: Timer?
    fileprivate var confirmedOnServerRefreshCompletion: CreationClosure?
    fileprivate var confirmedOnServerRefreshCompletionWasCalled: Bool = false
    fileprivate var confirmedOnServerRechecksPerformedCount: Int = 0
    fileprivate var creationProcessingFailed: Bool = false

    weak var delegate: CreationUploadSessionDelegate?

    init(data: NewCreationData, requestSender: RequestSender) {
        self.localIdentifier = data.localIdentifier ?? UUID().uuidString
        self.isActive = false
        self.state = .initialized
        self.requestSender = requestSender
        self.creationData = data
        self.imageFileName = localIdentifier+"_creation.\(self.creationData.uploadExtension.stringValue)"

        if let fileURL = data.url, data.storageType == .appGroupDirectory {
            self.relativeFilePath = fileURL.lastPathComponent
        } else {
            self.relativeFilePath = "creations/"+imageFileName
        }
    }

    init(creationUploadSessionEntity: CreationUploadSessionEntity, requestSender: RequestSender) {
        self.localIdentifier = creationUploadSessionEntity.localIdentifier!
        self.isActive = false
        self.state = creationUploadSessionEntity.state
        self.requestSender = requestSender
        self.imageFileName = creationUploadSessionEntity.imageFileName!
        self.relativeFilePath = creationUploadSessionEntity.relativeImageFilePath!

        if let creationUploadEntity = creationUploadSessionEntity.creationUploadEntity {
            self.creationUpload = CreationUpload(creationUploadEntity: creationUploadEntity)
        }

        var url = URL(fileURLWithPath: (CreationUploadSession.documentsDirectory()+"/"+relativeFilePath))
        if let appGroupDirectory = CreationUploadSession.appGroupDirectory(), creationUploadSessionEntity.creationDataEntity!.storageType == .appGroupDirectory {
            url = URL(fileURLWithPath: (appGroupDirectory+"/"+relativeFilePath))
        }

        self.creationData = NewCreationData(creationDataEntity: creationUploadSessionEntity.creationDataEntity!, url: url)

        if let creationEntity = creationUploadSessionEntity.creationEntity {
            self.creation = Creation(creationEntity: creationEntity)
        }
    }
    
    func configureImageFileName(newImageFileName: String) {
        self.imageFileName = newImageFileName
        
        if let fileURL = creationData.url, creationData.storageType == .appGroupDirectory {
            self.relativeFilePath = fileURL.lastPathComponent
        } else {
            self.relativeFilePath = "creations/"+imageFileName
        }
    }

    func cancel() {
        currentRequest?.cancel()
        state = .cancelled
        notifyDelegateSessionChanged()

        if !isActive && !isAlreadyFinished {
            notifyDelegateSessionChanged(error: APIClientError.genericUploadCancelledError as Error)
        }
    }
    
    func prepare(completion: @escaping (Error?) -> Void) {
        saveImageOnDisk(nil) { (error) -> Void in
            completion(error)
        }
    }

    func start(_ completion: CreationClosure?) {
        if isAlreadyFinished {
            completion?(self.creation, nil)
            return
        }

        creationProcessingFailed = false
        self.error = nil        //MM: Should we clear error when we restart session?
        self.isActive = true
        saveImageOnDisk(nil) { [weak self](error) -> Void in
            if let weakSelf = self {
                weakSelf.allocateCreation(error, completion: { (error) -> Void in
                    weakSelf.notifyDelegateSessionChanged()

                    weakSelf.obtainUploadPath(error, completion: { (error) -> Void in
                        weakSelf.notifyDelegateSessionChanged()

                        weakSelf.uploadImage(error, completion: { (error) -> Void in
                            weakSelf.notifyDelegateSessionChanged()

                            weakSelf.notifyServer(error, completion: { (error) -> Void in
                                weakSelf.notifyDelegateSessionChanged()

                                // if there's no gallery to submit to, it completes with success immediately
                                weakSelf.uploadToGallery(error: error, completion: { (error) in
                                    weakSelf.notifyDelegateSessionChanged()

                                    weakSelf.refreshCreationStatus(error: error, completion: { (error) in
                                        weakSelf.error = error

                                        if let error = error {
                                            Logger.log(.error, "Upload \(weakSelf.localIdentifier) finished with error: \(error)")
                                            weakSelf.isActive = false
                                            weakSelf.notifyDelegateSessionChanged(error: error)
                                            completion?(weakSelf.creation, ErrorTransformer.errorFromResponse(nil, error: error))
                                        } else if weakSelf.state == .confirmedOnServer || weakSelf.state == .completed {
                                            Logger.log(.debug, "Upload \(weakSelf.localIdentifier) finished successfully")
                                            weakSelf.isActive = false
                                            weakSelf.state = .completed
                                            weakSelf.notifyDelegateSessionChanged()
                                            completion?(weakSelf.creation, ErrorTransformer.errorFromResponse(nil, error: error))
                                        } else {
                                            weakSelf.setupAutoRefreshTimer(refreshCompletion: completion)
                                        }
                                    })
                                })
                            })
                        })
                    })
                })
            }
        }
    }

    func isValid() -> Bool {
        switch creationData.dataType {
        case .data: return false
        case .image: return true
        case .url:
            guard let fileURL = creationData.url else { return false }
            return fileURL.pathExtension == creationData.uploadExtension.stringValue
        }
    }

    // MARK: Upload Flow
    fileprivate func saveImageOnDisk(_ error: Error?, completion: @escaping (Error?) -> Void) {
        if let error = error {
            completion(error)
            return
        }
        if state.rawValue >= CreationUploadSessionState.imageSavedOnDisk.rawValue {
            completion(nil)
            return
        }
        storeCreation {
                [weak self](error: Error?) -> Void in
                if let weakSelf = self {
                    if error == nil {
                        weakSelf.state = .imageSavedOnDisk
                    }
                }
                completion(error)
        }
    }

    fileprivate func allocateCreation(_ error: Error?, completion: @escaping (Error?) -> Void) {
        if let error = error {
            print(error)
            completion(error)
            return
        }
        if state.rawValue >= CreationUploadSessionState.creationAllocated.rawValue {
            completion(nil)
            return
        }

        if let creationIdentifier = creationData.creationIdentifier {
            let request = FetchCreationsRequest(creationId: creationIdentifier)
            let handler = FetchCreationsResponseHandler {
                    [weak self]  (creations, _, error) -> (Void) in
                    if let strongSelf = self,
                        let creation = creations?.first {
                        strongSelf.creation = creation
                        strongSelf.state = .creationAllocated
                    }
                    completion(error)
            }
            currentRequest = requestSender.send(request, withResponseHandler: handler)
        } else {
            let request = NewCreationRequest(creationData: creationData)
            let handler = NewCreationResponseHandler {
                    [weak self] (creation, error) -> Void in
                    if let strongSelf = self,
                        let creation = creation {
                        strongSelf.creation = creation
                        strongSelf.state = .creationAllocated
                    }
                    completion(error)
            }
            currentRequest = requestSender.send(request, withResponseHandler: handler)
        }
    }

    fileprivate func obtainUploadPath(_ error: Error?, completion: @escaping (Error?) -> Void) {
        if let error = error {
            completion(error)
            return
        }
        if state.rawValue >= CreationUploadSessionState.uploadPathObtained.rawValue {
            completion(nil)
            return
        }
        let request = NewCreationUploadRequest(creationId: self.creation!.identifier, creationExtension: self.creationData.uploadExtension)
        let handler = NewCreationUploadResponseHandler {
                [weak self](creationUpload, error) -> Void in
                if  let weakSelf = self,
                    let creationUpload = creationUpload {
                    weakSelf.creationUpload = creationUpload
                    weakSelf.state = .uploadPathObtained
                }
                completion(error)
        }
        currentRequest = requestSender.send(request, withResponseHandler: handler)
    }

    fileprivate func uploadImage(_ error: Error?, completion: @escaping (Error?) -> Void) {
        if let error = error {
            completion(error)
            return
        }
        if state.rawValue >= CreationUploadSessionState.imageUploaded.rawValue {
            completion(nil)
            return
        }

        currentRequest = requestSender.send(creationData, uploadData: creationUpload!,
                                             progressChanged: {
                (completedUnitCount, totalUnitCount, fractionCompleted) -> Void in
                self.delegate?.creationUploadSessionChangedProgress(self, completedUnitCount: completedUnitCount, totalUnitcount: totalUnitCount, fractionCompleted: fractionCompleted)
        },
                                             completion: {
                [weak self](error) -> Void in
                if  let weakSelf = self {
                    if error == nil {
                        weakSelf.state = .imageUploaded
                    } else {
                        //MM: Failure can be related to expired AWS token. Will update token for safety.
                        weakSelf.state = .creationAllocated
                    }
                    completion(error)
                }
        })
    }

    fileprivate func notifyServer(_ error: Error?, completion: @escaping (Error?) -> Void) {
        if let error = error {
            completion(error)
            return
        }
        if state.rawValue >= CreationUploadSessionState.serverNotified.rawValue {
            completion(nil)
            return
        }
        let request = NewCreationPingRequest(uploadId: creationUpload!.identifier)
        let handler = NewCreationPingResponseHandler {
                [weak self](error) -> Void in
                if let weakSelf = self {
                    if error == nil {
                        weakSelf.state = .serverNotified
                    }
                }
                completion(error)
        }
        currentRequest = requestSender.send(request, withResponseHandler: handler)
    }

    private func uploadToGallery(error: Error?, completion: @escaping (Error?) -> Void) {
        if let error = error {
            completion(error)
            return
        }
        if state.rawValue >= CreationUploadSessionState.submittedToGallery.rawValue {
            completion(nil)
            return
        }

        // if there's no gallery to submit to, we just consider it done
        guard let galleryIdentifiers = creationData.galleryIds,
                  !galleryIdentifiers.isEmpty
        else {
            state = .submittedToGallery
            Logger.log(.debug, "GalleryId not set for creation to upload:\(self.creation!.identifier)")
            completion(nil)
            return
        }

        let submitter = GallerySubmitter(requestSender: requestSender, creationId: creation!.identifier, galleryIdentifiers: galleryIdentifiers) {
            [weak self](error) -> Void in
            if let weakSelf = self {
                if error == nil {
                    weakSelf.state = .submittedToGallery
                }
            }
            completion(error)
        }

        currentRequest = submitter.submit()
    }

    private func refreshCreationStatus(error: Error?, completion: @escaping (Error?) -> Void) {
        if let error = error {
            completion(error)
            return
        }
        if state.rawValue >= CreationUploadSessionState.confirmedOnServer.rawValue {
            completion(nil)
            return
        }

        guard let creation = creation
        else {
            let error = APIClientError.genericError(APIClientError.MissingCreationToRefreshStatus, code: APIClientError.MissingCreationToRefreshCode,
                                                    title: nil, source: nil, detail: nil)
            completion(error)
            return
        }

        let request = FetchCreationsRequest(creationId: creation.identifier)
        let handler = FetchCreationsResponseHandler {
            [weak self](creations, _, error) -> (Void) in
            guard let strongSelf = self,
                let creation = creations?.first
                else {
                let error = error ?? APIClientError(status: APIClientError.InvalidResponseDataStatus, code: APIClientError.InvalidResponseDataCode,
                                                    title: nil, source: nil, detail: "Missing creation in response for Refresh Creation")
                completion(error)
                return
            }
            strongSelf.creation = creation
            if creation.imageOriginalUrl != nil,
               (strongSelf.state == .submittedToGallery || strongSelf.state == .serverNotified) {
                strongSelf.state = .confirmedOnServer
            }
            completion(error)
        }
        currentRequest = requestSender.send(request, withResponseHandler: handler)
    }

    // MARK: - Creation Refresh
    func refreshCreation(completion: ((Creation?, APIClientError?) -> (Void))?) {
        let currentState = state
        refreshCreationStatus(error: nil) {
            [weak self](error) in
            completion?(self?.creation, error as? APIClientError)
            if let strongSelf = self, strongSelf.state != currentState {
                strongSelf.delegate?.creationUploadSessionChangedState(strongSelf)
            }
        }
    }
    
    // happens when image or video processing connected to creation fails on Amazon
    // notified from the outside in reaction to pusher event (not part of API client)
    func setCreationProcessingFailed() {
        creationProcessingFailed = true
    }

    fileprivate func setupAutoRefreshTimer(refreshCompletion: CreationClosure?) {
        if let timer = confirmedOnServerRefreshTimer {
            timer.invalidate()
            confirmedOnServerRefreshTimer = nil
        }

        confirmedOnServerRefreshCompletion = refreshCompletion
        confirmedOnServerRechecksPerformedCount = 0
        confirmedOnServerRefreshTimer = Timer.scheduledTimer(timeInterval: CreationUploadSession.confirmedOnServerRecheckInterval,
                                                             target: self,
                                                             selector: #selector(autoRefreshCreationFromTimer),
                                                             userInfo: nil,
                                                             repeats: true)
    }

    func autoRefreshCreationFromTimer() {
        confirmedOnServerRechecksPerformedCount += 1
        let confirmedOnServerRecheckTimeSpent = Double(confirmedOnServerRechecksPerformedCount) * CreationUploadSession.confirmedOnServerRecheckInterval
        let exceededRefreshTimeout = confirmedOnServerRecheckTimeSpent > CreationUploadSession.confirmedOnServerRecheckTimeout
        
        var uploadError: APIClientError?
        if exceededRefreshTimeout {
            uploadError = APIClientError.genericError(title: "Upload error! Creation didn't finish processing before retry timeout.")
        }
        else if creationProcessingFailed {
            uploadError = APIClientError.genericError(title: "Upload error! Image or video processing failed.")
        }
        
        // fail when we exceeded the timeout or the processing failed
        if let error = uploadError {
            self.error = error
            isActive = false
            notifyDelegateSessionChanged(error: error)
            confirmedOnServerRefreshCompletion?(nil, error)
            clearRefreshTimerAndCompletion()
            return
        }

        if state == CreationUploadSessionState.confirmedOnServer {
            clearRefreshTimerAndCompletion()
            return
        }

        // this seems to only be needed if "processing completed" pusher event is supported (currently disabled)
        if (state.rawValue < CreationUploadSessionState.serverNotified.rawValue) {
            // Too early to refresh creation. Server hadn't chance to process it
            return
        }

        refreshCreationStatus(error: nil) { [weak self] _ in
            // only call the completion when the request succeeds - when it fails we'll make further attempts using refresh timer
            guard let strongSelf = self, strongSelf.state == CreationUploadSessionState.confirmedOnServer else { return }
            
            strongSelf.isActive = false
            strongSelf.notifyDelegateSessionChanged()
            strongSelf.confirmedOnServerRefreshCompletion?(strongSelf.creation, nil)
            strongSelf.clearRefreshTimerAndCompletion()
        }
    }

    // MARK: - Utils
    fileprivate func clearRefreshTimerAndCompletion() {
        confirmedOnServerRefreshTimer?.invalidate()
        confirmedOnServerRefreshTimer = nil
        confirmedOnServerRefreshCompletion = nil
    }
    
    fileprivate class func documentsDirectory() -> String {
        let paths = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)
        return paths.first!
    }

    fileprivate class func appGroupDirectory() -> String? {
        guard let appGroupIdentifier = AppGroupConfigurator.identifier
        else { return nil }
        return FileManager.default.containerURL(forSecurityApplicationGroupIdentifier: appGroupIdentifier)?.path

    }

    fileprivate func storeCreation(_ completion: ((Error?) -> Void) ) {
        // Because of the data object created inside this method I recommend to execute this method only in the background thread.
        var data: Data?
        
        if let creationData = self.creationData.data {
            data = creationData
        } else if let image = self.creationData.image {
            data = UIImageJPEGRepresentation(image, 1)
        } else if let url = self.creationData.url {
            data = try? Data(contentsOf: url)
        }
        
        if data == nil {
            Logger.log(.error, "Creation data cannot be retrieved")
            completion(APIClientError.genericUploadCancelledError as Error)
            return
        }

        var url = URL(fileURLWithPath: (CreationUploadSession.documentsDirectory()+"/"+relativeFilePath))

        if let appGroupDirectory = CreationUploadSession.appGroupDirectory(), creationData.storageType == .appGroupDirectory {
            url = URL(fileURLWithPath: (appGroupDirectory+"/"+relativeFilePath))
        }

        let fileManager = FileManager.default

        if !fileManager.fileExists(atPath: url.path.stringByDeletingLastPathComponent) {
            do {
                try fileManager.createDirectory(atPath: url.path.stringByDeletingLastPathComponent, withIntermediateDirectories: true, attributes: nil)
            } catch let error {
                completion(error)
            }
        }
        if fileManager.fileExists(atPath: url.path) {
            do { try fileManager.removeItem(atPath: url.path) } catch let error {
                completion(error)
            }
        }

        do {
            try data?.write(to: url, options: [.atomic])
            self.creationData.url = url
            completion(nil)
        } catch let error {
            Logger.log(.error, "File save error: \(error)")
            completion(APIClientError.genericUploadCancelledError as Error)
        }
    }
    
    fileprivate func notifyDelegateSessionChanged(error: Error? = nil) {
        // We have to make sure that all delegate calls are in the main thread. The delegate may execute some operations strictly related to this thread (i.e. operation on the database, NOTE: Realm object is created in the main thread and all requests have to be executed in the same context). Based on the testing session this was one of the reasons of crashes that are really hard to track.
        DispatchQueue.main.async {
            if let error = error {
                self.delegate?.creationUploadSessionUploadFailed(self, error: error)
            } else {
                self.delegate?.creationUploadSessionChangedState(self)
            }
        }
    }
}
