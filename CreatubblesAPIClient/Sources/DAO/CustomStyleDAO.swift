//
//  CustomStyleDAO.swift
//  CreatubblesAPIClient
//
//  Created by Michal Miedlarz on 04.06.2016.
//  Copyright © 2016 Nomtek. All rights reserved.
//

import UIKit

class CustomStyleDAO
{
    private let requestSender: RequestSender
    
    init(requestSender: RequestSender)
    {
        self.requestSender = requestSender
    }
    
    func fetchCustomStyleForUserWithIdentifier(userIdentifier identifier: String, completion: CustomStyleClosure?) -> RequestHandler
    {
        let request = CustomStyleFetchRequest(userIdentifier: identifier)
        let handler = CustomStyleFetchResponseHandler(completion: completion)
        return requestSender.send(request, withResponseHandler: handler)
    }
    
    func editCustomStyleForUserWithIdentifier(userIdentifier identifier: String, withData data: CustomStyleEditData, completion: CustomStyleClosure?) -> RequestHandler
    {
        let request = CustomStyleEditRequest(userIdentifier: identifier, data: data)
        let handler = CustomStyleEditResponseHandler(completion: completion)
        return requestSender.send(request, withResponseHandler: handler)
    }
}
