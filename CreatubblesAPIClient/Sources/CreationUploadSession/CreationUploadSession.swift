//
//  CreationUploadSession.swift
//  CreatubblesAPIClient
//
//  Copyright (c) 2016 Creatubbles Pte. Ltd.
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

enum CreationUploadSessionState: Int
{
    case initialized = 0
    case imageSavedOnDisk = 1
    case creationAllocated = 2
    case uploadPathObtained = 3
    case imageUploaded = 4
    case serverNotified = 5
    case cancelled = 6
}

protocol CreationUploadSessionDelegate: class
{
    func creationUploadSessionChangedState(_ creationUploadSession: CreationUploadSession)
    func creationUploadSessionUploadFailed(_ creationUploadSession: CreationUploadSession, error: Error)
    func creationUploadSessionChangedProgress(_ creationUploadSession: CreationUploadSession, completedUnitCount: Int64, totalUnitcount: Int64, fractionCompleted: Double)
}

class CreationUploadSession: NSObject, Cancelable
{
    fileprivate let requestSender: RequestSender
    let localIdentifier: String
    let creationData: NewCreationData
    let imageFileName: String
    let relativeImageFilePath: String
    
    fileprivate (set) var state: CreationUploadSessionState
    fileprivate (set) var isActive: Bool
    fileprivate (set) var creation: Creation?               //Filled during upload flow
    fileprivate (set) var creationUpload: CreationUpload?    //Filled during upload flow
    fileprivate (set) var error: Error?
    
    fileprivate var isAlreadyFinished: Bool { return state == .serverNotified }
    fileprivate var currentRequest: RequestHandler?
    
    weak var delegate: CreationUploadSessionDelegate?
    
    init(data: NewCreationData, requestSender: RequestSender)
    {
        self.localIdentifier = UUID().uuidString;
        self.isActive = false
        self.state = .initialized
        self.requestSender = requestSender
        self.creationData = data
        self.imageFileName = localIdentifier+"_creation"
        self.relativeImageFilePath = "creations/"+imageFileName        
    }
    
    init(creationUploadSessionEntity: CreationUploadSessionEntity, requestSender: RequestSender)
    {
        self.localIdentifier = creationUploadSessionEntity.localIdentifier!
        self.isActive = false
        self.state = creationUploadSessionEntity.state
        self.requestSender = requestSender
        self.imageFileName = creationUploadSessionEntity.imageFileName!
        self.relativeImageFilePath = creationUploadSessionEntity.relativeImageFilePath!
        
        if let creationUploadEntity = creationUploadSessionEntity.creationUploadEntity
        {
            self.creationUpload = CreationUpload(creationUploadEntity: creationUploadEntity)
        }
        
        let url = URL(fileURLWithPath: (CreationUploadSession.documentsDirectory()+"/"+relativeImageFilePath))
        
        self.creationData = NewCreationData(creationDataEntity: creationUploadSessionEntity.creationDataEntity!, url: url)
        
        if let creationEntity = creationUploadSessionEntity.creationEntity
        {
            self.creation = Creation(creationEntity: creationEntity)
        }
    }
    
    func cancel()
    {
        currentRequest?.cancel()
        state = .cancelled
        delegate?.creationUploadSessionChangedState(self)
        
        if !isActive && !isAlreadyFinished
        {
            delegate?.creationUploadSessionUploadFailed(self, error: APIClientError.genericUploadCancelledError as Error)
        }
    }
    
    func start(_ completion: CreationClosure?)
    {
        if isAlreadyFinished
        {
            completion?(self.creation, nil)
            return
        }
        
        self.error = nil        //MM: Should we clear error when we restart session? 
        self.isActive = true
        saveImageOnDisk(nil) { [weak self](error) -> Void in
            if let weakSelf = self {
                weakSelf.allocateCreation(error, completion: { (error) -> Void in
                    weakSelf.delegate?.creationUploadSessionChangedState(weakSelf)
                    
                    weakSelf.obtainUploadPath(error, completion: { (error) -> Void in
                        weakSelf.delegate?.creationUploadSessionChangedState(weakSelf)
                        
                        weakSelf.uploadImage(error, completion: { (error) -> Void in
                            weakSelf.delegate?.creationUploadSessionChangedState(weakSelf)
                            weakSelf.notifyServer(error, completion: { (error) -> Void in
                                
                                weakSelf.error = error
                                weakSelf.isActive = false
                                weakSelf.delegate?.creationUploadSessionChangedState(weakSelf)
                                
                                if let error = error
                                {
                                    Logger.log.error("Upload \(weakSelf.localIdentifier) finished with error: \(error)")
                                    weakSelf.delegate?.creationUploadSessionUploadFailed(weakSelf, error: error)
                                }
                                else
                                {
                                    Logger.log.debug("Upload \(weakSelf.localIdentifier) finished successfully")
                                }
                                
                                completion?(weakSelf.creation, ErrorTransformer.errorFromResponse(nil, error: error))
                            })
                        })
                    })
                })
            }
        }        
    }
    
