//
//  DatabaseService.swift
//  CreatubblesAPIClient
//
//  Created by Nomtek on 19.02.2016.
//  Copyright © 2016 Nomtek. All rights reserved.
//

import UIKit
import RealmSwift

class DatabaseService: NSObject
{
    let realm = try! Realm()
    
    func saveCreationUploadSessionToDatabase(creationUploadSession: CreationUploadSession)
    {
        let creationUploadSessionEntity = getUploadSessionEntityFromCreationUploadSession(creationUploadSession)
        
        if let creationUploadSessionEntityFromDatabase = fetchASingleCreationUploadSessionWithCreationIdentifier((creationUploadSession.creation?.identifier)!)
        {
            do
            {
                try realm.write({ () -> Void in
                    deleteOldDatabaseObjects(creationUploadSessionEntityFromDatabase)
                })                            
            }
            catch let error
            {
                print(error)
            }
        }

        do
        {
            try realm.write({ () -> Void in
                realm.add(creationUploadSessionEntity, update: true)
            })
        }
        catch let error
        {
            print(error)
        }
    }
    
    
    func deleteOldDatabaseObjects(creationUploadSessionEntity: CreationUploadSessionEntity)
    {
        if let creationEntity = creationUploadSessionEntity.creationEntity
        {
            realm.delete(creationEntity)
        }
        if let creationUploadEntity = creationUploadSessionEntity.creationUploadEntity
        {
            realm.delete(creationUploadEntity)
        }
        if let creationDataEntity = creationUploadSessionEntity.creationDataEntity
        {
            realm.delete(creationDataEntity)
        }
    }
    
    func fetchAllCreationUploadSessionEntities() -> Array<CreationUploadSessionEntity>
    {
        let realmObjects = realm.objects(CreationUploadSessionEntity)
        var creationUploadSessionEntitiesArray = [CreationUploadSessionEntity]()
        
        for entity in realmObjects
        {
            creationUploadSessionEntitiesArray.append(entity)
        }
        return creationUploadSessionEntitiesArray
    }
    
    func fetchAllCreationUploadSessions(requestSender: RequestSender) -> Array<CreationUploadSession>
    {
        let sessionEntities = fetchAllCreationUploadSessionEntities()
        var sessions = [CreationUploadSession]()
        
        for entity in sessionEntities
        {
            let session = CreationUploadSession(creationUploadSessionEntity: entity, requestSender: requestSender)
            sessions.append(session)
        }
        
        return sessions
    }
    
    func fetchASingleCreationUploadSessionWithCreationIdentifier(creationIdentifier: String) -> CreationUploadSessionEntity?
    {
        let creationUploadSessionEntities = realm.objects(CreationUploadSessionEntity).filter("identifier = %@", creationIdentifier)
        return creationUploadSessionEntities.first
    }
    
    func getAllActiveUploadSessions(requestSender: RequestSender) -> Array<CreationUploadSession>
    {
        var activeUploadSessions = [CreationUploadSession]()

        let predicate = NSPredicate(format: "stateRaw < \(CreationUploadSessionState.ServerNotified.rawValue)")
        let uploadSessionEntities = realm.objects(CreationUploadSessionEntity).filter(predicate)
        
        for uploadSessionEntity in uploadSessionEntities
        {
            activeUploadSessions.append(CreationUploadSession(creationUploadSessionEntity: uploadSessionEntity, requestSender: requestSender))
        }
        
        return activeUploadSessions
    }
    
    func getAllFinishedUploadSessions(requestSender: RequestSender) -> Array<CreationUploadSession>
    {
        var finishedUploadSessions = [CreationUploadSession]()
        let predicate = NSPredicate(format: "stateRaw >= \(CreationUploadSessionState.ServerNotified.rawValue)")
        let uploadSessionEntities = realm.objects(CreationUploadSessionEntity).filter(predicate)
        
        for uploadSessionEntity in uploadSessionEntities
        {
            finishedUploadSessions.append(CreationUploadSession(creationUploadSessionEntity: uploadSessionEntity, requestSender: requestSender))
        }
        
        return finishedUploadSessions
    }
    
