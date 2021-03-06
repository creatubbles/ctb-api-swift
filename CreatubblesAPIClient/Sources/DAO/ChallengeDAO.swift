//
//  ChallengeDAO.swift
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

class ChallengeDAO: NSObject, APIClientDAO {
    fileprivate let requestSender: RequestSender
    
    required init(dependencies: DAODependencies) {
        self.requestSender = dependencies.requestSender
    }
    
    func getHomeChallenges(pagingData: PagingData?, completion: ChallengesClosure?) -> RequestHandler {
        let request = ChallengesRequest(group: .home, page: pagingData?.page, perPage: pagingData?.pageSize)
        let handler = ChallengesResponseHandler(completion: completion)
        return requestSender.send(request, withResponseHandler: handler)
    }
    
    func getFavoriteChallenges(pagingData: PagingData?, completion: ChallengesClosure?) -> RequestHandler {
        let request = ChallengesRequest(group: .favorite, page: pagingData?.page, perPage: pagingData?.pageSize)
        let handler = ChallengesResponseHandler(completion: completion)
        return requestSender.send(request, withResponseHandler: handler)
    }
    
    func getPopularChallenges(pagingData: PagingData?, completion: ChallengesClosure?) -> RequestHandler {
        let request = ChallengesRequest(group: .popular, page: pagingData?.page, perPage: pagingData?.pageSize)
        let handler = ChallengesResponseHandler(completion: completion)
        return requestSender.send(request, withResponseHandler: handler)
    }
    
    func getChallengeDetailsChallenges(pagingData: PagingData?, completion: ChallengesClosure?) -> RequestHandler {
        let request = ChallengesRequest(group: .challengeDetails, page: pagingData?.page, perPage: pagingData?.pageSize)
        let handler = ChallengesResponseHandler(completion: completion)
        return requestSender.send(request, withResponseHandler: handler)
    }
    
    func getNonPaginatedChallenges(completion: ChallengesClosure?) -> RequestHandler {
        let request = ChallengesRequest(page: 1, perPage: 100)
        let handler = ChallengesResponseHandler(completion: completion)
        return requestSender.send(request, withResponseHandler: handler)
    }
    
    func getChallengeDetails(id: String, completion: ChallengeClosure?) -> RequestHandler {
        let request = ChallengeRequest(id: id)
        let handler = ChallengeResponseHandler(completion: completion)
        return requestSender.send(request, withResponseHandler: handler)
    }
    
    func getOpenChallenges(pagingData: PagingData?, completion: ChallengesClosure?) -> RequestHandler {
        // Undefined are threated as open
        let request = ChallengesRequest(state: .undefined, page: pagingData?.page, perPage: pagingData?.pageSize)
        let handler = ChallengesResponseHandler(completion: completion)
        return requestSender.send(request, withResponseHandler: handler)
    }
    
    func getClosedChallenges(pagingData: PagingData?, completion: ChallengesClosure?) -> RequestHandler {
        let request = ChallengesRequest(state: .closed, page: pagingData?.page, perPage: pagingData?.pageSize)
        let handler = ChallengesResponseHandler(completion: completion)
        return requestSender.send(request, withResponseHandler: handler)
    }
}
