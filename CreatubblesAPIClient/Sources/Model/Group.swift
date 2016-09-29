//
//  Group.swift
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

@objc
open class Group: NSObject, Identifiable
{
    open let identifier: String
    open let name: String
    open let slug: String
    open let creatorsCount: Int
    open let avatarUrl: String?
    
    open let avatarCreation: Creation?
    open let avatarCreationRelationship: Relationship?
    
    init(mapper: GroupMapper, dataMapper: DataIncludeMapper? = nil)
    {
        identifier = mapper.identifier!
        name = mapper.name!
        slug = mapper.slug!
        creatorsCount = mapper.creatorsCount!
        avatarUrl = mapper.avatarUrl
        
        avatarCreationRelationship = MappingUtils.relationshipFromMapper(mapper.avatarCreationRelationship)
        avatarCreation = MappingUtils.objectFromMapper(dataMapper, relationship: avatarCreationRelationship, type: Creation.self)
    }
}
