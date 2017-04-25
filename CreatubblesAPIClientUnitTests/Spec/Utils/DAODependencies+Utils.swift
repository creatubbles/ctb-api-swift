//
//  DAODependencies+Utils.swift
//  CreatubblesAPIClient
//
//  Created by Michal Miedlarz on 25.04.2017.
//  Copyright © 2017 Nomtek. All rights reserved.
//

import Foundation
@testable import CreatubblesAPIClient

extension DAODependencies
{
    class func testDependencies() -> DAODependencies
    {
        let settings = APIClientSettings(appId: "test", appSecret: "test")
        return DAODependencies(requestSender: RequestSender(settings: settings))
    }
}
