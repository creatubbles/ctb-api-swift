//
//  UserFollowingsDAO.swift
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

class UserFollowingsDAO: NSObject, APIClientDAO {
    fileprivate let requestSender: RequestSender

    required init(dependencies: DAODependencies) {
        self.requestSender = dependencies.requestSender
    }

    func createAUserFollowing(_ userId: String, completion: ErrorClosure?) -> RequestHandler {
        let request = CreateAUserFollowingRequest(userId: userId)
        let handler = CreateAUserFollowingResponseHandler(completion: completion)
        return requestSender.send(request, withResponseHandler: handler)
    }

    func deleteAUserFollowing(_ userId: String, completion: ErrorClosure?) -> RequestHandler {
        let request = DeleteAUserFollowingRequest(userId: userId)
        let handler = DeleteAUserFollowingResponseHandler(completion: completion)
        return requestSender.send(request, withResponseHandler: handler)
    }
}
