//
//  DatabaseService.swift
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
import RealmSwift
import Realm

class DatabaseService: NSObject {
    let realm = DatabaseService.prepareRealm()

    fileprivate class func prepareRealmConfig() -> Realm.Configuration {
        // The app group may be not accessible for testing purposes. That's why we added a failover below.
        guard let appGroupIdentifier = AppGroupConfigurator.identifier,
              let appGroupURL: URL = FileManager.default.containerURL(forSecurityApplicationGroupIdentifier: appGroupIdentifier)
        else {
            return Realm.Configuration.defaultConfiguration
        }

        let realmURL = appGroupURL.appendingPathComponent("db.realm")
        var configuration = Realm.Configuration.defaultConfiguration
        let originalDefaultRealmURL = configuration.fileURL
        configuration.fileURL = realmURL

        if let defaultURL = originalDefaultRealmURL, FileManager.default.fileExists(atPath: defaultURL.path) && !FileManager.default.fileExists(atPath: realmURL.path) {
            do {
                try FileManager.default.moveItem(atPath: defaultURL.path, toPath: realmURL.path)
            } catch let error as NSError {
                Logger.log(.error, "Realm migration error: \(error)")
            }
        }

        return configuration
    }

    fileprivate class func prepareRealm() -> Realm {
        let realmConfiguration = prepareRealmConfig()
        do {

            return try Realm(configuration: realmConfiguration)
        } catch let realmError {
            Logger.log(.error, "Realm error error: \(realmError)")
            do {
                let url = realmConfiguration.fileURL
                try FileManager.default.removeItem(at: url!)
            } catch let fileManagerError {
                Logger.log(.error, "File manager error: \(fileManagerError)")
            }
        }
        return try! Realm(configuration: realmConfiguration)
    }

    func saveCreationUploadSessionToDatabase(_ creationUploadSession: CreationUploadSession) {
        let creationUploadSessionEntity = getUploadSessionEntityFromCreationUploadSession(creationUploadSession)

        if let creationUploadSessionEntityFromDatabase = fetchASingleCreationUploadSessionWithLocalIdentifier(creationUploadSession.localIdentifier) {
            do {
                try realm.write({ () -> Void in
                    deleteOldDatabaseObjects(creationUploadSessionEntityFromDatabase)
                })
            } catch let error {
                print(error)
            }
        }

        do {
            try realm.write({ () -> Void in
                realm.add(creationUploadSessionEntity, update: true)
            })
        } catch let error {
            print(error)
        }
    }

    func deleteOldDatabaseObjects(_ creationUploadSessionEntity: CreationUploadSessionEntity) {
        if let creationEntity = creationUploadSessionEntity.creationEntity {
            realm.delete(creationEntity)
        }
        if let creationUploadEntity = creationUploadSessionEntity.creationUploadEntity {
            realm.delete(creationUploadEntity)
        }
        if let creationDataEntity = creationUploadSessionEntity.creationDataEntity {
            realm.delete(creationDataEntity)
        }
    }

    func fetchAllCreationUploadSessionEntities() -> Array<CreationUploadSessionEntity> {
        let realmObjects = realm.objects(CreationUploadSessionEntity.self)
        var creationUploadSessionEntitiesArray = [CreationUploadSessionEntity]()

        for entity in realmObjects {
            creationUploadSessionEntitiesArray.append(entity)
        }
        return creationUploadSessionEntitiesArray
    }

    func fetchAllCreationUploadSessions(_ requestSender: RequestSender) -> Array<CreationUploadSession> {
        let sessionEntities = fetchAllCreationUploadSessionEntities()
        var sessions = [CreationUploadSession]()

        for entity in sessionEntities {
            let session = CreationUploadSession(creationUploadSessionEntity: entity, requestSender: requestSender)
            sessions.append(session)
        }

        return sessions
    }

    func fetchASingleCreationUploadSessionWithLocalIdentifier(_ localIdentifier: String) -> CreationUploadSessionEntity? {
        let creationUploadSessionEntities = realm.objects(CreationUploadSessionEntity.self).filter("localIdentifier = %@", localIdentifier)
        return creationUploadSessionEntities.first
    }

