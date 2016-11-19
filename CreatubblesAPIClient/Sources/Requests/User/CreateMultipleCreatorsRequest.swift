//
//  CreateMultipleCreatorsRequest.swift
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
//


import UIKit

class CreateMultipleCreatorsRequest: Request
{
    override var method: RequestMethod  { return .post }
    override var endpoint: String       { return "creator_builder_jobs" }
    override var parameters: Dictionary<String, AnyObject> { return prepareParameters() }
    
    fileprivate let amount: Int
    fileprivate let birthYear: Int
    fileprivate let groupName: String?

    init(amount: Int, birthYear:Int, groupName: String?)
    {
        self.amount = amount
        self.birthYear = birthYear
        self.groupName = groupName
    }

    fileprivate func prepareParameters() -> Dictionary<String, AnyObject>
    {
        var params = Dictionary<String, AnyObject>()
        
        params["amount"] = amount as AnyObject?
        params["birth_year"] = birthYear as AnyObject?
        
        if let groupName = groupName
        {
            params["group"] = groupName as AnyObject?
        }
        
        return params
    }
}
