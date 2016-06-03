//
//  CustomStyle.swift
//  CreatubblesAPIClient
//
//  Created by Michal Miedlarz on 03.06.2016.
//  Copyright © 2016 Nomtek. All rights reserved.
//

@objc
public class CustomStyle: NSObject, Identifiable
{
    public let identifier: String
    public let headerBackgroundIdentifier: String?
    public let bodyBackgroundIdentifier: String?
    public let fontName: String?
    public let bio: String?
    public let bodyColorsHex: Array<String>?
    public let headerColorsHex: Array<String>?
    public let bodyCreationURL: String?
    public let headerCreationURL: String?
    
    public let createdAt: NSDate
    public let updatedAt: NSDate
    
    public let userRelationship: Relationship?
    public let headerCreationRelationship: Relationship?
    public let bodyCreationRelationship: Relationship?
    
    public let user: User?
    public let headerCreation: Creation?
    public let bodyCreation: Creation?
    
    init(mapper: CustomStyleMapper, dataMapper: DataIncludeMapper? = nil)
    {
        identifier = mapper.identifier!
        
        headerBackgroundIdentifier = mapper.headerBackgroundIdentifier
        bodyBackgroundIdentifier = mapper.bodyBackgroundIdentifier
        fontName = mapper.fontName
        bio = mapper.bio
        bodyColorsHex = mapper.bodyColorsHex
        headerColorsHex = mapper.headerColorsHex
        bodyCreationURL = mapper.bodyCreationURL
        headerCreationURL = mapper.headerCreationURL
        
        createdAt = mapper.createdAt!
        updatedAt = mapper.updatedAt!
        
        userRelationship = MappingUtils.relationshipFromMapper(mapper.userRelationship)
        headerCreationRelationship = MappingUtils.relationshipFromMapper(mapper.headerCreationRelationship)
        bodyCreationRelationship = MappingUtils.relationshipFromMapper(mapper.bodyCreationRelationship)
        
        user = MappingUtils.objectFromMapper(dataMapper, relationship: userRelationship, type: User.self)
        headerCreation = MappingUtils.objectFromMapper(dataMapper, relationship: headerCreationRelationship, type: Creation.self)
        bodyCreation = MappingUtils.objectFromMapper(dataMapper, relationship: bodyCreationRelationship, type: Creation.self)
    }
}
