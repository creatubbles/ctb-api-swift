//
//  Bubble.swift
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
//


import UIKit

@objc
open class Bubble: NSObject, Identifiable
{
    open let identifier: String
    open let xPosition: Float?
    open let yPosition: Float?
    open let colorName: String?
    open let colorHex: String?
    open let createdAt: Date
    open let bubblerId: String
    open let isPositionRandom: Bool
    
    open let bubbledUserId: String?
    open let bubbledCreationId: String?
    open let bubbledGalleryId: String?
    
    open let bubbler: User?
    open let bubbledCreation: Creation?
    open let bubbledGallery: Gallery?
    open let bubbledUser: User?
    
    open let bubblerRelationship: Relationship?
    open let bubbledCreationRelationship: Relationship?
    open let bubbledGalleryRelationship: Relationship?
    open let bubbledUserRelationship: Relationship?
    
    open let abilities: Array<Ability>
    
    init(mapper: BubbleMapper, dataMapper: DataIncludeMapper? = nil, metadata: Metadata? = nil)
    {
        identifier = mapper.identifier!
        xPosition = mapper.xPosition
        yPosition = mapper.yPosition
        colorName = mapper.colorName
        createdAt = mapper.createdAt! as Date
        bubblerId = mapper.bubblerId!
        isPositionRandom = mapper.isPositionRandom ?? false
        colorHex = mapper.colorHex
        
        bubbledUserId = mapper.bubbledUserId
        bubbledCreationId = mapper.bubbledCreationId
        bubbledGalleryId = mapper.bubbledGalleryId
        
        bubblerRelationship = mapper.parseBubblerRelationship()
        bubbledCreationRelationship = mapper.parseBubbledCreationRelationship()
        bubbledGalleryRelationship = mapper.parseBubbledGalleryRelationship()
        bubbledUserRelationship = mapper.parseBubbledUserRelationship()
        
        bubbler = MappingUtils.objectFromMapper(dataMapper, relationship: bubblerRelationship, type: User.self)
        bubbledCreation = MappingUtils.objectFromMapper(dataMapper, relationship: bubbledCreationRelationship, type: Creation.self)
        bubbledGallery = MappingUtils.objectFromMapper(dataMapper, relationship: bubbledGalleryRelationship, type: Gallery.self)
        bubbledUser = MappingUtils.objectFromMapper(dataMapper, relationship: bubbledUserRelationship, type: User.self)
                
        abilities = MappingUtils.abilitiesFrom(metadata: metadata, forObjectWithIdentifier: identifier)
    }
}
