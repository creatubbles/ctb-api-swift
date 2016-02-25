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
        
        creationUploadSessionEntity.isActive = creationUploadSession.isActive
        creationUploadSessionEntity.stateRaw = creationUploadSession.state.rawValue
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
    
    func fetchAllCreationUploadSessionEntities() -> Array<CreationUploadSessionEntity>
    {
        let realm = try! Realm()
        let creationUploadSessionEntitiesArray = Array(realm.objects(CreationUploadSessionEntity))
        
        return creationUploadSessionEntitiesArray
    }
    
    func fetchASincleCreationUploadSessionWithCreationIdentifier(creationIdentifier: String) -> CreationEntity?
    {
        let creationUploadSessionEntities = realm.objects(CreationUploadSessionEntity).filter("creationEntityIdentifier = %@", creationIdentifier)
        if(creationUploadSessionEntities.count == 1)
        {
            return (creationUploadSessionEntities.first?.creationEntity)!
        }
        else
        {
            NSLog("Incorrect number of objects in RLMResults array when fetching a single Creation Upload Session with id: %@", creationIdentifier)
            return nil
        }
    }
    
    private func getNewCreationDataEntityFromCreationData(newCreationData: NewCreationData) -> NewCreationDataEntity
    {
        let newCreationDataEntity = NewCreationDataEntity()
        
        newCreationDataEntity.reflectionText = newCreationData.reflectionText
        newCreationDataEntity.reflectionVideoUrl = newCreationData.reflectionVideoUrl
        newCreationDataEntity.galleryId = newCreationData.galleryId
        
        for creatorId in newCreationData.creatorIds!
        {
            let creatorIdEntity = CreatorIdString()
            creatorIdEntity.creatorIdString = creatorId
            newCreationDataEntity.creatorIds?.append(creatorIdEntity)
        }
        
        newCreationDataEntity.creationYear = newCreationData.creationYear
        newCreationDataEntity.creationMonth = newCreationData.creationMonth
        
        return newCreationDataEntity
    }
    
    private func getCreationEntityFromCreation(creation: Creation) -> CreationEntity
    {
        let creationEntity = CreationEntity()
        
        creationEntity.identifier = creation.identifier
        creationEntity.name = creation.name
        creationEntity.createdAt = creation.createdAt
        creationEntity.updatedAt = creation.updatedAt
        creationEntity.createdAtYear = creation.createdAtYear
        creationEntity.createdAtMonth = creation.createdAtMonth
        creationEntity.imageStatus = creation.imageStatus
        creationEntity.image = creation.image
        creationEntity.bubblesCount = creation.bubblesCount
        creationEntity.commentsCount = creation.commentsCount
        creationEntity.viewsCount = creation.viewsCount
        creationEntity.lastBubbledAt = creation.lastBubbledAt
        creationEntity.lastCommentedAt = creation.lastCommentedAt
        creationEntity.lastSubmittedAt = creation.lastSubmittedAt
        creationEntity.approved = creation.approved
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
