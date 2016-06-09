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
    case Image = 0
    case Url = 1
    case Data = 2
}

@objc
public class NewCreationData: NSObject
{
    public var data: NSData?
    public var image: UIImage?
    public var url: NSURL?
    public var uploadExtension: UploadExtension?
    
    public var name: String? = nil
    public var reflectionText: String? = nil
    public var reflectionVideoUrl: String? = nil
    public var galleryId: String? = nil
    public var creatorIds: Array<String>? = nil
    public var creationYear: Int? = nil
    public var creationMonth: Int? = nil
    
    let dataType: CreationDataType
    
    public init(data: NSData, uploadExtension: UploadExtension)
    {
        self.data = data
        self.dataType = .Data
        self.uploadExtension = uploadExtension
    }
    public init(image: UIImage, uploadExtension: UploadExtension)
    {
        self.image = image
        self.dataType = .Image
        self.uploadExtension = uploadExtension
    }
    public init(url: NSURL, uploadExtension: UploadExtension)
    {
        self.url = url
        self.dataType = .Url
        self.uploadExtension = uploadExtension
    }
    init(creationDataEntity: NewCreationDataEntity, url: NSURL)
    {
        self.name = creationDataEntity.name
        self.reflectionText = creationDataEntity.reflectionText
        self.reflectionVideoUrl = creationDataEntity.reflectionVideoUrl
        self.galleryId = creationDataEntity.galleryId
        self.creatorIds = Array<String>()
        
        for creatorId in creationDataEntity.creatorIds
        {
            self.creatorIds!.append(creatorId.creatorIdString!)
        }
        self.creationMonth = creationDataEntity.creationMonth.value
        self.creationYear = creationDataEntity.creationYear.value
        self.dataType = creationDataEntity.dataType
        
        if(dataType.rawValue == 0)
        {
            self.image = UIImage(contentsOfFile: url.path!)
        }
        else if(dataType.rawValue == 1)
        {
            self.url = url
        }
        else if(dataType.rawValue == 2)
        {
            self.data = NSData(contentsOfFile: "\(url)")
        }
    }
    
    //MARK: objc compability
    public func getCreationYear() -> NSNumber?
    {
        if let year = creationYear
        {
            return NSNumber(integer: year)
        }
        return nil
    }
    
    public func getCreationMonth() -> NSNumber?
    {
        if let month = creationMonth
        {
            return NSNumber(integer: month)
        }
        return nil
    }
    
    public func setCreationYear(year: NSNumber?)
    {
        if let year = year
        {
            creationYear = year.integerValue;
        }
    }
    
    public func setCreationMonth(month: NSNumber?)
    {
        if let month = month
        {
            creationMonth = month.integerValue
        }
    }
}
