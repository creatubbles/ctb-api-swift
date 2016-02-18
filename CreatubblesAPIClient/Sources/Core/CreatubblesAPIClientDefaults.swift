//
//  CreatubblesAPIClientDefaults.swift
//  CreatubblesAPIClient
//
//  Created by Michal Miedlarz on 18.02.2016.
//  Copyright © 2016 Nomtek. All rights reserved.
//

import UIKit

//MARK: - Typealiases
public typealias ErrorClousure = (ErrorType?) -> (Void)
public typealias UserClousure = (User?, ErrorType?) -> (Void)
public typealias UsersClousure = (Array<User>?, ErrorType?) -> (Void)
public typealias CreationClousure = (Creation?, ErrorType?) -> (Void)
public typealias CreationsClousure = (Array<Creation>?, ErrorType?) -> (Void)
public typealias GalleryClousure = (Gallery?, ErrorType?) -> (Void)
public typealias GalleriesClousure = (Array<Gallery>?, ErrorType?) -> (Void)

//MARK: - Enums
public enum Gender: Int
{
    case Male = 0
    case Female = 1
}

public enum GalleriesSort: String
{
    case Popular = "popular"
    case Recent = "recent"
}

//MARK: - Structs
public struct PagingData
{
    public var page: Int
    public var pageSize: Int
}

public struct NewCreatorData
{
    public var name: String
    public var displayName: String
    public var birthYear: Int
    public var birthMonth: Int
    public var countryCode: String
    public var gender: Gender
}


public struct NewGalleryData
{
    public var name: String
    public var galleryDescription: String
    public var openForAll: Bool
    public var ownerId: String?
}