    //MARK: Upload Flow
    fileprivate func saveImageOnDisk(_ error: Error?,completion: @escaping (Error?) -> Void)
    {
        if let error = error
        {
            completion(error)
            return
        }
        if state.rawValue >= CreationUploadSessionState.imageSavedOnDisk.rawValue
        {
            completion(nil)
            return
        }
        saveCurrentImage()
        {
            [weak self](error: Error?) -> Void in
            if let weakSelf = self
            {
                if error == nil
                {
                    weakSelf.state = .imageSavedOnDisk
                }
            }
            completion(error)
        }
    }
    
    fileprivate func allocateCreation(_ error: Error?, completion: @escaping (Error?) -> Void)
    {
        if let error = error
        {
            print(error)
            completion(error)
            return
        }
        if state.rawValue >= CreationUploadSessionState.creationAllocated.rawValue
        {
            completion(nil)
            return
        }
        let request = NewCreationRequest(creationData: creationData)
        let handler = NewCreationResponseHandler
            {
                [weak self](creation, error) -> Void in
                if let weakSelf = self,
                    let creation = creation
                {
                    weakSelf.creation = creation
                    weakSelf.state = .creationAllocated
                }
                completion(error)
        }
        currentRequest = requestSender.send(request, withResponseHandler: handler)
    }
    
    fileprivate func obtainUploadPath(_ error: Error?, completion: @escaping (Error?) -> Void)
    {
        if let error = error
        {
            completion(error)
            return
        }
        if state.rawValue >= CreationUploadSessionState.uploadPathObtained.rawValue
        {
            completion(nil)
            return
        }
        let request = NewCreationUploadRequest(creationId: self.creation!.identifier, creationExtension: self.creationData.uploadExtension)
        let handler = NewCreationUploadResponseHandler
            {
                [weak self](creationUpload, error) -> Void in
                if  let weakSelf = self,
                    let creationUpload = creationUpload
                {
                    weakSelf.creationUpload = creationUpload
                    weakSelf.state = .uploadPathObtained
                }
                completion(error)
        }
        currentRequest = requestSender.send(request, withResponseHandler: handler)
    }
    
    fileprivate func uploadImage(_ error: Error?, completion: @escaping (Error?) -> Void)
    {
        if let error = error
        {
            completion(error)
            return
        }
        if state.rawValue >= CreationUploadSessionState.imageUploaded.rawValue
        {
            completion(nil)
            return
        }

        currentRequest =  requestSender.send(creationData, uploadData: creationUpload!,
        progressChanged:
        {
            (completedUnitCount, totalUnitCount, fractionCompleted) -> Void in
            self.delegate?.creationUploadSessionChangedProgress(self, completedUnitCount: completedUnitCount, totalUnitcount: totalUnitCount, fractionCompleted: fractionCompleted)
        },
        completion:
        {
            [weak self](error) -> Void in
            if  let weakSelf = self
            {
                if error == nil
                {
                    weakSelf.state = .imageUploaded
                }
                else
                {
                    //MM: Failure can be related to expired AWS token. Will update token for safety.
                    weakSelf.state = .creationAllocated
                }
                completion(error)
            }
        })
    }
    
    fileprivate func notifyServer(_ error: Error?, completion: @escaping (Error?) -> Void)
    {
        if let error = error
        {
            completion(error)
            return
        }
        if state.rawValue >= CreationUploadSessionState.serverNotified.rawValue
        {
            completion(nil)
            return
        }
        let request = NewCreationPingRequest(uploadId: creationUpload!.identifier)
        let handler = NewCreationPingResponseHandler
            {
                [weak self](error) -> Void in
                if let weakSelf = self
                {
                    if error == nil
                    {
                        weakSelf.state = .serverNotified
                    }
                }
                completion(error)
        }
        currentRequest = requestSender.send(request, withResponseHandler: handler)
    }
    
    //MARK: - Utils
    fileprivate class func documentsDirectory() -> String
    {
        let paths = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true);
        return paths.first!
    }
    
    fileprivate func saveCurrentImage(_ completion: (Error?) -> Void)
    {
        if(creationData.dataType != .image)
        {
            completion(nil)
            return
        }
        
        let data = UIImageJPEGRepresentation(creationData.image!, 1)!
        let url = URL(fileURLWithPath: (CreationUploadSession.documentsDirectory()+"/"+relativeImageFilePath))
        let fileManager = FileManager.default
        
        if !fileManager.fileExists(atPath: url.path.stringByDeletingLastPathComponent)
        {
            do
            {
                try fileManager.createDirectory(atPath: url.path.stringByDeletingLastPathComponent, withIntermediateDirectories: true, attributes: nil)
            }
            catch let error
            {
                completion(error)
            }
        }
        if fileManager.fileExists(atPath: url.path)
        {
            do
            {
                try fileManager.removeItem(atPath: url.path)
            }
            catch let error
            {
                completion(error)
            }
        }
        try? data.write(to: url, options: [.atomic])
        completion(nil)
    }
    
    fileprivate func notifyDelegateSessionChanged()
    {
        delegate?.creationUploadSessionChangedState(self)
    }
}
