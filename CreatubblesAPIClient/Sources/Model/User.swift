//
//  User.swift
//  CreatubblesAPIClient
//
//  Copyright (c) 2016 Creatubbles Pte. Ltd.
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.

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
    
    //MARK: - Objective-C compability
    public func getBirthMonth() -> NSNumber?
    {
        if let month = birthMonth
        {
            return NSNumber(integer: month)
        }
        return nil;
    }

}
