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
        let creationUploadSessionEntity: CreationUploadSessionEntity = CreationUploadSessionEntity()
        
        if let creationUploadSessionEntityFromDatabase = fetchASingleCreationUploadSessionWithCreationIdentifier((creationUploadSession.creation?.identifier)!)
        {
            try! realm.write
            {
                deleteOldDatabaseObjects(creationUploadSessionEntityFromDatabase)
            }
        }
        
        creationUploadSessionEntity.isActive.value = creationUploadSession.isActive
        creationUploadSessionEntity.stateRaw.value = creationUploadSession.state.rawValue
        creationUploadSessionEntity.imageFileName = creationUploadSession.imageFileName
        creationUploadSessionEntity.relativeImageFilePath = creationUploadSession.relativeImageFilePath
        
        creationUploadSessionEntity.creationDataEntity = getNewCreationDataEntityFromCreationData(creationUploadSession.creationData)
        creationUploadSessionEntity.creationEntityIdentifier = creationUploadSession.creation?.identifier
        
        if let creation = creationUploadSession.creation
        {
            creationUploadSessionEntity.creationEntity = getCreationEntityFromCreation(creation)
        }
        
        if let creationUpload = creationUploadSession.creationUpload
        {
             creationUploadSessionEntity.creationUploadEntity = getCreationUploadEntityFromCreationUpload(creationUpload)
        }
        
        try! realm.write
        {
            realm.add(creationUploadSessionEntity, update: true)
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
        let realm = try! Realm()
        let realmObjects = realm.objects(CreationUploadSessionEntity)
        var creationUploadSessionEntitiesArray = [CreationUploadSessionEntity]()
        
        //creationUploadSessionEntitiesArray.append(realmObjects[0])
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
        let creationUploadSessionEntities = realm.objects(CreationUploadSessionEntity).filter("creationEntityIdentifier = %@", creationIdentifier)
        if(creationUploadSessionEntities.count == 1)
        {
            return (creationUploadSessionEntities.first)!
        }
        else
        {
            return nil
        }
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
