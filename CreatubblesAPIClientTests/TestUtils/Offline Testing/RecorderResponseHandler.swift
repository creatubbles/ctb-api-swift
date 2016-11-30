//
//  RecorderResponseHandler.swift
//  CreatubblesAPIClient
//
//  Created by Nomtek on 28.11.2016.
//  Copyright © 2016 Nomtek. All rights reserved.
//

import UIKit
@testable import CreatubblesAPIClient

class RecorderResponseHandler: ResponseHandler
{
    private let originalResponseHandler: ResponseHandler
    private let fileToSavePath: String?
    private let shouldRecordResponseToFile: Bool
    
    init(originalHandler: ResponseHandler, fileToSavePath: String?, shouldRecordResponseToFile: Bool)
    {
        self.originalResponseHandler = originalHandler
        self.fileToSavePath = fileToSavePath
        self.shouldRecordResponseToFile = shouldRecordResponseToFile
    }
    
    override func handleResponse(_ response: Dictionary<String, AnyObject>?, error: Error?)
    {
    
        if let _ = fileToSavePath,
           shouldRecordResponseToFile == true
        {
            saveResponseToFile(response, error: error)
        }
        
        originalResponseHandler.handleResponse(response, error: error)
    }
    
    private func saveResponseToFile(_ response: Dictionary<String, AnyObject>?, error: Error?)
    {
        guard shouldRecordResponseToFile,
              let path = fileToSavePath
        else { return }
        let response: Any = (response ?? error) ?? ""
        NSKeyedArchiver.archiveRootObject(response, toFile: path)
    }
}
