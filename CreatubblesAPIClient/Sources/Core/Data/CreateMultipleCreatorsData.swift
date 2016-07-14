//
//  CreateMultipleCreatorsData.swift
//  CreatubblesAPIClient
//
//  Created by Nomtek on 14.07.2016.
//  Copyright © 2016 Nomtek. All rights reserved.
//

import UIKit

@objc
public class CreateMultipleCreatorsData: NSObject
{
    public let amount: Int
    public let birthYear: Int
    public let group: String?
    
    public init(amount: Int, birthYear: Int, group: String? = nil)
    {
        self.amount = amount
        self.birthYear = birthYear
        self.group = group
    }
}
