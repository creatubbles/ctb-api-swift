//
//  ResponseHandler.swift
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
import ObjectMapper

class ResponseHandler: NSObject
{
    var shouldRecordResponseToFile: Bool?
    var outputFileName: String?
    
    func handleResponse(_ response: Dictionary<String, AnyObject>?, error: Error?)
    {
        
    }
    
    func executeOnMainQueue(_ closure: @escaping () -> ()) {
        DispatchQueue.main.async { 
            closure()
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
