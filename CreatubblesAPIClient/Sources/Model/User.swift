//
//  User.swift
//  CreatubblesAPIClient
//
//  Created by Michal Miedlarz on 04.02.2016.
//  Copyright © 2016 Nomtek. All rights reserved.
//

import UIKit

@objc public enum Role: Int
{
    case Parent
    case Teacher
    case Creator        
    
    var stringValue: String
    {
        switch self
        {
            case .Parent:   return "parent"
            case .Teacher:  return "teacher"
            case .Creator:  return "creator"
        }
    }
}

@objc
public class User: NSObject
{
    public let identifier: String
    public let username: String
    public let displayName: String
    public let name: String
    public let role: Role
    public let lastBubbledAt: NSDate?
    public let lastCommentedAt: NSDate?
    public let createdAt: NSDate
    public let updatedAt: NSDate
    public let avatarUrl: String
    public let countryCode: String
    public let countryName: String
    public let age: String
    public let gender: Gender
    public let birthYear: Int
    public let birthMonth: Int?
    public let groups: Array<Group>
    public let shortUrl: String
    public let bubbledByUserIds: Array<String>
    public let ownedTags: Array<String>
    
    public let addedBubblesCount: Int
    public let activitiesCount: Int
    public let commentsCount: Int
    public let creationsCount: Int
    public let creatorsCount: Int
    public let galleriesCount: Int
    public let managersCount: Int
    
    public let homeSchooling: Bool
    public let signedUpAsInstructor: Bool
    public let isPartner: Bool
    public let loggable: Bool
    public let gspSeen: Bool
    public let uepUnwanted: Bool
    
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
