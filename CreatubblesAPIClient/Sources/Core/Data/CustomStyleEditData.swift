//
//  CustomStyleEditData.swift
//  CreatubblesAPIClient
//
//  Created by Michal Miedlarz on 04.06.2016.
//  Copyright © 2016 Nomtek. All rights reserved.
//

import UIKit

public class CustomStyleEditData: NSObject
{
    public var headerBackgroundIndex: Int?
    public var bodyBackgroundIndex: Int?
    
    public var headerBackgroundIdentifier: String?
    {
        return headerBackgroundIndex == nil ? nil : "pattern\(String(headerBackgroundIndex!))"
    }
    
    public var bodyBackgroundIdentifier: String?
    {
        return bodyBackgroundIndex == nil ? nil : "pattern\(String(bodyBackgroundIndex!))"
    }
    public var fontName: String?
    public var bio: String?
    public var bodyColors: Array<UIColor>?
    public var headerColors: Array<UIColor>?        
}
