//
//  OAuth2+Cancelable.swift
//  CreatubblesAPIClient
//
//  Created by Michal Miedlarz on 04.04.2016.
//  Copyright © 2016 Nomtek. All rights reserved.
//

import Foundation
import p2_OAuth2

extension OAuth2: Cancelable
{
    public func cancel()
    {
        abortAuthorization()
    }
}