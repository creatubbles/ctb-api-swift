//
//  ContentDataFilter.swift
//  CreatubblesAPIClient
//
//  Created by Dawid Płatek on 23.08.2016.
//  Copyright © 2016 Nomtek. All rights reserved.
//

import UIKit

protocol Validable {
    func isValid(object: AnyObject) -> Bool
}

class ContentDataFilter: NSObject, Validable {
    
    func isValid(object: AnyObject) -> Bool {
        guard let contentEntry = object as? ContentEntry else { return false }
        
        if contentEntry.type == .None {
            return false
        }
        
        return contentEntry.user != nil || contentEntry.gallery != nil || contentEntry.creation != nil
    }
}