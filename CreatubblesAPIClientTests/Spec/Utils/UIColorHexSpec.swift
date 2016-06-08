//
//  UIColorHexSpec.swift
//  CreatubblesAPIClient
//
//  Created by Michal Miedlarz on 04.06.2016.
//  Copyright © 2016 Nomtek. All rights reserved.
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
                expect("rgb(128,0,128)".RGBtoHexString()).to(equal("#800080"))
            }
            
            it("Should convert RGBA to Hex")
            {            
                expect("rgba(121,115,88,1)".RGBtoHexString()).to(equal("#797358FF"))
                expect("rgba(121,115,88,0.5)".RGBtoHexString()).to(equal("#7973587F"))
            }
            
            it("Should return nil, when cannot convert RGB to Hex")
            {
                expect("RandomString".RGBtoHexString()).to(beNil())
            }            
        }
    }
}
