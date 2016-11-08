//
//  UploadTask.swift
//  CreatubblesAPIClient
//
//  Created by Dawid Płatek on 27.10.2016.
//  Copyright © 2016 Nomtek. All rights reserved.
//

import UIKit

typealias UploadProgressHandler = (Progress) -> Void
typealias UploadCompletionHandler = (Error?) -> Void

class UploadTask: NSObject, Cancelable {
    private var uploadProgress: Progress = Progress(totalUnitCount: 0)
    var uploadProgressHandler: UploadProgressHandler?
    var completionHandler: UploadCompletionHandler?
    
    let task: URLSessionTask
     
    init(task: URLSessionTask) {
        self.task = task
    }
    
    func cancel() {
        task.cancel()
    }
    
    func urlSession(_ session: URLSession, task: URLSessionTask, didSendBodyData bytesSent: Int64, totalBytesSent: Int64, totalBytesExpectedToSend: Int64) {
        uploadProgress.totalUnitCount = totalBytesExpectedToSend
        uploadProgress.completedUnitCount = totalBytesSent
        
        uploadProgressHandler?(uploadProgress)
    }
}
