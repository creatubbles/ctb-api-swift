//
//  TestResponses.swift
//  CreatubblesAPIClient
//
//  Created by Michal Miedlarz on 11.02.2016.
//  Copyright © 2016 Nomtek. All rights reserved.
//

import UIKit

class TestResponses: NSObject
{
    class var profileTestResponse: Dictionary<String, AnyObject>{ return dictionaryFromJSONString(profileResponseString) }
    class var creatorsAndManagersTestResponse: Dictionary<String, AnyObject> { return dictionaryFromJSONString(creatorsAndManagersResponseString) }
    class var newCreatorTestResponse: Dictionary<String, AnyObject> { return dictionaryFromJSONString(newCreatorResponseString) }
    
    
    private class func dictionaryFromJSONString(jsonString: String) -> Dictionary<String, AnyObject>
    {
        if let data = jsonString.dataUsingEncoding(NSUTF8StringEncoding)
        {
            do
            {
                let json = try NSJSONSerialization.JSONObjectWithData(data, options: .MutableContainers) as! [String:AnyObject]
                return json
            }
            catch
            {
                print("Cannot parse json")
            }
        }
        return Dictionary<String, AnyObject>()
    }
    
    private static let profileResponseString = "{\"data\":{\"id\":\"B0SwCGhR\",\"type\":\"users\",\"attributes\":{\"username\":\"mmiedlarz\",\"display_name\":\"mmiedlarz\",\"name\":\"mmiedlarz\",\"role\":\"parent\",\"created_at\":\"2016-02-09T07:38:11.765Z\",\"updated_at\":\"2016-02-10T10:06:01.518Z\",\"avatar_url\":\"https://d2r48com4t2oyq.cloudfront.net/assets/default_avatars/parent-b6fce598b36e38e81a3baf1aae1d064b.jpg\",\"bubbled_by_user_ids\":[],\"birth_month\":null,\"birth_year\":1990,\"age\":\"26y\",\"is_male\":true,\"groups\":[{\"id\":787,\"name\":\"Nomtek<3\",\"taggings_count\":1},{\"id\":786,\"name\":\"WrocLove\",\"taggings_count\":1},{\"id\":785,\"name\":\"NomtekDevs\",\"taggings_count\":1}],\"last_bubbled_at\":null,\"last_commented_at\":null,\"added_bubbles_count\":0,\"activities_count\":359,\"bubbles_count\":0,\"comments_count\":0,\"creations_count\":0,\"creators_count\":4,\"galleries_count\":1,\"managers_count\":1,\"short_url\":\"https://staging.ctbl.es/mmiedlarz\",\"gsp_seen\":false,\"uep_unwanted\":false,\"loggable\":true,\"owned_tags\":[\"WrocLove\",\"NomtekDevs\",\"Nomtek<3\"],\"country_code\":\"PL\",\"country_name\":\"Poland\",\"is_partner\":false,\"signed_up_as_instructor\":false,\"home_schooling\":false},\"relationships\":{\"school\":{\"data\":null},\"custom_style\":{\"data\":null}}},\"meta\":{\"abilities\":[{\"id\":\"user:B0SwCGhR:customize\",\"type\":\"abilities\",\"relationships\":{},\"attributes\":{\"resource_type\":\"user\",\"resource_id\":\"B0SwCGhR\",\"permission\":true,\"operation\":\"customize\"}}]}}"
    
    private static let creatorsAndManagersResponseString = "{\"data\":[{\"id\":\"fHl1sMZP\",\"type\":\"users\",\"attributes\":{\"username\":\"MMCreator400\",\"display_name\":\"MMCreator400\",\"name\":\"MMCreator400\",\"role\":\"creator\",\"created_at\":\"2016-02-10T10:00:09.203Z\",\"updated_at\":\"2016-02-10T10:00:09.398Z\",\"avatar_url\":\"https://d2r48com4t2oyq.cloudfront.net/assets/default_avatars/1-1942098a39e00bca092d86a03203246c.jpg\",\"bubbled_by_user_ids\":[],\"birth_month\":10,\"birth_year\":2000,\"age\":\"15y 4m\",\"is_male\":false,\"groups\":[],\"last_bubbled_at\":null,\"last_commented_at\":null,\"added_bubbles_count\":0,\"activities_count\":0,\"bubbles_count\":0,\"comments_count\":0,\"creations_count\":0,\"creators_count\":1,\"galleries_count\":0,\"managers_count\":1,\"short_url\":\"https://staging.ctbl.es/MMCreator400\",\"gsp_seen\":false,\"uep_unwanted\":false,\"loggable\":false,\"owned_tags\":[],\"country_code\":\"PL\",\"country_name\":\"Poland\",\"is_partner\":false,\"signed_up_as_instructor\":false,\"home_schooling\":false},\"relationships\":{\"school\":{\"data\":null},\"custom_style\":{\"data\":null}}}],\"meta\":{\"total_pages\":1,\"total_count\":1,\"abilities\":[{\"id\":\"user:fHl1sMZP:edit\",\"type\":\"abilities\",\"relationships\":{},\"attributes\":{\"resource_type\":\"user\",\"resource_id\":\"fHl1sMZP\",\"permission\":true,\"operation\":\"edit\"}},{\"id\":\"user:fHl1sMZP:switch\",\"type\":\"abilities\",\"relationships\":{},\"attributes\":{\"resource_type\":\"user\",\"resource_id\":\"fHl1sMZP\",\"permission\":true,\"operation\":\"switch\"}},{\"id\":\"user:fHl1sMZP:switch\",\"type\":\"abilities\",\"relationships\":{},\"attributes\":{\"resource_type\":\"user\",\"resource_id\":\"fHl1sMZP\",\"permission\":true,\"operation\":\"switch_without_password\"}}],\"bubbled_ids\":[]}}"
    
    private static let newCreatorResponseString = "{\"data\":{\"id\":\"Fb6J28ej\",\"type\":\"users\",\"attributes\":{\"username\":\"MMCreator751\",\"display_name\":\"MMCreator751\",\"name\":\"MMCreator751\",\"role\":\"creator\",\"created_at\":\"2016-02-10T10:06:00.654Z\",\"updated_at\":\"2016-02-10T10:06:00.771Z\",\"avatar_url\":\"https://d2r48com4t2oyq.cloudfront.net/assets/default_avatars/1-1942098a39e00bca092d86a03203246c.jpg\",\"bubbled_by_user_ids\":[],\"birth_month\":10,\"birth_year\":2000,\"age\":\"15y 4m\",\"is_male\":false,\"groups\":[],\"last_bubbled_at\":null,\"last_commented_at\":null,\"added_bubbles_count\":0,\"activities_count\":0,\"bubbles_count\":0,\"comments_count\":0,\"creations_count\":0,\"creators_count\":1,\"galleries_count\":0,\"managers_count\":1,\"short_url\":\"https://staging.ctbl.es/MMCreator751\",\"gsp_seen\":false,\"uep_unwanted\":false,\"loggable\":false,\"owned_tags\":[],\"country_code\":\"PL\",\"country_name\":\"Poland\",\"is_partner\":false,\"signed_up_as_instructor\":false,\"home_schooling\":false},\"relationships\":{\"school\":{\"data\":null},\"custom_style\":{\"data\":null}}}}"
}
