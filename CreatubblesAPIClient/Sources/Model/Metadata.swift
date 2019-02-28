//
//  Metadata.swift
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

public class Metadata: NSObject {
    let bubbledCreationIdentifiers: Array<String>
    let bubbledUserIdentifiers: Array<String>
    let bubbledGalleryIdentifiers: Array<String>
    let abilities: Array<Ability>

    public let userFollowedUsersIdentifiers: Array<String>
    public let userFollowedHashtagsIdentifiers: Array<String>

    public let favoritedCreationIdentifiers: Array<String>
    public let favoritedGallerydentifiers: Array<String>

    public let submittedChallengesIdentifiers: Array<String>
    public let favoriteChallengesIdentifiers: Array<String>
    
    public let ownedItemsIdentifiers: Array<String>?
    public let itemsInUseIdentifiers: Array<String>?
    public let joinedHubsIdentifiers: Array<String>?

    init(mapper: MetadataMapper) {
        bubbledCreationIdentifiers = mapper.bubbledCreationIdentifiers ?? []
        bubbledUserIdentifiers = mapper.bubbledUserIdentifiers ?? []
        bubbledGalleryIdentifiers = mapper.bubbledGalleryIdentifiers ?? []
        abilities = mapper.abilityMappers?.map({ Ability(mapper: $0) }).filter({ $0.operation != .unknown }) ?? []

        userFollowedUsersIdentifiers = mapper.userFollowedUsersIdentifiers ?? []
        userFollowedHashtagsIdentifiers = mapper.userFollowedHashtagsIdentifiers ?? []
        
        favoritedCreationIdentifiers = mapper.favoritedCreationIdentifiers ?? []
        favoritedGallerydentifiers = mapper.favoritedGalleryIdentifiers ?? []
        
        submittedChallengesIdentifiers = mapper.submittedChallengesIdentifiers ?? []
        favoriteChallengesIdentifiers = mapper.favoriteChallengesIdentifiers ?? []
        
        ownedItemsIdentifiers = mapper.ownedItemsIdentifiers ?? []
        itemsInUseIdentifiers = mapper.itemsInUseIdentifiers ?? []
        joinedHubsIdentifiers = mapper.joinedHubsIdentifiers ?? []
    }
}
