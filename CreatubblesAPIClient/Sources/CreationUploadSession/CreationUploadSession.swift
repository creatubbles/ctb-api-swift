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
    case Completed = 6
}

class CreationUploadSession: ResponseHandler
{
    private let image: UIImage
    private let requestSender: RequestSender
    private var state: CreationUploadSessionState
    private var isActive: Bool
    
    private let imageFileName: String
    private let relativeImageFilePath: String
    
    private let name: String?
    private let reflectionText: String?
    private let reflectionVideoUrl: String?
    private let galleryId: String?
    private let creatorIds: Array<String>?
    private let creationYear: Int?
    private let creationMonth: Int?
    
    //Fields filled during creation upload flow
    private var creationId: String?
    private var creationUpload: CreationUpload?
    
    init(image: UIImage, requestSender: RequestSender, name: String? = nil, reflectionText: String? = nil, reflectionVideoUrl: String? = nil, galleryId: String? = nil, creatorIds: Array<String>? = nil, creationYear: Int? = nil, creationMonth: Int? = nil)
    {
        self.image = image
        self.state = .Initialized
        self.requestSender = requestSender
        self.isActive = false
        
        self.imageFileName = String(NSDate().timeIntervalSince1970)+"_creation.jpg"
        self.relativeImageFilePath = "images/"+imageFileName
        
        self.name = name
        self.galleryId = galleryId
        self.creatorIds = creatorIds
        self.reflectionText = reflectionText
        self.reflectionVideoUrl = reflectionVideoUrl
        self.creationYear = creationYear
        self.creationMonth = creationMonth
    }
    
    func start(completion: (ErrorType?) -> Void)
    {
        self.isActive = true
        saveImageOnDisk(nil) { [weak self](error) -> Void in
            if let weakSelf = self {
                weakSelf.allocateCreation(error, completion: { (error) -> Void in
                    weakSelf.obtainUploadPath(error, completion: { (error) -> Void in
                        weakSelf.uploadImage(error, completion: { (error) -> Void in
                            weakSelf.notifyServer(error, completion: { (error) -> Void in
                                print("Upload flow finished with error: \(error)")
                                weakSelf.isActive = false
                                completion(error)
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
                if error != nil
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
        
        let request = NewCreationRequest(name: name, creatorIds: creatorIds, creationYear: creationYear, creationMonth: creationMonth, reflectionText: reflectionText, reflectionVideoUrl: reflectionVideoUrl)
        let handler = NewCreationResponseHandler
        {
            [weak self](creation, error) -> Void in
            if let weakSelf = self,
               let creation = creation
            {
                weakSelf.creationId = creation.identifier
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
        let request = NewCreationUploadRequest(creationId: self.creationId!, creationExtension: .JPEG)
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
        requestSender.send(UIImageJPEGRepresentation(image, 1)!, uploadData: creationUpload!,
        progressChanged:
        {
            (bytesWritten, totalBytesWritten, totalBytesExpectedToWrite) -> Void in
            
        },
        completion:
        {
            [weak self](error) -> Void in
            if  let weakSelf = self
            {
                if error != nil
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
                if error != nil
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
        let data = UIImageJPEGRepresentation(image, 1)!
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
}
