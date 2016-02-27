//
//  CreationUpload.swift
//  CreatubblesAPIClient
//
//  Created by Michal Miedlarz on 15.02.2016.
//  Copyright © 2016 Nomtek. All rights reserved.
//

import UIKit

@objc
class CreationUpload: NSObject
{
    let identifier: String
    let uploadUrl: String
    let contentType: String
    let pingUrl: String
    let completedAt: NSDate?

    init(builder: CreationUploadModelBuilder)
    {
        identifier = builder.identifier!
        uploadUrl = builder.uploadUrl!
        contentType = builder.contentType!
        pingUrl = builder.pingUrl!
        completedAt = builder.completedAt
    }
    init(creationUploadEntity: CreationUploadEntity)
    {
        identifier = creationUploadEntity.identifier!
        uploadUrl = creationUploadEntity.uploadUrl!
        contentType = creationUploadEntity.contentType!
        pingUrl = creationUploadEntity.pingUrl!
        completedAt = creationUploadEntity.completedAt
    }
}
