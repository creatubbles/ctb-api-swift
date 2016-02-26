//
//  PagingInfo.swift
//  CreatubblesAPIClient
//
//  Created by Michal Miedlarz on 26.02.2016.
//  Copyright © 2016 Nomtek. All rights reserved.
//

import UIKit

@objc
public class PagingInfo: NSObject
{
    public let totalPages: Int
    public let totalCount: Int
    
    init(totalPages: Int, totalCount: Int)
    {
        self.totalPages = totalPages
        self.totalCount = totalCount
    }
    
    init(builder: PagingInfoModelBuilder)
    {
        self.totalCount = builder.totalCount!
        self.totalPages = builder.totalPages!
    }
}
