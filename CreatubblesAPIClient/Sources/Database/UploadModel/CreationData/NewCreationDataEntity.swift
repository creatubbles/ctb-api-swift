//
//  NewCreationDataEntity.swift
//  CreatubblesAPIClient
//
//  Created by Nomtek on 19.02.2016.
//  Copyright © 2016 Nomtek. All rights reserved.
//

import Foundation
import RealmSwift

class CreatorIdString: Object
{
    dynamic var creatorIdString: String?
}

class NewCreationDataEntity: Object
{
    dynamic var name: String?
    dynamic var reflectionText: String?
    dynamic var reflectionVideoUrl: String?
    dynamic var galleryId: String?
    var creatorIds: List<CreatorIdString>?
    var creationYear: Int?
    var creationMonth: Int?
}
