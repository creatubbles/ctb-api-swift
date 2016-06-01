//
// Created by Michal Miedlarz on 01.04.2016.
// Copyright (c) 2016 Nomtek. All rights reserved.
//

import Foundation
import ObjectMapper

class DataIncludeMapper
{
    private let includeResponse: Array<Dictionary<String, AnyObject>>
    private lazy var mappers: Dictionary<String, Mappable> = self.parseMappers()
    
    init(includeResponse: Array<Dictionary<String, AnyObject>>)
    {
        self.includeResponse = includeResponse
    }
    
    private func parseMappers() -> Dictionary<String, Mappable>
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
    
    func objectWithIdentifier<T: Identifiable>(identifier: String, type: T.Type) -> T?
    {
        guard let mapper = mappers[identifier]
        else { return nil }
        
        if let mapper = mapper as? UserMapper     { return User(mapper: mapper) as? T }
        if let mapper = mapper as? CreationMapper { return Creation(mapper: mapper, dataMapper: self) as? T }
        if let mapper = mapper as? GalleryMapper  { return Gallery(mapper:  mapper, dataMapper: self) as? T }
        
        return nil
    }
    
    //MARK: - Included response parse
    private func mapperForObject(obj: Dictionary<String, AnyObject>) -> (identifier: String, mapper: Mappable)?
    {
        guard   let typeString = obj["type"] as? String,
                let identifierString = obj["id"] as? String
        else { return nil }
        
        var mapper: Mappable? = nil
        
        switch typeString
        {
            case "users":     mapper = Mapper<UserMapper>().map(obj)
            case "creations": mapper = Mapper<CreationMapper>().map(obj)
            case "galleries": mapper = Mapper<GalleryMapper>().map(obj)
            default: mapper = nil
        }
        if let mapper = mapper
        {
            return (identifierString, mapper)
        }
        
        return nil
    }
}
