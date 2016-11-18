//
//  ContentEntry.swift
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
public enum ContentEntryType: Int
{
    case unknown       //Error type, shouldn't ever happened
    case creation
    case gallery
    case user
}

@objc
open class ContentEntry: NSObject
{
    open let type: ContentEntryType
    open let identifier: String
    
    open let user: User?
    open let creation: Creation?
    open let gallery: Gallery?
    
    open let userRelationship: Relationship?
    open let creationRelationship: Relationship?
    open let galleryRelationship: Relationship?
    
    init(mapper: ContentEntryMapper, dataMapper: DataIncludeMapper? = nil)
    {
        identifier = mapper.identifier!
        type = mapper.parseType()
        
        userRelationship = mapper.parseUserRelationship()
        creationRelationship = mapper.parseCreationRelationship()
        galleryRelationship = mapper.parseGalleryRelationship()
        
        user = MappingUtils.objectFromMapper(dataMapper, relationship: userRelationship, type: User.self)
        creation = MappingUtils.objectFromMapper(dataMapper, relationship: creationRelationship, type: Creation.self)
        gallery = MappingUtils.objectFromMapper(dataMapper, relationship: galleryRelationship, type: Gallery.self)
    }        
}
