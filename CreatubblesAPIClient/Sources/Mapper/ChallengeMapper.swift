//
//  ChallengeMapper.swift
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

class ChallengeMapper: Mappable {
    var identifier: String?
    var name: String?
    var bannerUrl: String?
    var gifUrl: String?
    var shortUrl: String?
    var creationsCount: Int?
    var publishedAt: Date?
    var endsAt: Date?
    var state: String?
    var difficulty: String?
    var originalPartnerAppId: String?
    var descriptionText: String?
    var ownerTrackingId: String?
    var partnerTrackingId: String?

    var ownerRelationship: RelationshipMapper?
    var bannerSectionRelationship: RelationshipMapper?
    var instructionRelationships: Array<RelationshipMapper>?
    var connectedPartnersRelashionships: Array<RelationshipMapper>?
    
    required init?(map: Map) { /* Intentionally left empty  */ }
    
    func mapping(map: Map) {
        identifier <- map["id"]
        name <- map["attributes.name"]
        bannerUrl <- map["attributes.banner.links.list_view_retina"]
        gifUrl <- map["attributes.gif_url"]
        shortUrl <- map["attributes.short_url"]
        creationsCount <- map["attributes.creations_count"]
        publishedAt <- (map["attributes.challenge_published_at"], APIClientDateTransform.sharedTransform)
        endsAt <- (map["attributes.challenge_ends_at"], APIClientDateTransform.sharedTransform)
        state <- map["attributes.challenge_state"]
        difficulty <- map["attributes.challenge_difficulty"]
        originalPartnerAppId <- map["attributes.original_partner_application_id"]
        descriptionText <- map["attributes.description"]
        ownerTrackingId <- map["attributes.owner_tracking_id"]
        partnerTrackingId <- map["attributes.partner_tracking_id"]

        ownerRelationship <- map["relationships.owner.data"]
        bannerSectionRelationship <- map["relationships.banner_section.data"]
        instructionRelationships <- map["relationships.steps_sections.data"]
        connectedPartnersRelashionships <- map["relationships.partner_application_profiles.data"]
    }
    
    // MARK: Parsing
    func parseState() -> ChallengeState {
        if state == "open" { return .open }
        if state == "closed" { return .closed }
        return .undefined
    }
    
    func parseDifficulty() -> ChallengeDifficulty {
        if difficulty == "beginner" { return .beginner }
        if difficulty == "intermediary" { return .intermediary }
        if difficulty == "advanced" { return .advanced }
        return .undefined
    }
    
    func parseOwnerRelationship() -> Relationship? {
        return MappingUtils.relationshipFromMapper(ownerRelationship)
    }
    
    func parseBannerSectionRelationship() -> Relationship? {
        return MappingUtils.relationshipFromMapper(bannerSectionRelationship)
    }
    
    func parseInstructionRelationships() -> Array<Relationship>? {
        return instructionRelationships?.flatMap { MappingUtils.relationshipFromMapper($0) }
    }
    
    func parseConnectedPartnersRelashionships() -> Array<Relationship>? {
        return connectedPartnersRelashionships?.flatMap { MappingUtils.relationshipFromMapper($0) }
    }
}
