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
    case Gallery
    case Creation
    case User
}

@objc
public class NewCommentData: NSObject
{
    public let commentedObjectIdentifier: String
    public let type: CommentedObjectType
    
    public let text: String?
    
    public init(userId: String, text: String)
    {
        self.commentedObjectIdentifier = userId
        self.type = .User
        self.text = text
    }
    
    public init(galleryId: String, text: String)
    {
        self.commentedObjectIdentifier = galleryId
        self.type = .Gallery
        self.text = text
    }
    
    public init(creationId: String, text: String)
    {
        self.commentedObjectIdentifier = creationId
        self.type = .Creation
        self.text = text
    }

}


