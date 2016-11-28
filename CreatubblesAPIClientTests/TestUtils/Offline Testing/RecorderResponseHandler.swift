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
    private let outputFileName: String?
    private let shouldRecordResponseToFile: Bool
    
    init(originalHandler: ResponseHandler, filenameToSave:String, shouldRecordResponseToFile: Bool)
    {
        self.originalResponseHandler = originalHandler
        self.outputFileName = filenameToSave
        self.shouldRecordResponseToFile = shouldRecordResponseToFile
    }
    
    override func handleResponse(_ response: Dictionary<String, AnyObject>?, error: Error?)
    {
    
        if let _ = outputFileName,
           shouldRecordResponseToFile == true
        {
            saveResponseToFile(response, error: error)
        }
        
        originalResponseHandler.handleResponse(response, error: error)
    }
    
    func saveResponseToFile(_ response: Dictionary<String, AnyObject>?, error: Error?)
    {
        if shouldRecordResponseToFile == true
        {
            let nsDocumentDirectory = FileManager.SearchPathDirectory.documentDirectory
            let nsUserDomainMask    = FileManager.SearchPathDomainMask.userDomainMask
            let paths               = NSSearchPathForDirectoriesInDomains(nsDocumentDirectory, nsUserDomainMask, true)
            if let dirPath          = paths.first
            {
                let path = dirPath.stringByAppendingPathComponent(outputFileName!)
                if let response = response
                {
                    NSKeyedArchiver.archiveRootObject(response, toFile: path)
                }
                else if let error = error
                {
                    NSKeyedArchiver.archiveRootObject(error, toFile: path)
                }
            }
        }
    }
    
    

}
