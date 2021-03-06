//
//  CustomStyleEditRequestSpec.swift
//  CreatubblesAPIClient
//
//  Copyright (c) 2017 Creatubbles Pte. Ltd.
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
//

import Quick
import Nimble
@testable import CreatubblesAPIClient

class CustomStyleEditRequestSpec: QuickSpec {
    override func spec() {
        describe("CustomStyleEditRequest") {
            it("Should use PUT method") {
                let request = CustomStyleEditRequest(userIdentifier: "", data: CustomStyleEditData())
                expect(request.method) == RequestMethod.put
            }

            it("Should have users/USER_IDENTIFIER/custom_style endpoint") {
                let identifier = "TestIdentifier"
                let request = CustomStyleEditRequest(userIdentifier: identifier, data: CustomStyleEditData())
                expect(request.endpoint) == "users/\(identifier)/custom_style"
            }

            it("Should allow to pass CustomStyleData") {
                let data = CustomStyleEditData()
                _ = CustomStyleEditRequest(userIdentifier: "", data: data)
            }

            it("Should generate parameters properly") {
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

                guard let dataDict = request.parameters["data"] as? Dictionary<String, AnyObject>
                else {
                    fail("Data dictionary was not properly build")
                    return
                }

                guard let attributesDict = dataDict["attributes"] as? Dictionary<String, AnyObject>
                else {
                    fail("Parameters dictionary was not properly build")
                    return
                }

                guard (dataDict["relationships"] as? Dictionary<String, AnyObject>) != nil
                else {
                    fail("Relationships dictionary was not properly build")
                    return
                }

                expect(attributesDict["header_background_id"] as? String) == "pattern1"
                expect(attributesDict["body_background_id"] as? String) == "pattern2"
                expect(attributesDict["font"] as? String) == testFontName
                expect(attributesDict["bio"] as? String) == testBio
                expect(attributesDict["body_colors"] as? Array<String>) == testBodyColors.map({ $0.hexValue() })
                expect(attributesDict["header_colors"] as? Array<String>) == testHeaderColors.map({ $0.hexValue() })
            }
        }
    }
}
