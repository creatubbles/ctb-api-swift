//
//  UIColor+Hex.swift
//  CreatubblesAPIClient
//
//  Created by Michal Miedlarz on 04.06.2016.
//  Copyright © 2016 Nomtek. All rights reserved.
//

import Foundation

extension String
{
    func isHexColorString() -> Bool
    {
        return self.hasPrefix("#")
    }
    
    func isRGBColorString() -> Bool
    {
        return  self.lowercased().hasPrefix("rgb")
    }
    
    func isRGBAColorString() -> Bool
    {
        return  self.lowercased().hasPrefix("rgba")
    }
    
    //rgb(XX,XX,XX) or rgba(X,X,X,X) to #XXXXXX or #XXXXXXXX
    func RGBtoHexString() -> String?
    {
        guard self.isRGBColorString()
        else { return nil }
                
        let valueString = trimmingCharacters(in: CharacterSet(charactersIn: "rgbaRGBA() "))
                         .replacingOccurrences(of: " ", with: "")
        var values: Array<Float> = valueString.components(separatedBy: ",").map({ Float($0)! })
        if values.count == 4 //RGBA
        {
            values[3] = values[3] * 255
        }
        
        var finalString = "#"
        values.forEach({ finalString = finalString + String(format: "%02X", Int($0)) })
        
        return finalString
    }
}

extension UIColor
{
    func hexValue(_ includeAlpha: Bool = false) -> String
    {
        var r: CGFloat = 0
        var g: CGFloat = 0
        var b: CGFloat = 0
        var a: CGFloat = 0
        self.getRed(&r, green: &g, blue: &b, alpha: &a)
        
        if (includeAlpha) {
            return String(format: "#%02X%02X%02X%02X", Int(r * 255), Int(g * 255), Int(b * 255), Int(a * 255))
        } else {
            return String(format: "#%02X%02X%02X", Int(r * 255), Int(g * 255), Int(b * 255))
        }
    }}
