//
//  GalleryHowToMapper.swift
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

import Foundation
import ObjectMapper

class GalleryInstructionMapper: Mappable {
    var identifier: String?
    var position: Int?
    var title: String?
    var descriptionText: String?
    var descriptionHtml: String?
    var imageUrl: String?
    var video480Url: String?
    var video720Url: String?
    
    required init?(map: Map) { /* Intentionally left empty  */ }
    
    func mapping(map: Map) {
        identifier <- map["id"]
        
        position <- map["attributes.position"]
        title <- map["attributes.title"]
        descriptionText <- map["attributes.content"]
        descriptionHtml <- map["attributes.content_html"]
        imageUrl <- map["attributes.image.links.original"]
        video480Url <- map["attributes.video_480_url"]
        video720Url <- map["attributes.video_720_url"]
    }
}
