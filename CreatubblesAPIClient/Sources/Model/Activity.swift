//
//  Activity.swift
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


import UIKit

@objc
open class Activity: NSObject, Identifiable
{
    open let identifier: String
    open let type: ActivityType
    open let count: Int
    open let itemsCount: Int
    
    open let createdAt: Date
    open let lastUpdatedAt: Date
    
    open let owners: Array<User>?
    open let creation: Creation?
    open let gallery: Gallery?
    open let user: User?
    open let relatedCreations: Array<Creation>?
    open let relatedComments: Array<Comment>?
    
    open let ownersRelationships: Array<Relationship>?
    open let creationRelationship: Relationship?
    open let galleryRelationship: Relationship?
    open let userRelationship: Relationship?
    open let relatedCreationsRelationships: Array<Relationship>?
    open let relatedCommentsRelationships: Array<Relationship>?
    
    init(mapper: ActivityMapper, dataMapper: DataIncludeMapper? = nil, metadata: Metadata? = nil) {
        identifier = mapper.identifier!
        type = mapper.parseType()
        
        count = mapper.count!
        itemsCount = mapper.itemsCount!
        
        createdAt = mapper.createdAt! as Date
        lastUpdatedAt = mapper.lastUpdatedAt! as Date
        
        ownersRelationships  = mapper.ownersRelationships?.flatMap({ MappingUtils.relationshipFromMapper($0) })
        creationRelationship = MappingUtils.relationshipFromMapper(mapper.creationRelationship)
        galleryRelationship = MappingUtils.relationshipFromMapper(mapper.galleryRelationship)
        userRelationship = MappingUtils.relationshipFromMapper(mapper.userRelationship)
        
        relatedCreationsRelationships = mapper.relatedCreationsRelationships?.flatMap({ MappingUtils.relationshipFromMapper($0) })
        relatedCommentsRelationships = mapper.relatedCommentsRelationships?.flatMap({ MappingUtils.relationshipFromMapper($0) })
        
        owners = ownersRelationships?.flatMap({ MappingUtils.objectFromMapper(dataMapper, relationship: $0, type: User.self) })
        creation = MappingUtils.objectFromMapper(dataMapper, relationship: creationRelationship, type: Creation.self)
        user = MappingUtils.objectFromMapper(dataMapper, relationship: userRelationship, type: User.self)
        gallery = MappingUtils.objectFromMapper(dataMapper, relationship: galleryRelationship, type: Gallery.self)
        
        relatedCreations = relatedCreationsRelationships?.flatMap({ MappingUtils.objectFromMapper(dataMapper, relationship: $0, type: Creation.self) })
        relatedComments = relatedCommentsRelationships?.flatMap({ MappingUtils.objectFromMapper(dataMapper, relationship: $0, type: Comment.self) })
    }
}
