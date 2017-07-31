//
//  EditCreationRequest.swift
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

class EditCreationRequest: Request {
    override var method: RequestMethod { return .put }
    override var endpoint: String { return "creations/\(identifier)" }
    override var parameters: Dictionary<String, AnyObject> { return prepareParameters() }

    fileprivate let identifier: String
    fileprivate let data: EditCreationData

    init(identifier: String, data: EditCreationData) {
        self.identifier = identifier
        self.data = data
    }

    fileprivate func prepareParameters() -> Dictionary<String, AnyObject> {
        var dataDict = Dictionary<String, AnyObject>()
        var attributesDict = Dictionary<String, AnyObject>()

        if let value = data.name { attributesDict["name"] = value as AnyObject? }
        if let value = data.reflectionText { attributesDict["reflection_text"] = value as AnyObject? }
        if let value = data.reflectionVideoURL { attributesDict["reflection_video_url"] = value as AnyObject? }
        if let value = data.tags { attributesDict["tags"] = value as AnyObject? }
        
        if let value = data.creationDate {
            let calendar = Calendar.current
            let components = (calendar as NSCalendar).components([.year, .month], from: value as Date)

            attributesDict["created_at_year"] = components.year as AnyObject?
            attributesDict["created_at_month"] = components.month as AnyObject?
        }

        dataDict["attributes"] = attributesDict as AnyObject?

        return ["data": dataDict as AnyObject]
    }
}
