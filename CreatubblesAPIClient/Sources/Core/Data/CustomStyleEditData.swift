//
//  CustomStyleEditData.swift
//  CreatubblesAPIClient
//
//  Created by Michal Miedlarz on 04.06.2016.
//  Copyright © 2016 Nomtek. All rights reserved.
//

import UIKit

open class CustomStyleEditData: NSObject
{
    open var headerBackgroundIndex: Int?
    open var bodyBackgroundIndex: Int?
    open var fontName: String?
    open var bio: String?
    open var bodyColors: Array<UIColor>?
    open var headerColors: Array<UIColor>?
    open var headerCreationIdentifier: String?
    open var bodyCreationIdentifier: String?    
    
    //Computed properties
    var headerBackgroundIdentifier: String?
    {
        return headerBackgroundIndex == nil ? nil : "pattern\(String(headerBackgroundIndex!))"
    }
    
    var bodyBackgroundIdentifier: String?
    {
        return bodyBackgroundIndex == nil ? nil : "pattern\(String(bodyBackgroundIndex!))"
    }
}
