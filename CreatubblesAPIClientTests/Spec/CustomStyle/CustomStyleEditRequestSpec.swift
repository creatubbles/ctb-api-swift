//
//  CustomStyleEditRequestSpec.swift
//  CreatubblesAPIClient
//
//  Created by Michal Miedlarz on 04.06.2016.
//  Copyright © 2016 Nomtek. All rights reserved.
//

import Quick
import Nimble
@testable import CreatubblesAPIClient

class CustomStyleEditRequestSpec: QuickSpec
{
    override func spec()
    {
        describe("CustomStyleEditRequest")
        {
            it("Should use PUT method")
            {
                let request = CustomStyleEditRequest(userIdentifier: "", data: CustomStyleEditData())
                expect(request.method).to(equal(RequestMethod.put))
            }
            
            it("Should have users/USER_IDENTIFIER/custom_style endpoint")
            {
                let identifier = "TestIdentifier"
                let request = CustomStyleEditRequest(userIdentifier: identifier, data: CustomStyleEditData())
                expect(request.endpoint).to(equal("users/\(identifier)/custom_style"))
            }
            
            it("Should allow to pass CustomStyleData")
            {
                let data = CustomStyleEditData()
                _ = CustomStyleEditRequest(userIdentifier: "", data: data)
            }
            
            it("Should generate parameters properly")
            {
                let testBio = "TestBio"
                let testFontName = "TestFontName"
                let testBodyColors = [UIColor.white, UIColor.red, UIColor.brown]
                let testHeaderColors = [UIColor.white, UIColor.red, UIColor.brown]
                
                let data = CustomStyleEditData()
                data.headerBackgroundIndex = 1
                data.bodyBackgroundIndex = 2
                data.bio = testBio
                data.fontName = testFontName
                data.bodyColors = testBodyColors
                data.headerColors = testHeaderColors
                
                let request = CustomStyleEditRequest(userIdentifier: "", data: data)
                
                expect(request.parameters["header_background_id"] as? String).to(equal("pattern1"))
                expect(request.parameters["body_background_id"] as? String).to(equal("pattern2"))
                expect(request.parameters["font"] as? String).to(equal(testFontName))
                expect(request.parameters["bio"] as? String).to(equal(testBio))
                expect(request.parameters["body_colors"] as? Array<String>).to(equal(testBodyColors.map({ $0.hexValue() })))
                expect(request.parameters["header_colors"] as? Array<String>).to(equal(testHeaderColors.map({ $0.hexValue() })))
            }
        }
    }
}
