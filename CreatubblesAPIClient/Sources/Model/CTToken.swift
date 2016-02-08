//
//  CTToken.swift
//  CreatubblesAPIClient
//
//  Created by Michal Miedlarz on 05.02.2016.
//  Copyright © 2016 Nomtek. All rights reserved.
//

import UIKit

enum TokenType
{
    case Bearer
    case Basic
}

class CTToken: NSObject
{
    let accessToken: String
    let tokenType: TokenType
    let expiresIn: NSDate
    
    init(accessToken: String, tokenType: TokenType, expiresIn: NSDate)
    {
        self.accessToken = accessToken
        self.tokenType = tokenType
        self.expiresIn = expiresIn
    }
}
