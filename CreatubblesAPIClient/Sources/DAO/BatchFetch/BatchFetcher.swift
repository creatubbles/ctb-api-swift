//
//  BatchFetcher.swift
//  CreatubblesAPIClient
//
//  Created by Michal Miedlarz on 26.02.2016.
//  Copyright © 2016 Nomtek. All rights reserved.
//

import UIKit

class BatchFetcher: NSObject
{
    let maxPageCount = 20
    let perPage = 20
    var page = 1
    
    let requestSender: RequestSender
    init(requestSender: RequestSender)
    {
        self.requestSender = requestSender
    }
}
