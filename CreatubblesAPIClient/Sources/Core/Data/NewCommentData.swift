//
//  NewCommentData.swift
//  CreatubblesAPIClient
//
//  Created by Nomtek on 17.03.2016.
//  Copyright © 2016 Nomtek. All rights reserved.
//

import UIKit
@objc public enum CommentedObjectType: Int
{
    case gallery
    case creation
    case user
}

@objc
open class NewCommentData: NSObject
{
    open let commentedObjectIdentifier: String
    open let type: CommentedObjectType
    
    open let text: String?
    
    public init(userId: String, text: String)
    {
        self.commentedObjectIdentifier = userId
        self.type = .user
        self.text = text
    }
    
    public init(galleryId: String, text: String)
    {
        self.commentedObjectIdentifier = galleryId
        self.type = .gallery
        self.text = text
    }
    
    public init(creationId: String, text: String)
    {
        self.commentedObjectIdentifier = creationId
        self.type = .creation
        self.text = text
    }

}


