//
//  ListedChallenge.swift
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
open class ListedChallenge: NSObject, Identifiable {
    open let identifier: String
    open let name: String
    open let bannerUrl: String
    open let creationsCount: Int
    open let publishedAt: Date?
    open let endsAt: Date?
    open let state: ChallengeState
    open let difficulty: ChallengeDifficulty
    open let isFavorite: Bool
    open let hasSubmitted: Bool

    init(mapper: ListedChallengeMapper, dataMapper: DataIncludeMapper? = nil, metadata: Metadata? = nil) {
        identifier = mapper.identifier ?? ""
        name = mapper.name ?? ""
        bannerUrl = mapper.bannerUrl ?? ""
        creationsCount = mapper.creationsCount ?? 0
        publishedAt = mapper.publishedAt
        endsAt = mapper.endsAt
        state = mapper.parseState()
        difficulty = mapper.parseDifficulty()
        isFavorite = metadata?.favoriteChallengesIdentifiers.contains(identifier) ?? false
        hasSubmitted = metadata?.submittedChallengesIdentifiers.contains(identifier) ?? false
    }
}
