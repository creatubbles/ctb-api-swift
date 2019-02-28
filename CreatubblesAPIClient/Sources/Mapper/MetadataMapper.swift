//
//  MetadataMapper.swift
//  CreatubblesAPIClient
//
//  Copyright (c) 2017 Creatubbles Pte. Ltd.
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
//

import UIKit
import ObjectMapper

class MetadataMapper: Mappable {
    var bubbledCreationIdentifiers: Array<String>?
    var bubbledUserIdentifiers: Array<String>?
    var bubbledGalleryIdentifiers: Array<String>?
    var abilityMappers: Array<AbilityMapper>?

    var userFollowedUsersIdentifiers: Array<String>?
    var userFollowedHashtagsIdentifiers: Array<String>?

    var favoritedCreationIdentifiers: Array<String>?
    var favoritedGalleryIdentifiers: Array<String>?
    
    var submittedChallengesIdentifiers: Array<String>?
    var favoriteChallengesIdentifiers: Array<String>?

    var ownedItemsIdentifiers: Array<String>?
    var itemsInUseIdentifiers: Array<String>?
    var joinedHubsIdentifiers: Array<String>?

    required init?(map: Map) { /* Intentionally left empty  */ }

    func mapping(map: Map) {
        bubbledCreationIdentifiers <- map["user_bubbled_creations"]
        bubbledUserIdentifiers <- map["user_bubbled_users"]
        bubbledGalleryIdentifiers <- map["user_bubbled_galleries"]

        abilityMappers <- map["abilities"]

        userFollowedUsersIdentifiers <- map["followed_users"]
        userFollowedHashtagsIdentifiers <- map["followed_hashtags"]
        
        favoritedCreationIdentifiers <- map["favorite_creations"]
        favoritedGalleryIdentifiers <- map["favorite_galleries"]
        
        submittedChallengesIdentifiers <- map["submitted_challenges"]
        favoriteChallengesIdentifiers <- map["favorite_challenges"]
        
        ownedItemsIdentifiers <- map["owned_items"]
        itemsInUseIdentifiers <- map["items_in_use"]
        joinedHubsIdentifiers <- map["joined_hubs"]
    }
}
