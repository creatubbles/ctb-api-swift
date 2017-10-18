//
//  DataIncludeMapper.swift
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

public protocol DataIncludeMapperParser {
    func dataIncludeMapper(sender: DataIncludeMapper, mapperFor json: [String: Any], typeString: String) -> Mappable?
    func dataIncludeMapper(sender: DataIncludeMapper, objectFor mapper: Mappable, metadata: Metadata?, shouldMap2ndLevelRelationships: Bool) -> Identifiable?
}

public class DataIncludeMapper {
    private let metadata: Metadata?
    private let includeResponse: Array<Dictionary<String, AnyObject>>
    private lazy var mappers: Dictionary<String, Mappable> = self.parseMappers()
    private let parser: DataIncludeMapperParser
    private let allow2ndLevelRelationships: Bool
    
    public init(includeResponse: Array<Dictionary<String, AnyObject>>, metadata: Metadata?, parser: DataIncludeMapperParser = DataIncludeMapperDefaultParser(), allow2ndLevelRelationships: Bool) {
        self.metadata = metadata
        self.includeResponse = includeResponse
        self.parser = parser
        self.allow2ndLevelRelationships = allow2ndLevelRelationships
    }
    
    fileprivate func parseMappers() -> Dictionary<String, Mappable> {
        var mappers = Dictionary<String, Mappable>()
        for object in includeResponse {
            if let mappedObject = mapperForObject(object) {
                mappers[mappedObject.identifier] = mappedObject.mapper
            }
        }
        
        return mappers
    }
    
    func objectWithIdentifier<T: Identifiable>(_ identifier: String, type: T.Type) -> T? {
        guard let mapper = mappers[identifier]
            else { return nil }
        
        return parser.dataIncludeMapper(sender: self, objectFor: mapper, metadata: metadata, shouldMap2ndLevelRelationships: allow2ndLevelRelationships) as? T
    }
    
    // MARK: - Included response parse
    fileprivate func mapperForObject(_ obj: Dictionary<String, AnyObject>) -> (identifier: String, mapper: Mappable)? {
        guard   let typeString = obj["type"] as? String,
            let identifierString = obj["id"] as? String
            else { return nil }
        
        let mapper = parser.dataIncludeMapper(sender: self, mapperFor: obj, typeString: typeString)
        
        if (mapper == nil) { Logger.log(.warning, "Unknown typeString: \(typeString)") }
        return mapper == nil ? nil : (identifierString, mapper!)
    }
}
