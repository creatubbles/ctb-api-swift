//
//  PagingData.swift
//  CreatubblesAPIClient
//
//  Created by Michal Miedlarz on 23.02.2016.
//  Copyright © 2016 Nomtek. All rights reserved.
//

import UIKit

@objc
public class PagingData: NSObject
{
    public let page: Int
    public let pageSize: Int
    
    public init(page: Int, pageSize: Int)
    {
        self.page = page
        self.pageSize = pageSize
    }    
}