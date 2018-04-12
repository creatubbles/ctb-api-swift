//
//  Hashtag.swift
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

open class Hashtag: NSObject, Identifiable {
    open let identifier: String
    open let imageURL: String?
    open let isOfficial: Bool?
    open let isFollowed: Bool?
    open let taggingsCount: Int?

    init(identifier: String, imageURL: String?, isOfficial: Bool?, isFollowed: Bool?, taggingsCount: Int?) {
        self.imageURL = imageURL
        self.identifier = identifier
        self.isOfficial = isOfficial
        self.isFollowed = isFollowed
        self.taggingsCount = taggingsCount
    }
    
    init(mapper: HashtagMapper, dataMapper: DataIncludeMapper? = nil, metadata: Metadata? = nil)
    {
        identifier = mapper.identifier!
        imageURL = mapper.imageURL
        isOfficial = mapper.isOfficial
        taggingsCount = mapper.taggingsCount
        isFollowed = metadata?.userFollowedHashtagsIdentifiers.contains(mapper.identifier!) ?? false
    }
}
