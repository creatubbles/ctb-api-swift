//
//  User.swift
//  CreatubblesAPIClient
//
//  Created by Michal Miedlarz on 04.02.2016.
//  Copyright © 2016 Nomtek. All rights reserved.
//

import UIKit

enum Gender: Int
{
    case Male = 0
    case Female = 1
}

enum Role: String
{
    case Parent = "parent"
    case Teacher = "teacher"
    case Creator = "creator"
}

class User: NSObject
{
    let identifier: String
    let username: String
    let displayName: String
    let name: String
    let role: Role
    let lastBubbledAt: NSDate?
    let lastCommentedAt: NSDate?
    let createdAt: NSDate
    let updatedAt: NSDate
    let avatarUrl: String
    let countryCode: String
    let countryName: String
    let age: String
    let gender: Gender
    let birthYear: Int
    let birthMonth: Int?
    let groups: Array<Group>
    let shortUrl: String
    let bubbledByUserIds: Array<String>
    let ownedTags: Array<String>
    
    let addedBubblesCount: Int
    let activitiesCount: Int
    let commentsCount: Int
    let creationsCount: Int
    let creatorsCount: Int
    let galleriesCount: Int
    let managersCount: Int
    
    let homeSchooling: Bool
    let signedUpAsInstructor: Bool
    let isPartner: Bool
    let loggable: Bool
    let gspSeen: Bool
    let uepUnwanted: Bool
    
    init(builder: UserModelBuilder)
    {
        identifier = builder.identifier!
        username = builder.username!
        displayName = builder.displayName!
        name = builder.name!
        role = builder.parseRole()
        lastBubbledAt = builder.lastBubbledAt
        lastCommentedAt = builder.lastCommentedAt
        createdAt = builder.createdAt!
        updatedAt = builder.updatedAt!
        avatarUrl = builder.avatarUrl!
        countryCode = builder.countryCode!
        countryName = builder.countryName!
        age = builder.age!
        gender = builder.parseGender()
        birthYear = builder.birthYear!
        birthMonth = builder.birthMonth
        groups = builder.parseGroups()
        shortUrl = builder.shortUrl!
        bubbledByUserIds = builder.bubbledByUserIds!
        ownedTags = builder.ownedTags!
                        
        addedBubblesCount = builder.addedBubblesCount!
        activitiesCount = builder.activitiesCount!
        commentsCount = builder.commentsCount!
        creationsCount = builder.creationsCount!
        creatorsCount = builder.creatorsCount!
        galleriesCount = builder.galleriesCount!
        managersCount = builder.managersCount!

        homeSchooling = builder.homeSchooling!
        signedUpAsInstructor = builder.signedUpAsInstructor!
        isPartner = builder.isPartner!
        loggable = builder.loggable!
        gspSeen = builder.gspSeen!
        uepUnwanted = builder.uepUnwanted!
    }
}
