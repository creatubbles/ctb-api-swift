//
//  NewCreationDataEntity.swift
//  CreatubblesAPIClient
//
//  Created by Nomtek on 19.02.2016.
//  Copyright © 2016 Nomtek. All rights reserved.
//

import Foundation
import RealmSwift

class NewCreationDataEntity: Object {
    
    dynamic var image: NSData?
    dynamic var name: String? = nil
    dynamic var reflectionText: String? = nil
    dynamic var reflectionVideoUrl: String? = nil
    dynamic var galleryId: String? = nil
    dynamic var creatorIds: Array<String>? = nil
    var creationYear: Int? = nil
    var creationMonth: Int? = nil
}
