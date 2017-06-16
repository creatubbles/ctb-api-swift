//
//  NewCreatorRequest.swift
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

class NewCreatorRequest: Request {
    override var method: RequestMethod { return .post }
    override var endpoint: String { return "creators" }
    override var parameters: Dictionary<String, AnyObject> {
        return prepareParams()

    }

    fileprivate let name: String
    fileprivate let displayName: String?
    fileprivate let birthYear: Int?
    fileprivate let birthMonth: Int?
    fileprivate let countryCode: String?
    fileprivate let gender: Gender?

    init(name: String, displayName: String?, birthYear: Int?, birthMonth: Int?, countryCode: String?, gender: Gender?) {
        self.name = name
        self.displayName = displayName
        self.birthYear = birthYear
        self.birthMonth = birthMonth
        self.countryCode = countryCode
        self.gender = gender
    }

    fileprivate func prepareParams() -> Dictionary<String, AnyObject> {
        var params = Dictionary<String, AnyObject>()
        params["name"] = name as AnyObject?

        if let displayName = displayName {
            params["display_name"] = displayName as AnyObject?
        }
        if let birthYear = birthYear {
            params["birth_year"] = birthYear as AnyObject?
        }
        if let birthMonth = birthMonth {
            params["birth_month"] = birthMonth as AnyObject?
        }
        if let countryCode = countryCode {
            params["country"] = countryCode as AnyObject?
        }
        if let gender = gender {
            params["gender"] = gender.rawValue as AnyObject?
        }

        return params
    }
}
