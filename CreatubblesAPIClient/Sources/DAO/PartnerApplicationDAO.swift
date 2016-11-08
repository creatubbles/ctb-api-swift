//
//  PartnerApplicationDAO.swift
//  CreatubblesAPIClient
//
//  Created by Nomtek on 04.08.2016.
//  Copyright © 2016 Nomtek. All rights reserved.
//

import UIKit

class PartnerApplicationDAO
{
    fileprivate let requestSender: RequestSender

    init(requestSender: RequestSender)
    {
        self.requestSender = requestSender
    }
    
    func getPartnerApplication(_ id: String, completion: PartnerApplicationClosure?) -> RequestHandler
    {
        let request = PartnerApplicationRequest(id: id)
        let handler = PartnerApplicationResponseHandler(completion: completion)
        return requestSender.send(request, withResponseHandler: handler)
    }
    
    func searchPartnerApplications(_ query: String, completion: PartnerApplicationsClosure?) -> RequestHandler
    {
        let request = PartnerApplicationsSearchRequest(query: query)
        let handler = PartnerApplicationsSearchResponseHandler(completion: completion)
        return requestSender.send(request, withResponseHandler: handler)
    }
}
