//
//  Creator.swift
//  CreatubblesAPIClient
//
//  Created by Michal Miedlarz on 04.02.2016.
//  Copyright © 2016 Nomtek. All rights reserved.
//

import UIKit

enum Gender
{
    case Male
    case Female
}

class Creator: NSObject
{
    let identifier: String
    let name: String
    let createdAt: NSDate
    let avatarUrl: String
    let age: Int
    let birthMonth: Int
    let birthYear: Int
    let userIdentifier: Int
    let gender: Gender
    let groups: Array<Group>
    let country: Country
    let viewsCount: Int
    let followersCount: Int
    let followingsCount: Int
    
    init(builder: CreatorModelBuilder)
    {
        identifier = builder.identifier!
        name = builder.name!
        createdAt = builder.createdAt!
        avatarUrl = builder.avatarUrl!
        age = builder.age!
        birthMonth = builder.birthMonth!
        birthYear = builder.birthYear!
        userIdentifier = builder.userIdentifier!
        gender = builder.gender!
        followersCount = builder.followersCount!
        followingsCount = builder.followingsCount!
        viewsCount = builder.viewsCount!
        
        groups = builder.buildGroups()!
        country = builder.buildCountry()!
    }
}
