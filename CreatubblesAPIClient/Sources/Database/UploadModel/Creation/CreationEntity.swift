//
//  CreationEntity.swift
//  CreatubblesAPIClient
//
//  Created by Nomtek on 19.02.2016.
//  Copyright © 2016 Nomtek. All rights reserved.
//

import Foundation
import RealmSwift

class CreationEntity: Object
{
    
    dynamic var identifier: String?
    dynamic var name: String?
    dynamic var createdAt: NSDate?
    dynamic var updatedAt: NSDate?
    
    var createdAtYear = RealmOptional<Int>()
    var createdAtMonth = RealmOptional<Int>()
    
    var imageStatus = RealmOptional<Int>()
    dynamic var image = ""
    
    var bubblesCount = RealmOptional<Int>()
    var commentsCount = RealmOptional<Int>()
    var viewsCount = RealmOptional<Int>()
    
    dynamic var lastBubbledAt: NSDate?
    dynamic var lastCommentedAt: NSDate?
    dynamic var lastSubmittedAt: NSDate?
    
    var approved = RealmOptional<Bool>()
    dynamic var shortUrl: String?
    dynamic var createdAtAge: String?
}
