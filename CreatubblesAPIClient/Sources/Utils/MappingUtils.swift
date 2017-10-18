//
//  MappingUtils.swift
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

public class MappingUtils {
    public class func relationshipFromMapper(_ mapper: RelationshipMapper?) -> Relationship? {
        guard let mapper = mapper,
                  mapper.isValid
        else {
            return nil
        }
        return Relationship(mapper: mapper)
    }

    public class func objectFromMapper<T: Identifiable>(_ mapper: DataIncludeMapper?, relationship: Relationship?, type: T.Type) -> T? {
        guard   let mapper = mapper,
        let relationship = relationship
        else { return nil }
        return mapper.objectWithIdentifier(relationship.identifier, type: T.self)
    }

    public class func pagingInfoFromResponse(_ response: Dictionary<String, AnyObject>) -> PagingInfo {
        let mapper = Mapper<PagingInfoMapper>().map(JSON: response["meta"] as! [String : Any])!
        return PagingInfo(mapper: mapper)
    }

    public class func metadataFromResponse(_ response: Dictionary<String, AnyObject>) -> Metadata? {
        let metadataMapper = Mapper<MetadataMapper>().map(JSONObject: response["meta"])

        return ( metadataMapper != nil ) ? Metadata(mapper: metadataMapper!) : nil
    }

    class func notificationMetadataFromResponse(_ response: Dictionary<String, AnyObject>) -> NotificationMetadata? {
        let metadataMapper = Mapper<NotificationMetadataMapper>().map(JSON: response["meta"] as! [String : Any])
        return ( metadataMapper != nil ) ? NotificationMetadata(mapper: metadataMapper!) : nil
    }

    public class func dataIncludeMapperFromResponse(_ response: Dictionary<String, AnyObject>, metadata: Metadata?, allow2ndLevelRelationships: Bool = true) -> DataIncludeMapper? {
        let includedResponse = response["included"] as? Array<Dictionary<String, AnyObject>>
        return ( includedResponse == nil ) ? nil : DataIncludeMapper(includeResponse: includedResponse!, metadata: metadata, allow2ndLevelRelationships: allow2ndLevelRelationships)
    }

    public class func bubbledStateFrom(metadata: Metadata?, forObjectWithIdentifier identifier: String) -> Bool {
        return (metadata?.bubbledCreationIdentifiers.contains(identifier) ?? false) || (metadata?.bubbledUserIdentifiers.contains(identifier) ?? false) || (metadata?.bubbledGalleryIdentifiers.contains(identifier) ?? false)
    }

    public class func abilitiesFrom(metadata: Metadata?, forObjectWithIdentifier identifier: String) -> Array<Ability> {
        guard let metadata = metadata
        else { return [] }
        let abilities = metadata.abilities.filter({ $0.resourceIdentifier == identifier })
        let allAbilities = metadata.abilities.filter({ $0.identifier.hasPrefix("all:") })

        return abilities + allAbilities
    }
}
