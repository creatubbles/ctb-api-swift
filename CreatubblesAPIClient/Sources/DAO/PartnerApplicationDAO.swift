//
//  PartnerApplicationDAO.swift
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

class PartnerApplicationDAO: NSObject, APIClientDAO {
    fileprivate let requestSender: RequestSender

    required init(dependencies: DAODependencies) {
        self.requestSender = dependencies.requestSender
    }

    func getPartnerApplicationCreations(_ id: String, pagingData: PagingData, completion: CreationsClosure?) -> RequestHandler {
        let request = FetchCreationsRequest(partnerApplicationId: id, pagingData: pagingData)
        let handler = FetchCreationsResponseHandler(completion: completion)
        return requestSender.send(request, withResponseHandler: handler)
    }
    
    func getPartnerApplicationGalleries(_ id: String, pagingData: PagingData, completion: GalleriesClosure?) -> RequestHandler {
        let request = GalleriesRequest(partnerApplicationId: id, pagingData: pagingData)
        let handler = GalleriesResponseHandler(completion: completion)
        return requestSender.send(request, withResponseHandler: handler)
    }
    
    func getPartnerApplication(_ id: String, completion: PartnerApplicationClosure?) -> RequestHandler {
        let request = PartnerApplicationRequest(id: id)
        let handler = PartnerApplicationResponseHandler(completion: completion)
        return requestSender.send(request, withResponseHandler: handler)
    }

    func searchPartnerApplications(_ query: String, completion: PartnerApplicationsClosure?) -> RequestHandler {
        let request = PartnerApplicationsSearchRequest(query: query)
        let handler = PartnerApplicationsSearchResponseHandler(completion: completion)
        return requestSender.send(request, withResponseHandler: handler)
    }
}
