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
    init(originalHandler: ResponseHandler, filenameToSave:String)
    {
        originalResponseHandler = originalHandler
    }
    
    override func handleResponse(_ response: Dictionary<String, AnyObject>?, error: Error?)
    {
        originalResponseHandler.handleResponse(response, error: error)
        if let shouldRecordResponseToFile = shouldRecordResponseToFile,
            let _ = outputFileName,
            shouldRecordResponseToFile == true
        {
            saveResponseToFile(response, error: error)
        }
    }
    
    func saveResponseToFile(_ response: Dictionary<String, AnyObject>?, error: Error?)
    {
        if let shouldRecordResponseToFile = shouldRecordResponseToFile, shouldRecordResponseToFile == true
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
