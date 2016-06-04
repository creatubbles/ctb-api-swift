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
    }
}
