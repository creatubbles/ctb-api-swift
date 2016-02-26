//
//  NewCreatorRequest.swift
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

class NewCreatorRequest: Request
{
    override var method: RequestMethod  { return .POST }
    override var endpoint: String       { return "creators" }
    override var parameters: Dictionary<String, AnyObject>
    {
        return [
            "name": name,
            "display_name": displayName,
            "birth_year": birthYear,
            "birth_month": birthMonth,
            "country": countryCode,
            "gender": gender.rawValue
         ]
    }
    
    private let name: String
    private let displayName: String
    private let birthYear: Int
    private let birthMonth: Int
    private let countryCode: String
    private let gender: Gender
    
    init(name: String, displayName: String, birthYear: Int, birthMonth: Int, countryCode: String, gender: Gender)
    {
        self.name = name
        self.displayName = displayName
        self.birthYear = birthYear
        self.birthMonth = birthMonth
        self.countryCode = countryCode
        self.gender = gender
    }
}
