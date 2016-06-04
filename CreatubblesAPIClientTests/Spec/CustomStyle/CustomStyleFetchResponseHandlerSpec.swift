
//
//  CustomStyleFetchResponseHandlerSpec.swift
//  CreatubblesAPIClient
//
//  Created by Michal Miedlarz on 03.06.2016.
//  Copyright © 2016 Nomtek. All rights reserved.
//

import UIKit

import Quick
import Nimble
@testable import CreatubblesAPIClient


class CustomStyleFetchResponseHandlerSpec: QuickSpec
{
    override func spec()
    {
        describe("CustomStyleResponseHandler")
        {
            it("Should return custom style for user without login")
            {
                guard let identifier = TestConfiguration.testUserIdentifier
                else { return }
                
                //For now API returns error 500 for some users, valid identifier: a60rC05Y
                let request = CustomStyleFetchRequest(userIdentifier: "uqJ5TLYf")
                let sender = RequestSender(settings: TestConfiguration.settings)
                
                waitUntil(timeout: 10)
                {
                    done in
                    //Have to wait for sender to login with Public Grant
                    let time = dispatch_time(DISPATCH_TIME_NOW, Int64(5 * Double(NSEC_PER_SEC)))
                    dispatch_after(time, dispatch_get_main_queue(),
                   {
                        sender.send(request, withResponseHandler: CustomStyleFetchResponseHandler()
                        {
                            (style: CustomStyle?, error: APIClientError?) -> Void in
                            expect(style).notTo(beNil())
                            expect(error).to(beNil())
                            done()
                        })
                    })
                }
            }            
        }
    }
}