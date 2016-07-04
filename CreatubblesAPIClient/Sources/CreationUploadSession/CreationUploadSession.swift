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
    case Initialized = 0
    case ImageSavedOnDisk = 1
    case CreationAllocated = 2
    case UploadPathObtained = 3
    case ImageUploaded = 4
    case ServerNotified = 5
    case Cancelled = 6
}

protocol CreationUploadSessionDelegate: class
{
    func creationUploadSessionChangedState(creationUploadSession: CreationUploadSession)
    func creationUploadSessionUploadFailed(creationUploadSession: CreationUploadSession, error: ErrorType)
    func creationUploadSessionChangedProgress(creationUploadSession: CreationUploadSession,bytesWritten: Int, totalBytesWritten: Int, totalBytesExpectedToWrite: Int)
}

class CreationUploadSession: NSObject, Cancelable
{
    private let requestSender: RequestSender
    let localIdentifier: String
    let creationData: NewCreationData
    let imageFileName: String
    let relativeImageFilePath: String
    
    private (set) var state: CreationUploadSessionState
    private (set) var isActive: Bool
    private (set) var creation: Creation?               //Filled during upload flow
    private (set) var creationUpload: CreationUpload?    //Filled during upload flow
    
    private var isAlreadyFinished: Bool { return state == .ServerNotified }
    private var currentRequest: RequestHandler?
    
    weak var delegate: CreationUploadSessionDelegate?
    
    init(data: NewCreationData, requestSender: RequestSender)
    {
        self.localIdentifier = NSUUID().UUIDString;
        self.isActive = false
        self.state = .Initialized
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
        
        let url = NSURL(fileURLWithPath: (CreationUploadSession.documentsDirectory()+"/"+relativeImageFilePath))
        
        self.creationData = NewCreationData(creationDataEntity: creationUploadSessionEntity.creationDataEntity!, url: url)
        
        if let creationEntity = creationUploadSessionEntity.creationEntity
        {
            self.creation = Creation(creationEntity: creationEntity)
        }
    }
    
    func cancel()
    {
        currentRequest?.cancel()
        state = .Cancelled
        delegate?.creationUploadSessionChangedState(self)
        
        if !isActive && !isAlreadyFinished
        {
            delegate?.creationUploadSessionUploadFailed(self, error: APIClientError.UploadCancelled)
        }
    }
    
    func start(completion: CreationClosure?)
    {
        if isAlreadyFinished
        {
            completion?(self.creation, nil)
            return
        }
        
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
                                
                                print("Upload flow finished with error: \(error)")
                                
                                weakSelf.isActive = false
                                weakSelf.delegate?.creationUploadSessionChangedState(weakSelf)
                                if let error = error
                                {
                                    weakSelf.delegate?.creationUploadSessionUploadFailed(weakSelf, error: error)
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
    private func saveImageOnDisk(error: ErrorType?,completion: (ErrorType?) -> Void)
    {
        if let error = error
        {
            completion(error)
            return
        }
        if state.rawValue >= CreationUploadSessionState.ImageSavedOnDisk.rawValue
        {
            completion(nil)
            return
        }
        saveCurrentImage()
        {
            [weak self](error: ErrorType?) -> Void in
            if let weakSelf = self
            {
                if error == nil
                {
                    weakSelf.state = .ImageSavedOnDisk
                }
            }
            completion(error)
        }
    }
    
    private func allocateCreation(error: ErrorType?, completion: (ErrorType?) -> Void)
    {
        if let error = error
        {
            print(error)
            completion(error)
            return
        }
        if state.rawValue >= CreationUploadSessionState.CreationAllocated.rawValue
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
                    weakSelf.state = .CreationAllocated
                }
                completion(error)
        }
        currentRequest = requestSender.send(request, withResponseHandler: handler)
    }
    
    private func obtainUploadPath(error: ErrorType?, completion: (ErrorType?) -> Void)
    {
        if let error = error
        {
            completion(error)
            return
        }
        if state.rawValue >= CreationUploadSessionState.UploadPathObtained.rawValue
        {
            completion(nil)
            return
        }
        let request = NewCreationUploadRequest(creationId: self.creation!.identifier, creationExtension: self.creationData.uploadExtension)
        let handler = NewCreationUploadResponseHandler
            {
                [weak self](creationUpload, error) -> Void in
                if  let weakSelf = self,
                    creationUpload = creationUpload
                {
                    weakSelf.creationUpload = creationUpload
                    weakSelf.state = .UploadPathObtained
                }
                completion(error)
        }
        currentRequest = requestSender.send(request, withResponseHandler: handler)
    }
    
    private func uploadImage(error: ErrorType?, completion: (ErrorType?) -> Void)
    {
        if let error = error
        {
            completion(error)
            return
        }
        if state.rawValue >= CreationUploadSessionState.ImageUploaded.rawValue
        {
            completion(nil)
            return
        }

        currentRequest =  requestSender.send(creationData, uploadData: creationUpload!,
        progressChanged:
        {
            (bytesWritten, totalBytesWritten, totalBytesExpectedToWrite) -> Void in
            self.delegate?.creationUploadSessionChangedProgress(self, bytesWritten: bytesWritten, totalBytesWritten: totalBytesWritten, totalBytesExpectedToWrite: totalBytesExpectedToWrite)
        },
        completion:
        {
            [weak self](error) -> Void in
            if  let weakSelf = self
            {
                if error == nil
                {
                    weakSelf.state = .ImageUploaded
                }
                else
                {
                    //MM: Failure can be related to expired AWS token. Will update token for safety.
                    weakSelf.state = .CreationAllocated
                }
                completion(error)
            }
        })
    }
    
    private func notifyServer(error: ErrorType?, completion: (ErrorType?) -> Void)
    {
        if let error = error
        {
            completion(error)
            return
        }
        if state.rawValue >= CreationUploadSessionState.ServerNotified.rawValue
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
                        weakSelf.state = .ServerNotified
                    }
                }
                completion(error)
        }
        currentRequest = requestSender.send(request, withResponseHandler: handler)
    }
    
    //MARK: - Utils
    private class func documentsDirectory() -> String
    {
        let paths = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true);
        return paths.first!
    }
    
    private func saveCurrentImage(completion: (ErrorType?) -> Void)
    {
        if(creationData.dataType != .Image)
        {
            completion(nil)
            return
        }
        
        let data = UIImageJPEGRepresentation(creationData.image!, 1)!
        let url = NSURL(fileURLWithPath: (CreationUploadSession.documentsDirectory()+"/"+relativeImageFilePath))
        let fileManager = NSFileManager.defaultManager()
        
        if !fileManager.fileExistsAtPath(url.path!.stringByDeletingLastPathComponent)
        {
            do
            {
                try fileManager.createDirectoryAtPath(url.path!.stringByDeletingLastPathComponent, withIntermediateDirectories: true, attributes: nil)
            }
            catch let error
            {
                completion(error)
            }
        }
        if fileManager.fileExistsAtPath(url.path!)
        {
            do
            {
                try fileManager.removeItemAtPath(url.path!)
            }
            catch let error
            {
                completion(error)
            }
        }
        data.writeToURL(url, atomically: true)
        completion(nil)
    }
    
    private func notifyDelegateSessionChanged()
    {
        delegate?.creationUploadSessionChangedState(self)
    }
}
