//
//  NotificationDAO.swift
//  CreatubblesAPIClient
//
//  Created by Michal Miedlarz on 07.06.2016.
//  Copyright © 2016 Nomtek. All rights reserved.
//

import UIKit

class NotificationDAO: NSObject
{
    fileprivate let requestSender: RequestSender
    
    init(requestSender: RequestSender)
    {
        self.requestSender = requestSender
    }
 
    func getNotifications(pagingData: PagingData?, completion: NotificationsClosure?) -> RequestHandler
    {
        let request = NotificationsFetchRequest(page: pagingData?.page, perPage: pagingData?.pageSize)
        let handler = NotificationsFetchResponseHandler(completion: completion)
        return requestSender.send(request, withResponseHandler: handler)
    }
    
    func markNotificationAsRead(notificationIdentifier identifier: String, completion: ErrorClosure?) -> RequestHandler
    {
        let request = NotificationReadRequest(notificationIdentifier: identifier)
        let handler = NotificationReadResponseHandler(completion: completion)
        return requestSender.send(request, withResponseHandler: handler)
    }
    
    func trackWhenNotificationsWereViewed(completion: ErrorClosure?) -> RequestHandler
    {
        let request = NotificationsViewTrackerRequest()
        let handler = NotificationsViewTrackerResponseHandler(completion: completion)
        return requestSender.send(request, withResponseHandler: handler)
    }

}
