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
    var databaseService: DatabaseService
    
    override init()
    {
        self.databaseService = DatabaseService()
    }
    
    func saveCreationUploadSessionToDatabase(creationUploadSession: CreationUploadSession)
    {
        self.databaseService.saveCreationUploadSessionToDatabase(creationUploadSession)
    }
    
    func fetchAllCreationUploadSessionEntities() -> Array<CreationUploadSessionEntity>
    {
        let creationsEntitiesArray = databaseService.fetchAllCreationUploadSessionEntities()
        
        return creationsEntitiesArray
    }
    
    func fetchAllCreationUploadSessions(requestSender: RequestSender) -> Array<CreationUploadSession>
    {
        let creationSessions = databaseService.fetchAllCreationUploadSessions(requestSender)
        
        return creationSessions
    }
    
    func fetchASincleCreationUploadSessionEntityWithCreationIdentifier(creationIdentifier: String) -> CreationUploadSessionEntity?
    {
        let creationUploadSessionEntity = databaseService.fetchASingleCreationUploadSessionWithCreationIdentifier(creationIdentifier)
        
        return creationUploadSessionEntity
    }
}
