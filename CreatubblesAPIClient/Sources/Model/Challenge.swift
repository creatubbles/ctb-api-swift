//
//  Challenge.swift
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

@objc
open class Challenge: NSObject, Identifiable {
    open let identifier: String
    open let name: String
    open let bannerUrl: String
    open let gifUrl: String?
    open let creationsCount: Int
    open let publishedAt: Date?
    open let endsAt: Date?
    open let state: ChallengeState
    open let difficulty: ChallengeDifficulty
    open let originalPartnerAppId: String?
    open let isFavorite: Bool
    open let hasSubmitted: Bool

    // MARK: - Relationships
    open let owner: User?
    open let ownerRelationship: Relationship?
    
    open let bannerSectionRelationship: Relationship?
    open let bannerSection: GalleryInstruction?
    
    open let instructionRelationships: Array<Relationship>?
    open let instructions: Array<GalleryInstruction>?
    
    open let connectedPartnersRelationships: Array<Relationship>?
    open let connectedPartners: Array<PartnerApplicationProfile>?
    
    init(mapper: ChallengeMapper, dataMapper: DataIncludeMapper? = nil, metadata: Metadata? = nil) {
        identifier = mapper.identifier ?? ""
        name = mapper.name ?? ""
        bannerUrl = mapper.bannerUrl ?? ""
        gifUrl = mapper.gifUrl
        creationsCount = mapper.creationsCount ?? 0
        publishedAt = mapper.publishedAt
        endsAt = mapper.endsAt
        state = mapper.parseState()
        difficulty = mapper.parseDifficulty()
        originalPartnerAppId = mapper.originalPartnerAppId
        isFavorite = metadata?.favoriteChallengesIdentifiers.contains(identifier) ?? false
        hasSubmitted = metadata?.submittedChallengesIdentifiers.contains(identifier) ?? false
        
        ownerRelationship = mapper.parseOwnerRelationship()
        owner = MappingUtils.objectFromMapper(dataMapper, relationship: ownerRelationship, type: User.self)
        
        bannerSectionRelationship = mapper.parseBannerSectionRelationship()
        bannerSection = MappingUtils.objectFromMapper(dataMapper, relationship: bannerSectionRelationship, type: GalleryInstruction.self)
        
        instructionRelationships = mapper.parseInstructionRelationships()
        instructions = instructionRelationships?.flatMap { MappingUtils.objectFromMapper(dataMapper, relationship: $0, type: GalleryInstruction.self) }
        
        connectedPartnersRelationships = mapper.parseConnectedPartnersRelashionships()
        connectedPartners = connectedPartnersRelationships?.flatMap { MappingUtils.objectFromMapper(dataMapper, relationship: $0, type: PartnerApplicationProfile.self, shouldMap2ndLevelRelationships: false) }
    }
}
