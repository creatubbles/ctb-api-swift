//
//  CreatubblesAPIClientDefaults.swift
//  CreatubblesAPIClient
//
//  Created by Michal Miedlarz on 18.02.2016.
//  Copyright © 2016 Nomtek. All rights reserved.
//

import UIKit

//MARK: - Typealiases
public typealias ErrorClousure = (ErrorType?) -> (Void)
public typealias UserClousure = (User?, ErrorType?) -> (Void)
public typealias UsersClousure = (Array<User>?, ErrorType?) -> (Void)
public typealias CreationClousure = (Creation?, ErrorType?) -> (Void)
public typealias CreationsClousure = (Array<Creation>?, ErrorType?) -> (Void)
public typealias GalleryClousure = (Gallery?, ErrorType?) -> (Void)
public typealias GalleriesClousure = (Array<Gallery>?, ErrorType?) -> (Void)

//MARK: - Enums
public enum Gender: Int
{
    case Male = 0
    case Female = 1
}

public enum SortOrder: String
{
    case Popular = "popular"
    case Recent = "recent"
}

//MARK: - Structs
public struct PagingData
{
    public var page: Int
    public var pageSize: Int
}

public struct NewCreatorData
{
    public var name: String
    public var displayName: String
    public var birthYear: Int
    public var birthMonth: Int
    public var countryCode: String
    public var gender: Gender
}

public struct NewCreationData
{
    init(image: UIImage)
    {
        self.image = image        
    }
    
    init(creationDataEntity: NewCreationDataEntity, image: UIImage)
    {
        self.image = image
        self.name = creationDataEntity.name
        self.reflectionText = creationDataEntity.reflectionText
        self.reflectionVideoUrl = creationDataEntity.reflectionVideoUrl
        self.galleryId = creationDataEntity.galleryId
        
        for creatorId in creationDataEntity.creatorIds
        {
            self.creatorIds?.append(creatorId.creatorIdString!)
        }
        self.creationMonth = creationDataEntity.creationMonth.value
        self.creationYear = creationDataEntity.creationYear.value
    }
    
    public var image: UIImage
    public var name: String? = nil
    public var reflectionText: String? = nil
    public var reflectionVideoUrl: String? = nil
    public var galleryId: String? = nil
    public var creatorIds: Array<String>? = nil
    public var creationYear: Int? = nil
    public var creationMonth: Int? = nil
}

public struct NewGalleryData
{
    public var name: String
    public var galleryDescription: String
    public var openForAll: Bool
    public var ownerId: String?
}
