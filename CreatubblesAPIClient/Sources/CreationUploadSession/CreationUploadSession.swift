//
//  CreationUploadSession.swift
//  CreatubblesAPIClient
//
//  Created by Michal Miedlarz on 17.02.2016.
//  Copyright © 2016 Nomtek. All rights reserved.
//

import UIKit

enum CreationUploadSessionState: Int
{
    case Initialized = 0
    case ImageSavedOnDisk = 1
    case CreationAllocated = 2
    case UploadPathObtained = 3
    case ImageUploaded = 4
    case ServerNotified = 5
}


protocol CreationUploadSessionDelegate: class
{
    func creationUploadSessionChangedState(creationUploadSession: CreationUploadSession)
    func creationUploadSessionChangedProgress(creationUploadSession: CreationUploadSession,bytesWritten: Int, totalBytesWritten: Int, totalBytesExpectedToWrite: Int)
}

class CreationUploadSession: ResponseHandler
{

    weak var delegate: CreationUploadSessionDelegate?
    
    let creationData: NewCreationData
    private let requestSender: RequestSender
    
    var state: CreationUploadSessionState
    var isActive: Bool
    
    let imageFileName: String
    let relativeImageFilePath: String
    
    //Fields filled during creation upload flow
    var creation: Creation?
    var creationUpload: CreationUpload?
    
    private var isAlreadyFinished: Bool {return state == .ServerNotified }
    
    init(data: NewCreationData, requestSender: RequestSender)
    {
        self.isActive = false
        self.state = .Initialized
        self.requestSender = requestSender
        self.creationData = data
        
        self.imageFileName = String(NSDate().timeIntervalSince1970)+"_creation.jpg"
        self.relativeImageFilePath = "images/"+imageFileName
    }
    
    init(creationUploadSessionEntity: CreationUploadSessionEntity, requestSender: RequestSender)
    {
        self.isActive = false
        self.state = creationUploadSessionEntity.state
        self.requestSender = requestSender
        self.imageFileName = creationUploadSessionEntity.imageFileName!
        self.relativeImageFilePath = creationUploadSessionEntity.relativeImageFilePath!
        self.creationUpload = CreationUpload(creationUploadEntity: creationUploadSessionEntity.creationUploadEntity!)
        
        self.creationData = NewCreationData(creationDataEntity: creationUploadSessionEntity.creationDataEntity!, image: UIImage(contentsOfFile: relativeImageFilePath)!)
        
        self.creation = Creation(creationEntity: creationUploadSessionEntity.creationEntity!)
    }
    
    func start(completion: CreationClousure?)
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
                                completion?(weakSelf.creation, error)
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
        requestSender.send(request, withResponseHandler: handler)
        
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
        let request = NewCreationUploadRequest(creationId: self.creation!.identifier, creationExtension: .JPEG)
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
        requestSender.send(request, withResponseHandler: handler)
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
        
        requestSender.send(UIImageJPEGRepresentation(creationData.image, 1)!, uploadData: creationUpload!,
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
        requestSender.send(request, withResponseHandler: handler)
    }
    
    //MARK: - Utils
    private func saveCurrentImage(completion: (ErrorType?) -> Void)
    {
        let data = UIImageJPEGRepresentation(creationData.image, 1)!
        let url = NSURL(fileURLWithPath: relativeImageFilePath)
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
            defer
            {
            
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
