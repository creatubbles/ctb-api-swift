//
//  TestResults.swift
//  CreatubblesAPIClient
//
//  Created by Nomtek on 24.11.2016.
//  Copyright © 2016 Nomtek. All rights reserved.
//

import UIKit

class TestResults: NSObject
{
    var getActivitiesResponse: Dictionary<String, AnyObject>?
    
    var updateAvatarWithoutLoginResponse: Dictionary<String, AnyObject>?
    var updateAvatarWithLoginresponse: Dictionary<String, AnyObject>?
    var getAvatarSuggestionsWithoutLoginResponse: Dictionary<String, AnyObject>?
    var getAvatarSuggestionsWithLoginResponse: Dictionary<String, AnyObject>?
    
    var newBubbleWithoutLoginResponse: Dictionary<String, AnyObject>?
    var newbubbleWithLoginResponse: Dictionary<String, AnyObject>?
    var updateBubbleWithoutLoginresponse: Dictionary<String, AnyObject>?
    var updateBubbleWithLoginResponse: Dictionary<String, AnyObject>?
    var getBubblesWithLoginResponse: Dictionary<String, AnyObject>?
    
    var getCommentsForCreationWithLoginResponse: Dictionary<String, AnyObject>?
    var getCommentsForGalleryWithLoginResponse: Dictionary<String, AnyObject>?
    var getCommentsForProfileWithLoginResponse: Dictionary<String, AnyObject>?
    
    override init()
    {
        super.init()
        
        if let directoryPath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first
        {
            do
            {
                self.getActivitiesResponse = try dictionaryFromJSONString(String(contentsOf: directoryPath.appendingPathComponent("test.txt")))
            }
            catch { }
        }
        
    }
    
    fileprivate func dictionaryFromJSONString(_ jsonString: String) -> Dictionary<String, AnyObject>
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
                print("Cannot parse json")
            }
        }
        return Dictionary<String, AnyObject>()
    }
}
