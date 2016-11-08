//
//  UploadManager.swift
//  CreatubblesAPIClient
//
//  Created by Dawid Płatek on 28.10.2016.
//  Copyright © 2016 Nomtek. All rights reserved.
//

import UIKit

class UploadManager: NSObject {
    private lazy var session: URLSession = {
        var configuration = URLSessionConfiguration.default
        if let identifier = self.settings.backgroundSessionConfigurationIdentifier {
            configuration = URLSessionConfiguration.background(withIdentifier: identifier)
        }
        
        configuration.httpAdditionalHeaders = HTTPHeadersBuilder.defaultHTTPHeaders
        return URLSession(configuration: configuration, delegate: self, delegateQueue: nil)
    }()
    
    private let settings: APIClientSettings
    var uploadTasks: [URLSessionTask: UploadTask] = [:]
    
    var backgroundCompletionHandler: (() -> Void)?
    
    public init(settings: APIClientSettings) {
        self.settings = settings
    }
    
    private var uploadSessionConfiguration: URLSessionConfiguration {
        if let identifier = settings.backgroundSessionConfigurationIdentifier {
            return URLSessionConfiguration.background(withIdentifier: identifier)
        } else {
            return URLSessionConfiguration.default
        }

    }
    
    func upload(request: URLRequest, fromData data: Data) -> UploadTask {
        let isBackgroundSession = session.configuration.identifier != nil
        
        if isBackgroundSession {
            let fileManager = FileManager.default
            let tempDirectoryURL = URL(fileURLWithPath: NSTemporaryDirectory())
            let directoryURL = tempDirectoryURL.appendingPathComponent("com.creatubbles.uploads")
            let fileName = UUID().uuidString
            let fileURL = directoryURL.appendingPathComponent(fileName)
            
            do {
                try fileManager.createDirectory(at: directoryURL, withIntermediateDirectories: true, attributes: nil)
                try data.write(to: fileURL)
            } catch { }
            
            
            return upload(request: request, fromFile: fileURL)
        } else {
            let task = session.uploadTask(with: request, from: data)
            let uploadTask = UploadTask(task: task)
            uploadTasks[task] = uploadTask
            task.resume()
            
            return uploadTask
        }
    }
    
    func upload(request: URLRequest, fromFile fileUrl: URL) -> UploadTask {
        let task = session.uploadTask(with: request, fromFile: fileUrl)
        let uploadTask = UploadTask(task: task)
        uploadTasks[task] = uploadTask
        task.resume()
        
        return uploadTask
    }
}

extension UploadManager: URLSessionTaskDelegate {
    func urlSession(_ session: URLSession, task: URLSessionTask, didCompleteWithError error: Error?) {
        guard let uploadTask = uploadTasks[task] else { return }
        DispatchQueue.main.async {
            uploadTask.completionHandler?(error)
        }

        uploadTasks.removeValue(forKey: task)
    }
    
    func urlSession(_ session: URLSession, task: URLSessionTask, didSendBodyData bytesSent: Int64, totalBytesSent: Int64, totalBytesExpectedToSend: Int64) {
        guard let uploadTask = uploadTasks[task] else { return }
        uploadTask.urlSession(session, task: task, didSendBodyData: bytesSent, totalBytesSent: totalBytesSent, totalBytesExpectedToSend: totalBytesExpectedToSend)
    }
    
    func urlSession(_ session: URLSession, task: URLSessionTask, didReceive challenge: URLAuthenticationChallenge, completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Swift.Void) {
        completionHandler(.performDefaultHandling, nil)
    }
    
    func urlSessionDidFinishEvents(forBackgroundURLSession session: URLSession) {
        backgroundCompletionHandler?()
    }
}
