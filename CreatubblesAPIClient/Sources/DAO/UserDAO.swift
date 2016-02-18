//
//  UserDAO.swift
//  CreatubblesAPIClient
//
//  Created by Michal Miedlarz on 18.02.2016.
//  Copyright © 2016 Nomtek. All rights reserved.
//

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
        let request = CreatorsAndManagersRequest(userId: userId, page: pagingData?.page, perPage: pagingData?.pageSize, scope: [CreatorsAndManagersScopeElement.Creators])
        let handler = CreatorsAndManagersResponseHandler(completion: completion)
        requestSender.send(request, withResponseHandler: handler)
    }
    
    func getManagers(userId: String?, pagingData: PagingData?,completion: UsersClousure?)
    {
        let request = CreatorsAndManagersRequest(userId: userId, page: pagingData?.page, perPage: pagingData?.pageSize, scope: [CreatorsAndManagersScopeElement.Managers])
        let handler = CreatorsAndManagersResponseHandler(completion: completion)
        requestSender.send(request, withResponseHandler: handler)
    }
    
    func newCreator(data: NewCreatorData, completion: UserClousure?)
    {
        let request = NewCreatorRequest(name: data.name, displayName: data.displayName, birthYear: data.birthYear, birthMonth: data.birthMonth, countryCode: data.countryCode, gender: data.gender)
        let handler = NewCreatorResponseHandler(completion: completion)
        requestSender.send(request, withResponseHandler: handler)
    }
}
