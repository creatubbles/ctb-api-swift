//
//  DatabaseService.swift
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
import RealmSwift
import Realm

class DatabaseService: NSObject
{
    let realm = DatabaseService.prepareRealm()
    
    private class func prepareRealm() -> Realm
    {
        do
        {
            let r = try Realm()
            return r
        }
        catch let realmError
        {
            Logger.log.error("Realm error error: \(realmError)")
            do
            {
                let path = RLMRealmConfiguration.defaultConfiguration().path
                try NSFileManager.defaultManager().removeItemAtPath(path!)
            }
            catch let fileManagerError
            {
                Logger.log.error("File manager error: \(fileManagerError)")
            }
        }
        return try! Realm()
    }
    
    func saveCreationUploadSessionToDatabase(creationUploadSession: CreationUploadSession)
    {
        let creationUploadSessionEntity = getUploadSessionEntityFromCreationUploadSession(creationUploadSession)
        
        if let creationUploadSessionEntityFromDatabase = fetchASingleCreationUploadSessionWithLocalIdentifier(creationUploadSession.localIdentifier)
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
    
    func fetchASingleCreationUploadSessionWithLocalIdentifier(localIdentifier: String) -> CreationUploadSessionEntity?
    {
        let creationUploadSessionEntities = realm.objects(CreationUploadSessionEntity).filter("localIdentifier = %@", localIdentifier)
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
    
    func getAllActiveUploadSessionsPublicData(requestSender: RequestSender) -> Array<CreationUploadSessionPublicData>
    {
        let activeUploads = getAllActiveUploadSessions(requestSender)
        var activeUploadsPublicData = [CreationUploadSessionPublicData]()
        
        for activeUpload in activeUploads
        {
            activeUploadsPublicData.append(CreationUploadSessionPublicData(creationUploadSession: activeUpload))
        }
        return activeUploadsPublicData
    }
    
    func getAllFinishedUploadSessionPublicData(requestSender: RequestSender) -> Array<CreationUploadSessionPublicData>
    {
        let finishedUploads = getAllFinishedUploadSessions(requestSender)
        var finishedUploadsPublicData = [CreationUploadSessionPublicData]()
        
        for finishedUpload in finishedUploads
        {
            finishedUploadsPublicData.append(CreationUploadSessionPublicData(creationUploadSession: finishedUpload))
        }
        return finishedUploadsPublicData
    }
    
    //MARK: - Transforms
    private func getUploadSessionEntityFromCreationUploadSession(creationUploadSession: CreationUploadSession) -> CreationUploadSessionEntity
    {
        let creationUploadSessionEntity = CreationUploadSessionEntity()
        
        creationUploadSessionEntity.stateRaw.value = creationUploadSession.state.rawValue
        creationUploadSessionEntity.imageFileName = creationUploadSession.imageFileName
        creationUploadSessionEntity.relativeImageFilePath = creationUploadSession.relativeImageFilePath
        creationUploadSessionEntity.creationDataEntity = getNewCreationDataEntityFromCreationData(creationUploadSession.creationData)
        creationUploadSessionEntity.localIdentifier = creationUploadSession.localIdentifier
        
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
        newCreationDataEntity.dataTypeRaw.value = newCreationData.dataType.rawValue
        
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
        creationEntity.imageStatus.value = creation.imageStatus
                
        creationEntity.bubblesCount.value = creation.bubblesCount
        creationEntity.commentsCount.value = creation.commentsCount
        creationEntity.viewsCount.value = creation.viewsCount
        creationEntity.lastBubbledAt = creation.lastBubbledAt
        creationEntity.lastCommentedAt = creation.lastCommentedAt
        creationEntity.lastSubmittedAt = creation.lastSubmittedAt
        creationEntity.approved.value = creation.approved
        creationEntity.shortUrl = creation.shortUrl
        creationEntity.createdAtAge = creation.createdAtAge

        creationEntity.imageOriginalUrl = creation.imageOriginalUrl
        creationEntity.imageFullViewUrl = creation.imageFullViewUrl
        creationEntity.imageListViewUrl = creation.imageListViewUrl
        creationEntity.imageListViewRetinaUrl = creation.imageListViewRetinaUrl
        creationEntity.imageMatrixViewUrl = creation.imageMatrixViewUrl
        creationEntity.imageMatrixViewRetinaUrl = creation.imageMatrixViewRetinaUrl
        creationEntity.imageGalleryMobileUrl = creation.imageGalleryMobileUrl
        creationEntity.imageExploreMobileUrl = creation.imageExploreMobileUrl
        creationEntity.imageShareUrl = creation.imageShareUrl
        
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
