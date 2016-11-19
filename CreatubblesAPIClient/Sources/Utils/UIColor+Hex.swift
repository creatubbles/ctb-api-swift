//
//  UIColor+Hex.swift
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