    func getAllActiveUploadSessions(_ requestSender: RequestSender) -> Array<CreationUploadSession> {
        var activeUploadSessions = [CreationUploadSession]()

        let predicate = NSPredicate(format: "stateRaw < \(CreationUploadSessionState.serverNotified.rawValue)")
        let uploadSessionEntities = realm.objects(CreationUploadSessionEntity.self).filter(predicate)

        for uploadSessionEntity in uploadSessionEntities {
            activeUploadSessions.append(CreationUploadSession(creationUploadSessionEntity: uploadSessionEntity, requestSender: requestSender))
        }

        return activeUploadSessions
    }

    func getAllFinishedUploadSessions(_ requestSender: RequestSender) -> Array<CreationUploadSession> {
        var finishedUploadSessions = [CreationUploadSession]()
        let predicate = NSPredicate(format: "stateRaw >= \(CreationUploadSessionState.serverNotified.rawValue)")
        let uploadSessionEntities = realm.objects(CreationUploadSessionEntity.self).filter(predicate)

        for uploadSessionEntity in uploadSessionEntities {
            finishedUploadSessions.append(CreationUploadSession(creationUploadSessionEntity: uploadSessionEntity, requestSender: requestSender))
        }

        return finishedUploadSessions
    }

    func getAllActiveUploadSessionsPublicData(_ requestSender: RequestSender) -> Array<CreationUploadSessionPublicData> {
        let activeUploads = getAllActiveUploadSessions(requestSender)
        var activeUploadsPublicData = [CreationUploadSessionPublicData]()

        for activeUpload in activeUploads {
            activeUploadsPublicData.append(CreationUploadSessionPublicData(creationUploadSession: activeUpload))
        }
        return activeUploadsPublicData
    }

    func getAllFinishedUploadSessionPublicData(_ requestSender: RequestSender) -> Array<CreationUploadSessionPublicData> {
        let finishedUploads = getAllFinishedUploadSessions(requestSender)
        var finishedUploadsPublicData = [CreationUploadSessionPublicData]()

        for finishedUpload in finishedUploads {
            finishedUploadsPublicData.append(CreationUploadSessionPublicData(creationUploadSession: finishedUpload))
        }
        return finishedUploadsPublicData
    }

    func removeUploadSession(withIdentifier identifier: String) {
        if let entity = realm.object(ofType: CreationUploadSessionEntity.self, forPrimaryKey: identifier) {
            do {
                try realm.write {
                    realm.delete(entity)
                }
            } catch let error {
                Logger.log(.error, "Error during removing upload session: \(error)")
            }
        }
    }

    func removeAllUploadSessions() {
        do {
            try realm.write {
                realm.deleteAll()
            }
        } catch let error {
            Logger.log(.error, "Error duting database clear: \(error)")
        }
    }

    // MARK: - Transforms
    fileprivate func getUploadSessionEntityFromCreationUploadSession(_ creationUploadSession: CreationUploadSession) -> CreationUploadSessionEntity {
        let creationUploadSessionEntity = CreationUploadSessionEntity()

        creationUploadSessionEntity.stateRaw.value = creationUploadSession.state.rawValue
        creationUploadSessionEntity.imageFileName = creationUploadSession.imageFileName
        creationUploadSessionEntity.relativeImageFilePath = creationUploadSession.relativeFilePath
        creationUploadSessionEntity.creationDataEntity = getNewCreationDataEntityFromCreationData(creationUploadSession.creationData)
        creationUploadSessionEntity.localIdentifier = creationUploadSession.localIdentifier

        if let creation = creationUploadSession.creation {
            creationUploadSessionEntity.creationEntity = getCreationEntityFromCreation(creation)
        }

        if let creationUpload = creationUploadSession.creationUpload {
            creationUploadSessionEntity.creationUploadEntity = getCreationUploadEntityFromCreationUpload(creationUpload)
        }

        return creationUploadSessionEntity
    }

