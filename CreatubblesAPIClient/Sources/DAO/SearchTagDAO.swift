//
//  CreatubblesAPIClient.swift
//  CreatubblesAPIClient
//
//  Copyright (c) 2016 Creatubbles Pte. Ltd.
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.

import UIKit

class SearchTagDAO: NSObject
{
    fileprivate let requestSender: RequestSender
    
    init(requestSender: RequestSender)
    {
        self.requestSender = requestSender
    }
    
    func fetchSearchTags(completion: SearchTagsClosure?) -> RequestHandler
    {
        //Mock method - until it's ready on API's side, this method will return some premade mock SearchTags.
        let request = SearchTagsFetchRequest()
        
        let objects = [SearchTag(name: "Lego", imageURL: "https://d1x1kv7c0y4dpg.cloudfront.net/assets/images/suggested-searches/lego-b8ad79890b22bee5d8c55dc4ac17a446.jpg"),
                       SearchTag(name: "Minecraft", imageURL: "https://d1x1kv7c0y4dpg.cloudfront.net/assets/images/suggested-searches/minecraft-857ee3b90a20e1c5ac16bcd399824673.jpg"),
                       SearchTag(name: "Characters", imageURL: "https://d1x1kv7c0y4dpg.cloudfront.net/assets/images/suggested-searches/characters-b7ab1dcd40b0682823ba0885e56532f9.jpg"),
                       SearchTag(name: "Rainbow Loom", imageURL: "https://d1x1kv7c0y4dpg.cloudfront.net/assets/images/suggested-searches/rainbow_loom-3b41da1a4863086ccb5ed6a7da2242c3.jpg"),
                       SearchTag(name: "Scratch", imageURL: "https://d1x1kv7c0y4dpg.cloudfront.net/assets/images/suggested-searches/scratch-f07bb305df1932ef81ccc1fe5617b04e.jpg"),
                       SearchTag(name: "Strawbees", imageURL: "https://d1x1kv7c0y4dpg.cloudfront.net/assets/images/suggested-searches/strawbees-f1ea6ed75d6185519cea654da9667c90.jpg")]
        completion?(objects, nil)
        
        return RequestHandler(object: request as Cancelable)
    }
}
