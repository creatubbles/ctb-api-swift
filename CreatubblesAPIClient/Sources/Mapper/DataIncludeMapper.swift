//
//  DataIncludeMapper.swift
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

import Foundation
import ObjectMapper

public class DataIncludeMapper
{
    fileprivate let metadata: Metadata?
    fileprivate let includeResponse: Array<Dictionary<String, AnyObject>>
    fileprivate lazy var mappers: Dictionary<String, Mappable> = self.parseMappers()
    
    init(includeResponse: Array<Dictionary<String, AnyObject>>, metadata: Metadata?)
    {
        self.metadata = metadata
        self.includeResponse = includeResponse
    }
    
    fileprivate func parseMappers() -> Dictionary<String, Mappable>
    {
        var mappers = Dictionary<String, Mappable>()
        for object in includeResponse
        {
            if let mappedObject = mapperForObject(object)
            {
                mappers[mappedObject.identifier] = mappedObject.mapper
            }
        }
        
        return mappers
    }
    
    func objectWithIdentifier<T: Identifiable>(_ identifier: String, type: T.Type) -> T?
    {
        guard let mapper = mappers[identifier]
        else { return nil }
        
        if let mapper = mapper as? UserMapper     { return User(mapper: mapper, dataMapper: self, metadata: metadata) as? T }
        if let mapper = mapper as? CreationMapper { return Creation(mapper: mapper, dataMapper: self, metadata: metadata) as? T }
        if let mapper = mapper as? GalleryMapper  { return Gallery(mapper:  mapper, dataMapper: self, metadata: metadata) as? T }
        if let mapper = mapper as? PartnerApplicationsMapper { return PartnerApplication(mapper: mapper, dataMapper: self, metadata: metadata) as? T}
        if let mapper = mapper as? CommentMapper  { return Comment(mapper:  mapper, dataMapper: self, metadata: metadata) as? T }
        if let mapper = mapper as? GallerySubmissionMapper { return GallerySubmission(mapper: mapper, dataMapper: self) as? T }
        if let mapper = mapper as? NotificationTextEntityMapper { return NotificationTextEntity(mapper: mapper, dataMapper: self) as? T }
        if let mapper = mapper as? PartnerApplicationsMapper { return PartnerApplication(mapper: mapper, dataMapper: self) as? T }
        if let mapper = mapper as? AppScreenshotMapper { return AppScreenshot(mapper: mapper) as? T }
        
        //DataIncludeMapper isn't passed here intentionally to get rid of infinite recurrence User -> CustomStyle -> User -> ...
        if let mapper = mapper as? CustomStyleMapper { return CustomStyle(mapper: mapper) as? T }
        
        return nil
    }
    
    //MARK: - Included response parse
    fileprivate func mapperForObject(_ obj: Dictionary<String, AnyObject>) -> (identifier: String, mapper: Mappable)?
    {
        guard   let typeString = obj["type"] as? String,
                let identifierString = obj["id"] as? String
        else { return nil }
        
        var mapper: Mappable? = nil
        
        switch typeString
        {
            case "users":     mapper = Mapper<UserMapper>().map(JSON: obj)
            case "creations": mapper = Mapper<CreationMapper>().map(JSON: obj)
            case "galleries": mapper = Mapper<GalleryMapper>().map(JSON: obj)
            case "partner_applications": mapper = Mapper<PartnerApplicationsMapper>().map(JSON: obj)
            case "custom_styles": mapper = Mapper<CustomStyleMapper>().map(JSON: obj)
            case "gallery_submissions": mapper = Mapper<GallerySubmissionMapper>().map(JSON: obj)
            case "user_entities": mapper = Mapper<NotificationTextEntityMapper>().map(JSON: obj)
            case "creation_entities": mapper = Mapper<NotificationTextEntityMapper>().map(JSON: obj)
            case "gallery_entities": mapper = Mapper<NotificationTextEntityMapper>().map(JSON: obj)
            case "comments": mapper = Mapper<CommentMapper>().map(JSON: obj)
            case "partner_applications": mapper = Mapper<PartnerApplicationsMapper>().map(JSON: obj)
            case "app_screenshots": mapper = Mapper<AppScreenshotMapper>().map(JSON: obj)
            
            
            default: mapper = nil
        }
        if (mapper == nil) { Logger.log(.warning, "Unknown typeString: \(typeString)") }
        return mapper == nil ? nil : (identifierString, mapper!)                
    }
}
