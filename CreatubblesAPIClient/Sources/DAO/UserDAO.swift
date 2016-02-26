//
//  UserDAO.swift
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

class UserDAO
{
    private let requestSender: RequestSender
    
    init(requestSender: RequestSender)
    {
        self.requestSender = requestSender
    }
    
    func getUser(userId: String, completion: UserClousure?)
    {
        let request = ProfileRequest(userId: userId)
        let handler = ProfileResponseHandler(completion: completion)
        requestSender.send(request, withResponseHandler: handler)
    }
    
    func getCurrentUser(completion: UserClousure?)
    {
        let request = ProfileRequest()
        let handler = ProfileResponseHandler(completion: completion)
        requestSender.send(request, withResponseHandler: handler)
    }
    
    func getCreators(userId: String?, pagingData: PagingData?,completion: UsersClousure?)
    {
        let request = CreatorsAndManagersRequest(userId: userId, page: pagingData?.page, perPage: pagingData?.pageSize, scope: .Creators)
        let handler = CreatorsAndManagersResponseHandler(completion: completion)
        requestSender.send(request, withResponseHandler: handler)
    }
    
    func getManagers(userId: String?, pagingData: PagingData?,completion: UsersClousure?)
    {
        let request = CreatorsAndManagersRequest(userId: userId, page: pagingData?.page, perPage: pagingData?.pageSize, scope: .Managers)
        let handler = CreatorsAndManagersResponseHandler(completion: completion)
        requestSender.send(request, withResponseHandler: handler)
    }
    
    func getCreators(userId: String?, completion: UsersBatchClousure?)
    {
        let batchFetcher = UsersBatchFetcher(requestSender: requestSender)
        batchFetcher.fetch(userId, scope: .Creators, completion: completion)
    }
    
    func getManagers(userId: String?, completion: UsersBatchClousure?)
    {
        let batchFetcher = UsersBatchFetcher(requestSender: requestSender)
        batchFetcher.fetch(userId, scope: .Managers, completion: completion)
    }
    
    func newCreator(data: NewCreatorData, completion: UserClousure?)
    {
        let request = NewCreatorRequest(name: data.name, displayName: data.displayName, birthYear: data.birthYear, birthMonth: data.birthMonth, countryCode: data.countryCode, gender: data.gender)
        let handler = NewCreatorResponseHandler(completion: completion)
        requestSender.send(request, withResponseHandler: handler)
    }
}
