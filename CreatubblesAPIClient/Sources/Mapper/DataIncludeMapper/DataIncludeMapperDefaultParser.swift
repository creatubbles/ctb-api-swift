//
//  DataIncludeMapperDefaultParser.swift
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

open class DataIncludeMapperDefaultParser: NSObject, DataIncludeMapperParser {
    open func dataIncludeMapper(sender: DataIncludeMapper, mapperFor json: [String: Any], typeString: String) -> Mappable? {
        var mapper: Mappable? = nil

        switch typeString {
            case "users":     mapper = Mapper<UserMapper>().map(JSON: json)
            case "creations": mapper = Mapper<CreationMapper>().map(JSON: json)
            case "galleries": mapper = Mapper<GalleryMapper>().map(JSON: json)
            case "partner_applications": mapper = Mapper<PartnerApplicationsMapper>().map(JSON: json)
            case "custom_styles": mapper = Mapper<CustomStyleMapper>().map(JSON: json)
            case "gallery_submissions": mapper = Mapper<GallerySubmissionMapper>().map(JSON: json)
            case "user_entities": mapper = Mapper<NotificationTextEntityMapper>().map(JSON: json)
            case "creation_entities": mapper = Mapper<NotificationTextEntityMapper>().map(JSON: json)
            case "gallery_entities": mapper = Mapper<NotificationTextEntityMapper>().map(JSON: json)
            case "comments": mapper = Mapper<CommentMapper>().map(JSON: json)
            case "partner_applications": mapper = Mapper<PartnerApplicationsMapper>().map(JSON: json)
            case "app_screenshots": mapper = Mapper<AppScreenshotMapper>().map(JSON: json)
            default: mapper = nil
        }

        return mapper
    }

    open func dataIncludeMapper(sender: DataIncludeMapper, objectFor mapper: Mappable, metadata: Metadata?) -> Identifiable? {
        if let mapper = mapper as? UserMapper { return User(mapper: mapper, dataMapper: sender, metadata: metadata) }
        if let mapper = mapper as? CreationMapper { return Creation(mapper: mapper, dataMapper: sender, metadata: metadata) }
        if let mapper = mapper as? GalleryMapper { return Gallery(mapper:  mapper, dataMapper: sender, metadata: metadata) }
        if let mapper = mapper as? PartnerApplicationsMapper { return PartnerApplication(mapper: mapper, dataMapper: sender, metadata: metadata) }
        if let mapper = mapper as? CommentMapper { return Comment(mapper:  mapper, dataMapper: sender, metadata: metadata) }
        if let mapper = mapper as? GallerySubmissionMapper { return GallerySubmission(mapper: mapper, dataMapper: sender) }
        if let mapper = mapper as? NotificationTextEntityMapper { return NotificationTextEntity(mapper: mapper, dataMapper: sender) }
        if let mapper = mapper as? PartnerApplicationsMapper { return PartnerApplication(mapper: mapper, dataMapper:sender) }
        if let mapper = mapper as? AppScreenshotMapper { return AppScreenshot(mapper: mapper) }

        //DataIncludeMapper isn't passed here intentionally to get rid of infinite recurrence User -> CustomStyle -> User -> ...
        if let mapper = mapper as? CustomStyleMapper { return CustomStyle(mapper: mapper) }

        return nil
    }
}
