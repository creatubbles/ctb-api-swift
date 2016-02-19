//
//  CreationEntity.swift
//  CreatubblesAPIClient
//
//  Created by Nomtek on 19.02.2016.
//  Copyright © 2016 Nomtek. All rights reserved.
//

import Foundation
import RealmSwift

class CreationEntity: Object {
    
    dynamic var identifier: String?
    dynamic var name: String?
    dynamic var createdAt: NSDate?
    dynamic var updatedAt: NSDate?
    
    var createdAtYear: Int?
    var createdAtMonth: Int?
    
    var imageStatus: Int?
    dynamic var image: String?
    
    var bubblesCount: Int?
    var commentsCount: Int?
    var viewsCount: Int?
    
    dynamic var lastBubbledAt: NSDate?
    dynamic var lastCommentedAt: NSDate?
    dynamic var lastSubmittedAt: NSDate?
    
    var approved: Bool?
    dynamic var shortUrl: String?
    dynamic var createdAtAge: String?
}
