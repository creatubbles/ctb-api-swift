//
//  CustomStyleEditRequest.swift
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

class CustomStyleEditRequest: Request
{
    override var method: RequestMethod   { return .put }
    override var endpoint: String        { return "users/\(userIdentifier)/custom_style" }
    override var parameters: Dictionary<String, AnyObject> { return prepareParameters() }
    
    fileprivate let userIdentifier: String
    fileprivate let data: CustomStyleEditData
    
    init(userIdentifier: String, data: CustomStyleEditData)
    {
        self.userIdentifier = userIdentifier
        self.data = data
    }
    
    fileprivate func prepareParameters() -> Dictionary<String, AnyObject>
    {
        var dataDict = Dictionary<String, AnyObject>()
        var attributesDict = Dictionary<String, AnyObject>()
        var relationshipsDict = Dictionary<String, AnyObject>()
        
        if let value = data.headerBackgroundIdentifier { attributesDict["header_background_id"] = value as AnyObject? }
        if let value = data.bodyBackgroundIdentifier   { attributesDict["body_background_id"] = value as AnyObject? }
        if let value = data.fontName                   { attributesDict["font"] = value as AnyObject? }
        if let value = data.bio                        { attributesDict["bio"] = value as AnyObject? }

        if let value = data.bodyColors                 { attributesDict["body_colors"] = value.map({ $0.hexValue() })  as AnyObject? }
        if let value = data.headerColors               { attributesDict["header_colors"] = value.map({ $0.hexValue()}) as AnyObject?}
        
        if let value = data.headerCreationIdentifier
        {
            relationshipsDict["header_creation"] = ["data" : ["id" : value] as AnyObject] as AnyObject
            attributesDict["header_background_id"] = "pattern0" as AnyObject?
        }
        if let value = data.bodyCreationIdentifier
        {
            relationshipsDict["body_creation"]   = ["data" : ["id" : value] as AnyObject] as AnyObject
            attributesDict["body_background_id"] = "pattern0" as AnyObject?
        }
        
        dataDict["attributes"] = attributesDict as AnyObject?
        dataDict["relationships"] = relationshipsDict as AnyObject?
        
        return ["data" : dataDict as AnyObject]
    }
}
