//
//  NewCreationDataEntity.swift
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

import Foundation
import RealmSwift

class CreatorIdString: Object
{
    dynamic var creatorIdString: String?
}

class GalleryIdString: Object
{
    dynamic var galleryIdString: String?
}

class NewCreationDataEntity: Object
{
    dynamic var name: String?
    dynamic var creationIdentifier: String?
    dynamic var localIdentifier: String?
    dynamic var reflectionText: String?
    dynamic var reflectionVideoUrl: String?
    dynamic var galleryId: String?
    dynamic var uploadExtensionRaw: String?
    
    var creatorIds = List<CreatorIdString>()
    var galleryIds = List<GalleryIdString>()
    
    var creationYear = RealmOptional<Int>()
    var creationMonth = RealmOptional<Int>()
    
    var dataTypeRaw = RealmOptional<Int>()
    
    var dataType: CreationDataType
    {
        get
        {
            return CreationDataType(rawValue: dataTypeRaw.value!)!
        }
    }
    
    var storageTypeRaw = RealmOptional<Int>()
    
    var storageType: CreationDataStorageType {
        get {
            return CreationDataStorageType(rawValue: storageTypeRaw.value!)!
        }
    }
    
    var uploadExtension: UploadExtension
    {
        return UploadExtension.fromString(uploadExtensionRaw!)!
    }
}
