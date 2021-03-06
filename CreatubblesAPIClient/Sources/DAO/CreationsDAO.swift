//
//  CreationsDAO.swift
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

class CreationsDAO: NSObject, APIClientDAO {
    fileprivate let requestSender: RequestSender

    required init(dependencies: DAODependencies) {
        self.requestSender = dependencies.requestSender
    }

    func getCreation(creationIdentifier creationId: String, completion: CreationClosure?) -> RequestHandler {
        let request = FetchCreationsRequest(creationId: creationId)
        let handler = FetchCreationsResponseHandler {
            (creations, _, error) -> (Void) in
            completion?(creations?.first, error)
        }
        return requestSender.send(request, withResponseHandler: handler)
    }

    func reportCreation(creationIdentifier creationId: String, message: String, completion: ErrorClosure?) -> RequestHandler {
        let request = ReportCreationRequest(creationId: creationId, message: message)
        let handler = ReportCreationResponseHandler(completion: completion)
        return requestSender.send(request, withResponseHandler: handler)
    }

    func getRecomendedCreationsByUser(userIdentifier userId: String, pagingData: PagingData?, completon: CreationsClosure?) -> RequestHandler {
        let request = FetchCreationsRequest(page: pagingData?.page, perPage: pagingData?.pageSize, recommendedUserId: userId)
        let handler = FetchCreationsResponseHandler(completion: completon)
        return requestSender.send(request, withResponseHandler: handler)
    }

    func getRecomendedCreationsByCreation(creationIdentifier creationId: String, pagingData: PagingData?, completon: CreationsClosure?) -> RequestHandler {
        let request = FetchCreationsRequest(page: pagingData?.page, perPage: pagingData?.pageSize, recommendedCreationId: creationId)
        let handler = FetchCreationsResponseHandler(completion: completon)
        return requestSender.send(request, withResponseHandler: handler)
    }

    func getCreations(galleryIdentifier galleryId: String?, userId: String?, keyword: String?, pagingData: PagingData?, sortOrder: SortOrder?, partnerApplicationId: String?, onlyPublic: Bool, completion: CreationsClosure?) -> RequestHandler {
        let request = FetchCreationsRequest(page: pagingData?.page, perPage: pagingData?.pageSize, galleryId: galleryId, userId: userId, sort: sortOrder, keyword: keyword, partnerApplicationId: partnerApplicationId, onlyPublic: onlyPublic)
        let handler = FetchCreationsResponseHandler(completion: completion)
        return requestSender.send(request, withResponseHandler: handler)
    }

    func editCreation(creationIdentifier creationId: String, data: EditCreationData, completion: ErrorClosure?) -> RequestHandler {
        let request = EditCreationRequest(identifier: creationId, data: data)
        let handler = EditCreationResponseHandler(completion: completion)
        return requestSender.send(request, withResponseHandler: handler)
    }

    func removeCreation(creationIdentifier creationId: String, completion: ErrorClosure?) -> RequestHandler {
        let request = RemoveCreationRequest(creationId: creationId)
        let handler = RemoveCreationResponseHandler(completion: completion)
        return requestSender.send(request, withResponseHandler: handler)
    }

    func getToybooCreation(creationIdentifier creationId: String, completion: ToybooCreationClosure?) -> RequestHandler {
        let request = FetchToybooCreationRequest(creationId: creationId)
        let handler = FetchToybooCreationResponseHandler(completion: completion)
        return requestSender.send(request, withResponseHandler: handler)
    }
    
    func incrementViewsCount(creationIdentifier creationId: String, completion: ErrorClosure?) -> RequestHandler {
        let request = CreationViewsCountIncrementRequest(creationIdentifier: creationId)
        let handler = CreationViewsCountIncrementResponseHandler(completion: completion)
        return requestSender.send(request, withResponseHandler: handler)
    }
    
    func getTrendingCreations(completion: CreationsClosure?) -> RequestHandler {
        let request = FetchTrendingCreationsRequest()
        let handler = FetchTrendingCreationsResponseHandler(completion: completion)
        return requestSender.send(request, withResponseHandler: handler)
    }

    func favoriteCreation(creationIdentifier creationId: String, completion: ErrorClosure?) -> RequestHandler {
        let request = FavoriteCreationRequest(creationId: creationId)
        let handler = FavoriteCreationResponseHandler(completion: completion)
        return requestSender.send(request, withResponseHandler: handler)
    }
    
    func removeFavoriteCreation(creationIdentifier creationId: String, completion: ErrorClosure?) -> RequestHandler {
        let request = RemoveFavoriteCreationRequest(creationId: creationId)
        let handler = RemoveFavoriteCreationResponseHandler(completion: completion)
        return requestSender.send(request, withResponseHandler: handler)
    }
    
    func getCreationsForChallenge(challengeIdentifier challengeId: String?, pagingData: PagingData?, sortOrder: SortMethod?, completion: CreationsClosure?) -> RequestHandler {
        let request = FetchCreationsForChallengeRequest(page: pagingData?.page, perPage: pagingData?.pageSize, challengeId: challengeId, sort: sortOrder)
        let handler = FetchCreationsForChallengeResponseHandler(completion: completion)
        return requestSender.send(request, withResponseHandler: handler)
    }
    
    func getCreationsForHub(hubId: String?, pagingData: PagingData?, sortOrder: SortMethod?, completion: CreationsClosure?) -> RequestHandler {
        let request = FetchCreationsForHubRequest(page: pagingData?.page, perPage: pagingData?.pageSize, hubId: hubId, sort: sortOrder)
        let handler = FetchCreationsForHubResponseHandler(completion: completion)
        return requestSender.send(request, withResponseHandler: handler)
    }
    
    func submitCreationToHub(creationIdentifier creationId: String, hubId: String, completion: ErrorClosure?) -> RequestHandler {
        let request = SubmitCreationToHubRequest(creationId: creationId, hubId: hubId)
        let handler = SubmitCreationToHubResponseHandler(completion: completion)
        return requestSender.send(request, withResponseHandler: handler)
    }
    
    // MARK: BatchMode
    func getCreationsInBatchMode(galleryIdentifier galleryId: String?, userId: String?, keyword: String?, sortOrder: SortOrder?, partnerApplicationId: String?, onlyPublic: Bool, completion: CreationsBatchClosure?) -> RequestHandler {
        let fetcher = CreationsQueueBatchFetcher(requestSender: requestSender, userId: userId, galleryId: galleryId, keyword: keyword, partnerApplicationId: partnerApplicationId, sort: sortOrder, onlyPublic: onlyPublic, completion: completion)
        return fetcher.fetch()
    }
}
