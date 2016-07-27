//
//  ActivitiesDAO.swift
//  CreatubblesAPIClient
//
//  Created by Dawid Płatek on 22.07.2016.
//  Copyright © 2016 Nomtek. All rights reserved.
//

import UIKit

class ActivitiesDAO: NSObject {
    private let requestSender: RequestSender
    
    init(requestSender: RequestSender) {
        self.requestSender = requestSender
    }
    
    func getActivities(pagingData: PagingData?, completion: ActivitiesClosure?) -> RequestHandler {
        let request = ActivitiesRequest(page: pagingData?.page, perPage: pagingData?.pageSize)
        let handler = ActivitiesResponseHandler(completion: completion)
        return requestSender.send(request, withResponseHandler: handler)
    }
}