//
//  JSONUtils.swift
//  CreatubblesAPIClient
//
//  Created by Michal Miedlarz on 09.03.2017.
//  Copyright © 2017 Nomtek. All rights reserved.
//

import UIKit

class JSONUtils: NSObject
{
    class func dictionaryFromJSONString(_ jsonString: String) -> Dictionary<String, AnyObject>
    {
        if let data = jsonString.data(using: String.Encoding.utf8)
        {
            do
            {
                let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as! [String:AnyObject]
                return json
            }
            catch
            {
                print("Cannot parse JSON: \(jsonString)")
            }
        }
        return Dictionary<String, AnyObject>()
    }
}
