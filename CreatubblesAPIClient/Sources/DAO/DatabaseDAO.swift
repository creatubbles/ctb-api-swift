//
//  DatabaseDAO.swift
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

class DatabaseDAO: NSObject, APIClientDAO {
    private let databaseService = DatabaseService()

    required init(dependencies: DAODependencies) {
        //Required by APIClientDAO. Intentionally left empty.
    }

    override init() {
        //Intentionally left empty
    }

    func saveCreationUploadSessionToDatabase(_ creationUploadSession: CreationUploadSession) {
        databaseService.saveCreationUploadSessionToDatabase(creationUploadSession)
    }

    func fetchAllCreationUploadSessions(_ requestSender: RequestSender) -> Array<CreationUploadSession> {
        return databaseService.fetchAllCreationUploadSessions(requestSender)
    }

    func fetchASingleCreationUploadSessionWithLocalIdentifier(_ localIdentifier: String) -> CreationUploadSessionEntity? {
        return databaseService.fetchASingleCreationUploadSessionWithLocalIdentifier(localIdentifier)
    }

    func fetchAllFinishedUploadSessions(_ requestSender: RequestSender) -> Array<CreationUploadSession> {
        return databaseService.getAllFinishedUploadSessions(requestSender)
    }

    func fetchAllActiveUploadSessions(_ requestSender: RequestSender) -> Array<CreationUploadSession> {
        return databaseService.getAllActiveUploadSessions(requestSender)
    }

    func getAllActiveUploadSessionsPublicData(_ requestSender: RequestSender) -> Array<CreationUploadSessionPublicData> {
        return databaseService.getAllActiveUploadSessionsPublicData(requestSender)
    }

    func getAllFinishedUploadSessionsPublicData(_ requestSender: RequestSender) -> Array<CreationUploadSessionPublicData> {
        return databaseService.getAllFinishedUploadSessionPublicData(requestSender)
    }

    func removeUploadSession(withIdentifier identifier: String) {
        databaseService.removeUploadSession(withIdentifier: identifier)
    }

    func removeAllUploadSessions() {
        databaseService.removeAllUploadSessions()
    }
}
