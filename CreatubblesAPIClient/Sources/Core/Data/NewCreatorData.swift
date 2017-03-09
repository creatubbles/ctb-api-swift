//
//  NewCreatorData.swift
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

@objc
open class NewCreatorData: NSObject
{
    open let name: String
    open let displayName: String?
    open let birthYear: Int?
    open let birthMonth: Int?
    open let countryCode: String?
    open let gender: Gender?
    
    public init(name: String, displayName: String? = nil, birthYear: Int? = nil, birthMonth: Int? = nil,
                countryCode: String? = nil, gender: Gender? = nil)
    {
        self.name = name
        self.displayName = displayName
        self.birthMonth = birthMonth
        self.birthYear = birthYear
        self.countryCode = countryCode
        self.gender = gender
    }
    
    //ObjC Compability
    public init(name: String, gender: Gender, birthYear: Int, birthMonth: Int, displayName: String? = nil, countryCode: String? = nil)
    {
        self.name = name
        self.displayName = displayName
        self.birthMonth = birthMonth
        self.birthYear = birthYear
        self.countryCode = countryCode
        self.gender = gender
    }    
}
