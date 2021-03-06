//
//  NotificationsFetchResponseHandler.swift
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
import ObjectMapper

class NotificationsFetchResponseHandler: ResponseHandler {
    fileprivate let completion: NotificationsClosure?

    init(completion: NotificationsClosure?) {
        self.completion = completion
    }

    override func handleResponse(_ response: Dictionary<String, AnyObject>?, error: Error?) {
        if  let response = response,
            let mappers = Mapper<NotificationMapper>().mapArray(JSONObject: response["data"]) {
            let metadata = MappingUtils.metadataFromResponse(response)
            let pageInfo = MappingUtils.pagingInfoFromResponse(response)
            let notificationMetadata = MappingUtils.notificationMetadataFromResponse(response)
            let dataMapper = MappingUtils.dataIncludeMapperFromResponse(response, metadata: metadata)
            let notifications = mappers.map({ Notification(mapper: $0, dataMapper: dataMapper) })

            let validNotifications = notifications.filter({ $0.isValid })
            let invalidNotifications = notifications.filter({ !$0.isValid })

            let responseData = ResponseData<Notification>(objects: validNotifications, rejectedObjects: invalidNotifications, pagingInfo: pageInfo, error: ErrorTransformer.errorFromResponse(response, error: error))

            executeOnMainQueue { self.completion?(responseData, notificationMetadata?.totalNewCount, notificationMetadata?.totalUnreadCount, notificationMetadata?.hasUnreadNotifications) }
        } else {
            let responseData = ResponseData<Notification>(objects: nil, rejectedObjects: nil, pagingInfo: nil, error:  ErrorTransformer.errorFromResponse(response, error: error))
            executeOnMainQueue { self.completion?(responseData, nil, nil, nil) }
        }
    }
}
