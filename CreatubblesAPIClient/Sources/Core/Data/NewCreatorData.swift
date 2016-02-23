//
//  NewCreatorData.swift
//  CreatubblesAPIClient
//
//  Created by Michal Miedlarz on 23.02.2016.
//  Copyright © 2016 Nomtek. All rights reserved.
//

import UIKit

@objc
public class NewCreatorData: NSObject
{
    public let name: String
    public let displayName: String
    public let birthYear: Int
    public let birthMonth: Int
    public let countryCode: String
    public let gender: Gender
    
    init(name: String, displayName: String, birthYear: Int, birthMonth: Int, countryCode: String, gender: Gender)
    {
        self.name = name
        self.displayName = displayName
        self.birthMonth = birthMonth
        self.birthYear = birthYear
        self.countryCode = countryCode
        self.gender = gender        
    }
    
}