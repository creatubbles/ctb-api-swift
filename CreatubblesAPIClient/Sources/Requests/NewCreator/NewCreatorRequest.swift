//
//  NewCreatorRequest.swift
//  CreatubblesAPIClient
//
//  Created by Michal Miedlarz on 10.02.2016.
//  Copyright © 2016 Nomtek. All rights reserved.
//

import UIKit

class NewCreatorRequest: Request
{
    override var method: RequestMethod  { return .POST }
    override var endpoint: String       { return "creators" }
    override var parameters: Dictionary<String, AnyObject>
    {
        return [
            "name": name,
            "display_name": displayName,
            "birth_year": birthYear,
            "birth_month": birthMonth,
            "country": countryCode,
            "gender": gender.rawValue
         ]
    }
    
    private let name: String
    private let displayName: String
    private let birthYear: Int
    private let birthMonth: Int
    private let countryCode: String
    private let gender: Gender
    
    init(name: String, displayName: String, birthYear: Int, birthMonth: Int, countryCode: String, gender: Gender)
    {
        self.name = name
        self.displayName = displayName
        self.birthYear = birthYear
        self.birthMonth = birthMonth
        self.countryCode = countryCode
        self.gender = gender
    }
}
