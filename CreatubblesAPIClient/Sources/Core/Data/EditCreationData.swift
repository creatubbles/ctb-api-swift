//
//  EditCreationData.swift
//  CreatubblesAPIClient
//
//  Created by Michal Miedlarz on 15.06.2016.
//  Copyright © 2016 Nomtek. All rights reserved.
//

import UIKit

@objc
open class EditCreationData: NSObject
{
    open var name: String?
    open var reflectionText: String?
    open var reflectionVideoURL: String?
    open var creationDate: Date? //Only year and month is necessary
}
