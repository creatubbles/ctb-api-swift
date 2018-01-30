//
//  NotificationMetadataMapper.swift
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

class NotificationMetadataMapper: Mappable {
    var totalNewCount: Int? // // It's a total number of new notifications that an user see for the first time. We may call a specific endpoint to mark all notifications as seen (NotificationsViewTrackerRequest class)
    var totalUnreadCount: Int? // It's a total number of notifications that are not marked as read (NotificationReadRequest class)
    var hasUnreadNotifications: Bool? // Indicates that there are some notifications not marked as read (NotificationReadRequest class)
    
    required init?(map: Map) { /* Intentionally left empty  */ }
    
    func mapping(map: Map) {
        totalNewCount <- map["total_new_count"]
        totalUnreadCount <- map["total_unread_count"]
        hasUnreadNotifications <- map["has_unread_notifications"]
    }
}
