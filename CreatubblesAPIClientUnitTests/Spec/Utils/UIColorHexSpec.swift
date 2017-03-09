//
//  UIColorHexSpec.swift
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
//


import Quick
import Nimble
@testable import CreatubblesAPIClient

class UIColorHexSpec: QuickSpec
{
    override func spec()
    {
        describe("Hex extension of UIColor")
        {
            it("Should return proper color in Hex")
            {
                let redColor = UIColor(red: 1, green: 0, blue: 0, alpha: 1)
                expect(redColor.hexValue()).to(equal("#FF0000"))
                
                let greenColor = UIColor(red: 0, green: 1, blue: 0, alpha: 1)
                expect(greenColor.hexValue()).to(equal("#00FF00"))
                
                let blueColor = UIColor(red: 0, green: 0, blue: 1, alpha: 1)
                expect(blueColor.hexValue()).to(equal("#0000FF"))
                
                let pinkColor = UIColor(red:0.76, green:0.17, blue:0.65, alpha:1.0)
                expect(pinkColor.hexValue()).to(equal("#C12BA5"))
            }
        }
        
        describe("Hex extension of String")
        {
            it("Should recognize RGB string")
            {
                let rgbString = "rgb(1,2,3)"
                expect(rgbString.isRGBColorString()).to(beTrue())
                expect(rgbString.isRGBAColorString()).to(beFalse())
            }
            
            it("Should recognize RGBA string")
            {
                let rgbString = "rgba(1,2,3,4)"
                expect(rgbString.isRGBColorString()).to(beTrue())
                expect(rgbString.isRGBAColorString()).to(beTrue())
            }
            
            it("Should convert RGB to Hex")
            {
                expect("rgb(255,255,255)".RGBtoHexString()).to(equal("#FFFFFF"))
                expect("rgb(128, 0 ,128)".RGBtoHexString()).to(equal("#800080"))
            }
            
            it("Should convert RGBA to Hex")
            {            
                expect("rgba(121, 115 , 88,1)".RGBtoHexString()).to(equal("#797358FF"))
                expect("rgba(121,115,88,0.5)".RGBtoHexString()).to(equal("#7973587F"))
            }
            
            it("Should return nil, when cannot convert RGB to Hex")
            {
                expect("RandomString".RGBtoHexString()).to(beNil())
            }            
        }
    }
}
