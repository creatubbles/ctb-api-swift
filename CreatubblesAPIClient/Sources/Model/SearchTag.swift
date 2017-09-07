//
//  CreatubblesAPIClient.swift
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

import UIKit

open class SearchTag: NSObject, Identifiable {
    // Mock of the model until implemented on API side
    open let identifier: String
    open let name: String
    open let imageURL: String
    open let translatedNames: Array<NameTranslationObject>

    init(name: String, imageURL: String) {
        self.name = name
        self.imageURL = imageURL
        self.identifier = NSUUID().uuidString
        self.translatedNames = []
    }

    init(name: String, imageURL: String, identifier: String, translatedNames: Array<NameTranslationObject>) {
        self.identifier = identifier
        self.name = name
        self.imageURL = imageURL
        self.translatedNames = translatedNames
    }
    
    init(mapper: SearchTagMapper, dataMapper: DataIncludeMapper? = nil, metadata: Metadata? = nil)
    {
        identifier = mapper.identifier!
        name = mapper.name!
        imageURL = mapper.imageURL!
        
        if let translatedNamesMappers = mapper.translatedNamesMap
        {
            translatedNames = translatedNamesMappers.flatMap({ $0.isValid() ? NameTranslationObject(mapper: $0) : nil })
        }
        else
        {
            translatedNames = []
        }
    }
}
