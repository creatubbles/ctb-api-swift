//
// Created by Michal Miedlarz on 01.04.2016.
// Copyright (c) 2016 Nomtek. All rights reserved.
//

import Foundation
import ObjectMapper

class DataIncludeMapper
{
    private let includeResponse: Array<Dictionary<String, AnyObject>>
    private lazy var objects: Dictionary<String, Identifiable> =  self.parseObjects()
    
    init(includeResponse: Array<Dictionary<String, AnyObject>>) {
        self.includeResponse = includeResponse
    }

    private func parseObjects() -> Dictionary<String, Identifiable>
    {
        var models = Dictionary<String, Identifiable>()
        for object in includeResponse
        {
            if let model = modelForObject(object)
            {
                models[model.identifier] = model
            }
        }
        return models
    }

    func objectWithIdentifier<T: Identifiable>(identifier: String, type: T.Type) -> T?
    {
        return objects[identifier] as? T
    }

    //MARK: - Included response parse
    private func modelForObject(obj: Dictionary<String, AnyObject>) -> Identifiable?
    {
        guard let typeString = obj["type"] as? String
        else { return nil }

        switch typeString
        {
            case "users": return userModelFromObject(obj)
            case "creations": return creationModelFromObject(obj)
            case "galleries": return galleryModelFromObject(obj)
            default: return nil
        }
    }

    private func userModelFromObject(object: Dictionary<String, AnyObject>) -> User?
    {
        if let mapper = Mapper<UserMapper>().map(object)
        {
            return User(mapper: mapper)
        }
        return nil
    }

    private func creationModelFromObject(object: Dictionary<String, AnyObject>) -> Creation?
    {
        if let mapper = Mapper<CreationMapper>().map(object)
        {
            return Creation(mapper: mapper)
        }
        return nil
    }
    
    private func galleryModelFromObject(object: Dictionary<String, AnyObject>) -> Gallery?
    {
        if let mapper = Mapper<GalleryMapper>().map(object)
        {
            return Gallery(mapper: mapper)
        }
        return nil
    }

}
