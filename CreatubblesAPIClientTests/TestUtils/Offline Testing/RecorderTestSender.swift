//
//  RecorderTestSender.swift
//  CreatubblesAPIClient
//
//  Created by Nomtek on 28.11.2016.
//  Copyright © 2016 Nomtek. All rights reserved.
//

import UIKit
@testable import CreatubblesAPIClient

class RecorderTestSender: RequestSender
{
    private let shouldRecordResponseToFile: Bool
    private let shouldUseRecordedResponses: Bool
    
    var isLoggedIn: Bool?
    
    override init(settings: APIClientSettings)
    {
        switch TestConfiguration.mode
        {
        case .useAPIAndRecord :
            self.shouldUseRecordedResponses = false
            self.shouldRecordResponseToFile = true
        case .useRecordedResponses :
            self.shouldUseRecordedResponses = true
            self.shouldRecordResponseToFile = false
        default:
            self.shouldUseRecordedResponses = false
            self.shouldRecordResponseToFile = false
        }
        
        super.init(settings: settings)
    }
    
    override func send(_ request: Request, withResponseHandler handler: ResponseHandler) -> RequestHandler
    {
        let fileName = filenameForRequest(request: request)
        let filePath = getInputFilePathForFileName(fileName: fileName)
        
        let recorderHandler = RecorderResponseHandler(originalHandler: handler, fileToSavePath: filePath, shouldRecordResponseToFile: shouldRecordResponseToFile)
        
        if shouldUseRecordedResponses == true
        {
            let fileManager = FileManager.default
            
            //Error when file doesn't exist - otherwise NSKeyedUnarchiver "unarchives" forever
            
            guard let filePath = filePath,
                      fileManager.fileExists(atPath: filePath)
            else
            {
                let error = APIClientError(status: -6004, code: nil, title: "Missing Response", source: nil, detail: "Response file was not found.")
                recorderHandler.handleResponse(nil, error: error)
                return RequestHandler(object: request as Cancelable)
            }
            
            if let response = NSKeyedUnarchiver.unarchiveObject(withFile: filePath)
            {
                if let error = ErrorTransformer.errorsFromResponse(response as? Dictionary<String, AnyObject>).first
                {
                    Logger.log.error("Error while sending request:\(type(of: request))\nError:\nResponse:\n\(response)")
                    recorderHandler.handleResponse(nil, error: error)
                }
                else if let error = response as? Error
                {
                    Logger.log.error("Error while sending request:\(type(of: request))\nError:\nResponse:\n\(response)")
                    recorderHandler.handleResponse(nil, error: error)
                }
                else
                {
                    DispatchQueue.global().async
                    {
                        recorderHandler.handleResponse((response as? Dictionary<String, AnyObject>),error: nil)
                    }
                }
            }
            return RequestHandler(object: request as Cancelable)
        }
        if shouldRecordResponseToFile == true
        {
            return super.send(request, withResponseHandler: recorderHandler)
        }
        else
        {
            return super.send(request, withResponseHandler: handler)
        }
    }
    
    private func filenameForRequest(request: Request) -> String
    {
        var nameComponents = Array<String>()
        nameComponents.append(request.endpoint)
        nameComponents.append(request.method.rawValue)
        nameComponents.append(String(String(describing: request.parameters).hashValue))
        nameComponents.append("loggedIn;\(self.isLoggedIn)")
        
        nameComponents = [nameComponents.joined(separator: "_")]
        
        let name =  String(nameComponents.first!.characters.map { $0 == "/" ? "." : $0 })
        return name.trimmingCharacters(in: .whitespacesAndNewlines)
    }
    
    func getInputFilePathForFileName(fileName: String) -> String?
    {
        let nsDocumentDirectory = FileManager.SearchPathDirectory.documentDirectory
        let nsUserDomainMask    = FileManager.SearchPathDomainMask.userDomainMask
        let paths               = NSSearchPathForDirectoriesInDomains(nsDocumentDirectory, nsUserDomainMask, true)
        if let dirPath          = paths.first
        {
            return dirPath.stringByAppendingPathComponent(fileName)
        }
        return nil
    }
    
    override func login(_ username: String, password: String, completion: ErrorClosure?) -> RequestHandler
    {
        if shouldRecordResponseToFile == true
        {
            isLoggedIn = true
        }
        else if shouldUseRecordedResponses == true
        {
            isLoggedIn = true
            let request = AuthenticationRequest(username: username, password: password, settings: TestConfiguration.settings)
            completion?(nil)
            return RequestHandler(object: request as Cancelable)
        }
        return super.login(username, password: password, completion: completion)
    }
    
    override func logout()
    {
        if shouldRecordResponseToFile == true || shouldUseRecordedResponses == true
        {
            isLoggedIn = false
        }
        super.logout()
    }
}
