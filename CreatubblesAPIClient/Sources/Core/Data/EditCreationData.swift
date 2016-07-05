//
//  EditCreationData.swift
//  CreatubblesAPIClient
//
//  Created by Michal Miedlarz on 15.06.2016.
//  Copyright © 2016 Nomtek. All rights reserved.
//

import UIKit

@objc
public class EditCreationData: NSObject
{
    public var name: String?
    public var reflectionText: String?
    public var reflectionVideoURL: String?
    public var creationDate: NSDate? //Only year and month is necessary
}
