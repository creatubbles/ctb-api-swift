//
//  Comment.swift
//  CreatubblesAPIClient
//
//  Created by Nomtek on 17.03.2016.
//  Copyright © 2016 Nomtek. All rights reserved.
//

import UIKit

class Comment: NSObject
{
    public var identifier: String
    public var text: String
    public var approved: Bool
    public var createdAt: NSDate
    public var commentableType: String
    public var commenterId: String
    
    public let commentedUserId: String?
    public let commentedCreationId: String?
    public let commentedGalleryId: String?
    
    init(mapper: CommentMapper)
    {
        
    }

}
