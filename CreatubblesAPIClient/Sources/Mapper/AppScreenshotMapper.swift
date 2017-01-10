//
//  ToybooCreationMapper.swift
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
//


import UIKit
import ObjectMapper

class AppScreenshotMapper: Mappable
{
    var identifier: String?
    var imageURL: String?
    var isVideo: Bool?
    var videoIdentifier: String?
    var title: String?
    var provider: String?
    var thumbnailURL: String?
    var position: Int?
    
    //MARK: - Mappable
    required init?(map: Map) { /* Intentionally left empty  */ }
    
    func mapping(map: Map)
    {
        identifier <- map["id"]
        imageURL <- map["attributes.url"]
        isVideo <- map["attributes.is_video"]
        videoIdentifier <- map["attributes.vid"]
        title <- map["attributes.title"]
        provider <- map["attributes.provider"]
        thumbnailURL <- map["attributes.thumbnail_url"]
        position <- map["attributes.position"]
    }
    
    func parseProvider() -> AppScreenshotProvider {
        if isVideo == false { return .unknown }
        if provider == "vimeo" { return .vimeo }
        if provider == "youtube" { return .youtube }
        
        Logger.log(.warning, "Unknown provider: \(self.provider)")
        return .unknown
    }
}
