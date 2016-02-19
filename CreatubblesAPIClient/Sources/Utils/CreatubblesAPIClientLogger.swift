//
//  Logger.swift
//  CreatubblesAPIClient
//
//  Created by Michal Miedlarz on 18.02.2016.
//  Copyright © 2016 Nomtek. All rights reserved.
//

import UIKit
import XCGLogger

class Logger
{
    static var loggerIdentifier = "CreatubblesAPIClientLogger"
    static var log = XCGLogger(identifier: loggerIdentifier, includeDefaultDestinations: true)
    
    class func setup()
    {
        log.setup(.Debug, showLogIdentifier: true, showFunctionName: false, showThreadName: true, showLogLevel: true, showFileNames: true, showLineNumbers: true, showDate: true, writeToFile: nil, fileLogLevel: nil)
    }
}
