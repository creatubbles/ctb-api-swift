//
//  CreatorModelBuilder.swift
//  CreatubblesAPIClient
//
//  Created by Michal Miedlarz on 09.02.2016.
//  Copyright © 2016 Nomtek. All rights reserved.
//

import UIKit

class CreatorModelBuilder: NSObject
{
    var identifier: String?
    var name: String?
    var createdAt: NSDate?
    var avatarUrl: String?
    var age: Int?
    var birthMonth: Int?
    var birthYear: Int?
    var userIdentifier: Int?
    var gender: Gender?
    var groups: Array<GroupModelBuilder>?
    var country: CountryModelBuilder?
    var viewsCount: Int?
    var followersCount: Int?
    var followingsCount: Int?
    
    func buildGroups() -> Array<Group>?
    {
        return Array<Group>()
    }
    
    func buildCountry() -> Country?
    {
        return nil
    }
}
