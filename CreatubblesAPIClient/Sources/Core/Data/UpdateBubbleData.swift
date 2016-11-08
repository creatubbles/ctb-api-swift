//
//  UpdateBubbleData.swift
//  CreatubblesAPIClient
//
//  Created by Michal Miedlarz on 17.03.2016.
//  Copyright © 2016 Nomtek. All rights reserved.
//

import UIKit


@objc
open class UpdateBubbleData: NSObject
{
    open let identifier: String
    open let colorName: String?

    public init(bubbleId: String, colorName: String?)
    {
        self.identifier = bubbleId
        self.colorName = colorName
    }
}
