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
public class User: NSObject, Identifiable
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
    public let age: String?
    public let gender: Gender
    public let shortUrl: String
    
    public let addedBubblesCount: Int
    public let activitiesCount: Int
    public let commentsCount: Int
    public let creationsCount: Int
    public let creatorsCount: Int
    public let galleriesCount: Int
    public let managersCount: Int
    
    public let homeSchooling: Bool
    public let signedUpAsInstructor: Bool
    
    init(mapper: UserMapper)
    {
        identifier = mapper.identifier!
        username = mapper.username!
        displayName = mapper.displayName!
        name = mapper.name!
        role = mapper.parseRole()
        lastBubbledAt = mapper.lastBubbledAt
        lastCommentedAt = mapper.lastCommentedAt
        createdAt = mapper.createdAt!
        updatedAt = mapper.updatedAt!
        avatarUrl = mapper.avatarUrl!
        countryCode = mapper.countryCode!
        countryName = mapper.countryName!
        age = mapper.age
        gender = mapper.parseGender()
        shortUrl = mapper.shortUrl!
                        
        addedBubblesCount = mapper.addedBubblesCount!
        activitiesCount = mapper.activitiesCount!
        commentsCount = mapper.commentsCount!
        creationsCount = mapper.creationsCount!
        creatorsCount = mapper.creatorsCount!
        galleriesCount = mapper.galleriesCount!
        managersCount = mapper.managersCount!

        homeSchooling = mapper.homeSchooling!
        signedUpAsInstructor = mapper.signedUpAsInstructor!
    }
}
