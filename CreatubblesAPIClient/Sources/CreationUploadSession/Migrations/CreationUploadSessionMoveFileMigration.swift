//
//  CreationUploadSessionMoveFilesMigration.swift
//  CreatubblesAPIClient
//
//  Copyright (c) 2017 Creatubbles Pte. Ltd.
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

class CreationUploadSessionMoveFileMigration: CreationUploadSessionMigrating {
    var executed: Bool = false
    private(set) var error: Error?
    fileprivate let databaseDAO: DatabaseDAO
    fileprivate let session: CreationUploadSession
    
    required init(session: CreationUploadSession, databaseDAO: DatabaseDAO) {
        self.databaseDAO = databaseDAO
        self.session = session
    }
    
    func start() {
        let fileManager = FileManager.default
        
        guard let fileURL = session.creationData.url, shouldBeMigrated() else { return }
        
        let newFileURL = fileURL.appendingPathExtension(session.creationData.uploadExtension.stringValue)
        
        if fileManager.fileExists(atPath: fileURL.path) {
            do {
                try fileManager.moveItem(at: fileURL, to: newFileURL)
                session.creationData.url = newFileURL
                session.configureImageFileName(newImageFileName: newFileURL.lastPathComponent)
                databaseDAO.saveCreationUploadSessionToDatabase(session)
                executed = true
            } catch let error as NSError {
                Logger.log(.error, "Cannot move creation file from:\n\(fileURL)\nto:\n\(newFileURL)\nReason: \(error)")
                self.error = error
            }
        }
    }
    
    private func shouldBeMigrated() -> Bool {
        guard let fileURL = session.creationData.url else { return false }
        if fileURL.pathExtension == session.creationData.uploadExtension.stringValue { return false }
        
        return true
    }
}
