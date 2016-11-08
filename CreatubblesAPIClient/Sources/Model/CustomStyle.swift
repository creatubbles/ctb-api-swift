//
//  CustomStyle.swift
//  CreatubblesAPIClient
//
//  Created by Michal Miedlarz on 03.06.2016.
//  Copyright © 2016 Nomtek. All rights reserved.
//

@objc
open class CustomStyle: NSObject, Identifiable
{
    open let identifier: String
    open let headerBackgroundIdentifier: String?
    open let bodyBackgroundIdentifier: String?
    open let fontName: String?
    open let bio: String?
    open let bodyColorsHex: Array<String>?
    open let headerColorsHex: Array<String>?
    open let bodyCreationURL: String?
    open let headerCreationURL: String?
    
    open let createdAt: Date
    open let updatedAt: Date
    
    open let userRelationship: Relationship?
    open let headerCreationRelationship: Relationship?
    open let bodyCreationRelationship: Relationship?
    
    open let user: User?
    open let headerCreation: Creation?
    open let bodyCreation: Creation?
    
    init(mapper: CustomStyleMapper, dataMapper: DataIncludeMapper? = nil)
    {
        identifier = mapper.identifier!
        
        headerBackgroundIdentifier = mapper.headerBackgroundIdentifier
        bodyBackgroundIdentifier = mapper.bodyBackgroundIdentifier
        fontName = mapper.fontName
        bio = mapper.bio
        
        bodyColorsHex = mapper.bodyColorStrings?.flatMap({ $0.isHexColorString() ? $0 : $0.RGBtoHexString() })
        headerColorsHex = mapper.headerColorStrings?.flatMap({ $0.isHexColorString() ? $0 : $0.RGBtoHexString() })
        
        bodyCreationURL = mapper.bodyCreationURL
        headerCreationURL = mapper.headerCreationURL
        
        createdAt = mapper.createdAt! as Date
        updatedAt = mapper.updatedAt! as Date
        
        userRelationship = MappingUtils.relationshipFromMapper(mapper.userRelationship)
        headerCreationRelationship = MappingUtils.relationshipFromMapper(mapper.headerCreationRelationship)
        bodyCreationRelationship = MappingUtils.relationshipFromMapper(mapper.bodyCreationRelationship)
        
        user = MappingUtils.objectFromMapper(dataMapper, relationship: userRelationship, type: User.self)
        headerCreation = MappingUtils.objectFromMapper(dataMapper, relationship: headerCreationRelationship, type: Creation.self)
        bodyCreation = MappingUtils.objectFromMapper(dataMapper, relationship: bodyCreationRelationship, type: Creation.self)
    }
}
