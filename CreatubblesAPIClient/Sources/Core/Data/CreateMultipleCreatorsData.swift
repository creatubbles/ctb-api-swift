//
//  CreateMultipleCreatorsData.swift
//  CreatubblesAPIClient
//
//  Created by Nomtek on 14.07.2016.
//  Copyright © 2016 Nomtek. All rights reserved.
//

import UIKit

@objc
open class CreateMultipleCreatorsData: NSObject
{
    open let amount: Int
    open let birthYear: Int
    open let groupName: String?
    
    public init(amount: Int, birthYear: Int, groupName: String? = nil)
    {
        self.amount = amount
        self.birthYear = birthYear
        self.groupName = groupName
    }
}
