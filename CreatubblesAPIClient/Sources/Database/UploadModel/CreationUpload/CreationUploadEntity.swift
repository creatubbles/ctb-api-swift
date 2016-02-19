//
//  CreationUploadEntity.swift
//  CreatubblesAPIClient
//
//  Created by Nomtek on 19.02.2016.
//  Copyright © 2016 Nomtek. All rights reserved.
//

import Foundation
import RealmSwift

class CreationUploadEntity: Object
{
    dynamic var identifier: String = ""
    dynamic var uploadUrl: String = ""
    dynamic var contentType: String = ""
    dynamic var pingUrl: String = ""
    dynamic var completedAt: NSDate?
}
