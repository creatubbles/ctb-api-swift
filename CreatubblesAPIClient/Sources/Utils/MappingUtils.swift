//
//  MappingUtils.swift
//  CreatubblesAPIClient
//
//  Created by Michal Miedlarz on 19.05.2016.
//  Copyright © 2016 Nomtek. All rights reserved.
//

import UIKit
import ObjectMapper

class MappingUtils
{
    class func relationshipFromMapper(mapper: RelationshipMapper?) -> Relationship?
    {
        return mapper == nil ? nil : Relationship(mapper: mapper!)
    }
    
    class func objectFromMapper<T: Identifiable>(mapper: DataIncludeMapper?, relationship: Relationship?, type: T.Type) -> T?
    {
        guard   let mapper = mapper,
        let relationship = relationship
        else { return nil }
        return mapper.objectWithIdentifier(relationship.identifier, type: T.self)
    }
    
    class func pagingInfoFromResponse(response: Dictionary<String, AnyObject>) -> PagingInfo
    {
        let mapper = Mapper<PagingInfoMapper>().map(response["meta"])!
        return PagingInfo(mapper: mapper)
    }
    
    class func metadataFromResponse(response: Dictionary<String, AnyObject>) -> Metadata?
    {
        let metadataMapper = Mapper<MetadataMapper>().map(response["meta"])
        return ( metadataMapper != nil ) ? Metadata(mapper: metadataMapper!) : nil
    }
    
    class func notificationMetadataFromResponse(response: Dictionary<String, AnyObject>) -> NotificationMetadata?
    {
        let metadataMapper = Mapper<NotificationMetadataMapper>().map(response["meta"])
        return ( metadataMapper != nil ) ? NotificationMetadata(mapper: metadataMapper!) : nil
    }
    
    class func dataIncludeMapperFromResponse(response: Dictionary<String, AnyObject>, metadata: Metadata?) -> DataIncludeMapper?
    {
        let includedResponse = response["included"] as? Array<Dictionary<String, AnyObject>>
        return ( includedResponse == nil ) ? nil : DataIncludeMapper(includeResponse: includedResponse!, metadata: metadata)
    }
}
