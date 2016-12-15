//
//  APIClientError.swift
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
//

import UIKit
@testable import CreatubblesAPIClient

class TestRecorder
{
    private let isLoggedIn: Bool?
    
    init(isLoggedIn: Bool?)
    {
        self.isLoggedIn = isLoggedIn
    }
    
    func saveResponseToFile(_ response: Dictionary<String, AnyObject>?, fileToSavePath: String?, error: Error?)
    {
        guard TestConfiguration.mode == .useAPIAndRecord,
            let path = fileToSavePath
            else { return }
        let response: Any = (response ?? error) ?? ""
        NSKeyedArchiver.archiveRootObject(response, toFile: path)
    }
    
    func handleRequest(request: Request, recorderHandler: RecorderResponseHandler) -> RequestHandler
    {
        
        let fileName = TestRecorderNameUtils.filenameForRequest(request: request, isLoggedIn: isLoggedIn)
        let inputFilePath = TestRecorderNameUtils.getInputFilePathForFileName(fileName: fileName)
        
        let fileManager = FileManager.default
        
        //Error when file doesn't exist - otherwise NSKeyedUnarchiver "unarchives" forever
        
        guard let filePath = inputFilePath,
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

}
