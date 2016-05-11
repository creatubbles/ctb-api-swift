//
//  APIClientDateFormatter.swift
//  CreatubblesAPIClient
//
//  Created by Michal Miedlarz on 12.05.2016.
//  Copyright © 2016 Nomtek. All rights reserved.
//

import UIKit
import ObjectMapper

class APIClientDateTransform: NSObject
{
    static let sharedTransform = CustomDateFormatTransform(formatString: "yyyy-MM-dd'T'HH:mm:ss.SSSZ")
}
