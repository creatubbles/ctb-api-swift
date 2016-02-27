//
//  DatabaseDAO.swift
//  CreatubblesAPIClient
//
//  Created by Nomtek on 22.02.2016.
//  Copyright © 2016 Nomtek. All rights reserved.
//

import UIKit

class DatabaseDAO: NSObject
{
    let databaseService = DatabaseService()
    
    func saveCreationUploadSessionToDatabase(creationUploadSession: CreationUploadSession)
    {
        databaseService.saveCreationUploadSessionToDatabase(creationUploadSession)
    }
    
    func fetchAllCreationUploadSessions(requestSender: RequestSender) -> Array<CreationUploadSession>
    {
        return databaseService.fetchAllCreationUploadSessions(requestSender)
    }
    
    func fetchASincleCreationUploadSessionEntityWithCreationIdentifier(creationIdentifier: String) -> CreationUploadSessionEntity?
    {
        return databaseService.fetchASingleCreationUploadSessionWithCreationIdentifier(creationIdentifier)
    }
}