    //MARK: - Transforms
    private func getUploadSessionEntityFromCreationUploadSession(creationUploadSession: CreationUploadSession) -> CreationUploadSessionEntity
    {
        let creationUploadSessionEntity = CreationUploadSessionEntity()
        
        creationUploadSessionEntity.stateRaw.value = creationUploadSession.state.rawValue
        creationUploadSessionEntity.imageFileName = creationUploadSession.imageFileName
        creationUploadSessionEntity.relativeImageFilePath = creationUploadSession.relativeImageFilePath
        creationUploadSessionEntity.creationDataEntity = getNewCreationDataEntityFromCreationData(creationUploadSession.creationData)
        creationUploadSessionEntity.identifier = creationUploadSession.creation?.identifier
        
        if let creation = creationUploadSession.creation
        {
            creationUploadSessionEntity.creationEntity = getCreationEntityFromCreation(creation)
        }
        
        if let creationUpload = creationUploadSession.creationUpload
        {
            creationUploadSessionEntity.creationUploadEntity = getCreationUploadEntityFromCreationUpload(creationUpload)
        }
        
        return creationUploadSessionEntity
    }
    
    private func getNewCreationDataEntityFromCreationData(newCreationData: NewCreationData) -> NewCreationDataEntity
    {
        let newCreationDataEntity = NewCreationDataEntity()
        
        newCreationDataEntity.reflectionText = newCreationData.reflectionText
        newCreationDataEntity.reflectionVideoUrl = newCreationData.reflectionVideoUrl
        newCreationDataEntity.galleryId = newCreationData.galleryId
        
        if let _ = newCreationData.creatorIds
        {
            for creatorId in newCreationData.creatorIds!
            {
                let creatorIdEntity = CreatorIdString()
                creatorIdEntity.creatorIdString = creatorId
                newCreationDataEntity.creatorIds.append(creatorIdEntity)
            }
        }
        
        newCreationDataEntity.creationYear.value = newCreationData.creationYear
        newCreationDataEntity.creationMonth.value = newCreationData.creationMonth
        
        return newCreationDataEntity
    }
    
    private func getCreationEntityFromCreation(creation: Creation) -> CreationEntity
    {
        let creationEntity = CreationEntity()
        
        creationEntity.identifier = creation.identifier
        creationEntity.name = creation.name
        creationEntity.createdAt = creation.createdAt
        creationEntity.updatedAt = creation.updatedAt
        creationEntity.createdAtYear.value = creation.createdAtYear
        creationEntity.createdAtMonth.value = creation.createdAtMonth
        creationEntity.imageStatus.value = creation.imageStatus
        
        if let image = creation.image
        {
            creationEntity.image = image
        }
        
        creationEntity.bubblesCount.value = creation.bubblesCount
        creationEntity.commentsCount.value = creation.commentsCount
        creationEntity.viewsCount.value = creation.viewsCount
        creationEntity.lastBubbledAt = creation.lastBubbledAt
        creationEntity.lastCommentedAt = creation.lastCommentedAt
        creationEntity.lastSubmittedAt = creation.lastSubmittedAt
        creationEntity.approved.value = creation.approved
        creationEntity.shortUrl = creation.shortUrl
        creationEntity.createdAtAge = creation.createdAtAge
        
        return creationEntity
    }
    
    private func getCreationUploadEntityFromCreationUpload(creationUpload: CreationUpload) -> CreationUploadEntity
    {
       let creationUploadEntity = CreationUploadEntity()
        
        creationUploadEntity.identifier = creationUpload.identifier
        creationUploadEntity.uploadUrl = creationUpload.uploadUrl
        creationUploadEntity.contentType = creationUpload.contentType
        creationUploadEntity.pingUrl = creationUpload.pingUrl
        creationUploadEntity.completedAt = creationUpload.completedAt
        
        return creationUploadEntity
    }
}
