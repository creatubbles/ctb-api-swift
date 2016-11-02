//
//  NewCreationData.swift
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

import UIKit

enum CreationDataType: Int
{
    case image = 0
    case url = 1
    case data = 2
}

@objc
open class NewCreationData: NSObject
{
    open let uploadExtension: UploadExtension
    
    open var data: NSData?
    open var image: UIImage?
    open var url: URL?
    open var creationIdentifier: String?
    
    
    open var name: String? = nil
    open var reflectionText: String? = nil
    open var reflectionVideoUrl: String? = nil
    open var galleryId: String? = nil
    open var creatorIds: Array<String>? = nil
    open var creationYear: Int? = nil
    open var creationMonth: Int? = nil
    
    let dataType: CreationDataType
    
    public init(data: Data, uploadExtension: UploadExtension)
    {
        self.data = data as NSData?
        self.dataType = .data
        self.uploadExtension = uploadExtension
    }
    public init(image: UIImage, uploadExtension: UploadExtension)
    {
        self.image = image
        self.dataType = .image
        self.uploadExtension = uploadExtension
    }
    public init(url: URL, uploadExtension: UploadExtension)
    {
        self.url = url
        self.dataType = .url
        self.uploadExtension = uploadExtension
    }
    
    init(creationDataEntity: NewCreationDataEntity, url: URL)
    {
        self.creationIdentifier = creationDataEntity.creationIdentifier
        self.name = creationDataEntity.name
        self.reflectionText = creationDataEntity.reflectionText
        self.reflectionVideoUrl = creationDataEntity.reflectionVideoUrl
        self.galleryId = creationDataEntity.galleryId
        self.creatorIds = Array<String>()
        self.uploadExtension = creationDataEntity.uploadExtension
        
        for creatorId in creationDataEntity.creatorIds
        {
            self.creatorIds!.append(creatorId.creatorIdString!)
        }
        self.creationMonth = creationDataEntity.creationMonth.value
        self.creationYear = creationDataEntity.creationYear.value
        self.dataType = creationDataEntity.dataType
        
        if(dataType.rawValue == 0)
        {
            self.image = UIImage(contentsOfFile: url.path)
        }
        else if(dataType.rawValue == 1)
        {
            self.url = url
        }
        else if(dataType.rawValue == 2)
        {
            self.data = try? Data(contentsOf: URL(fileURLWithPath: "\(url)"))
        }
    }
    
    //MARK: objc compability
    open func getCreationYear() -> NSNumber?
    {
        if let year = creationYear
        {
            return NSNumber(value: year as Int)
        }
        return nil
    }
    
    open func getCreationMonth() -> NSNumber?
    {
        if let month = creationMonth
        {
            return NSNumber(value: month as Int)
        }
        return nil
    }
    
    open func setCreationYear(_ year: NSNumber?)
    {
        if let year = year
        {
            creationYear = year.intValue;
        }
    }
    
    open func setCreationMonth(_ month: NSNumber?)
    {
        if let month = month
        {
            creationMonth = month.intValue
        }
    }
}
