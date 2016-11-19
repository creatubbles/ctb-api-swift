//
//  CustomStyle.swift
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