    fileprivate func getNewCreationDataEntityFromCreationData(_ newCreationData: NewCreationData) -> NewCreationDataEntity {
        let newCreationDataEntity = NewCreationDataEntity()

        newCreationDataEntity.localIdentifier = newCreationData.localIdentifier
        newCreationDataEntity.reflectionText = newCreationData.reflectionText
        newCreationDataEntity.reflectionVideoUrl = newCreationData.reflectionVideoUrl
        newCreationDataEntity.dataTypeRaw.value = newCreationData.dataType.rawValue
        newCreationDataEntity.storageTypeRaw.value = newCreationData.storageType.rawValue
        newCreationDataEntity.uploadExtensionRaw = newCreationData.uploadExtension.stringValue

        newCreationData.creatorIds?.forEach {
            creatorIdentifier in

            let idEntity = CreatorIdString()
            idEntity.creatorIdString = creatorIdentifier
            newCreationDataEntity.creatorIds.append(idEntity)
        }

        newCreationData.galleryIds?.forEach {
            galleryIdentifier in

            let idEntity = GalleryIdString()
            idEntity.galleryIdString = galleryIdentifier
            newCreationDataEntity.galleryIds.append(idEntity)
        }

        newCreationDataEntity.creationYear.value = newCreationData.creationYear
        newCreationDataEntity.creationMonth.value = newCreationData.creationMonth

        return newCreationDataEntity
    }

    fileprivate func getCreationEntityFromCreation(_ creation: Creation) -> CreationEntity {
        let creationEntity = CreationEntity()

        creationEntity.identifier = creation.identifier
        creationEntity.name = creation.name

        for name in creation.translatedNames {
            creationEntity.translatedNameEntities.append(getNameTranslationObjectEntityFromNameTranslationObject(name))
        }

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

        for (key, value) in creation.createdAtAgePerCreator {
            let createdAtAgePerCreatorDict = CreatedAtAgePerCreatorDict()
            createdAtAgePerCreatorDict.key = key
            createdAtAgePerCreatorDict.value = value
            creationEntity.createdAtAgePerCreatorDict?.append(createdAtAgePerCreatorDict)
        }

        creationEntity.reflectionText = creation.reflectionText
        creationEntity.reflectionVideoUrl = creation.reflectionVideoUrl

        creationEntity.imageOriginalUrl = creation.imageOriginalUrl
        creationEntity.imageFullViewUrl = creation.imageFullViewUrl
        creationEntity.imageListViewUrl = creation.imageListViewUrl
        creationEntity.imageListViewRetinaUrl = creation.imageListViewRetinaUrl
        creationEntity.imageMatrixViewUrl = creation.imageMatrixViewUrl
        creationEntity.imageMatrixViewRetinaUrl = creation.imageMatrixViewRetinaUrl
        creationEntity.imageGalleryMobileUrl = creation.imageGalleryMobileUrl
        creationEntity.imageExploreMobileUrl = creation.imageExploreMobileUrl
        creationEntity.imageShareUrl = creation.imageShareUrl

        creationEntity.video480Url = creation.video480Url
        creationEntity.video720Url = creation.video720Url

        creationEntity.objFileUrl = creation.objFileUrl
        creationEntity.playIFrameUrl = creation.playIFrameUrl
        creationEntity.playIFrameUrlIsMobileReady.value = creation.playIFrameUrlIsMobileReady

        creationEntity.contentType = creation.contentType
        creation.tags?.forEach {
            creationTag in
            let tagString = CreationTagString()
            tagString.tag = creationTag
            creationEntity.tags.append(tagString)
        }

        return creationEntity
    }

    fileprivate func getNameTranslationObjectEntityFromNameTranslationObject(_ nameTranslationObject: NameTranslationObject) -> NameTranslationObjectEntity {
        let nameTranslationObjectEntity = NameTranslationObjectEntity()

        nameTranslationObjectEntity.code = nameTranslationObject.code
        nameTranslationObjectEntity.name = nameTranslationObject.name
        nameTranslationObjectEntity.original.value = nameTranslationObject.original

        return nameTranslationObjectEntity
    }

    fileprivate func getCreationUploadEntityFromCreationUpload(_ creationUpload: CreationUpload) -> CreationUploadEntity {
       let creationUploadEntity = CreationUploadEntity()

        creationUploadEntity.identifier = creationUpload.identifier
        creationUploadEntity.uploadUrl = creationUpload.uploadUrl
        creationUploadEntity.contentType = creationUpload.contentType
        creationUploadEntity.pingUrl = creationUpload.pingUrl
        creationUploadEntity.completedAt = creationUpload.completedAt

        return creationUploadEntity
    }
}
