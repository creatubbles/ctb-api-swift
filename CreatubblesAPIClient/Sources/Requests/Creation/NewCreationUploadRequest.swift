//
//  NewCreationUploadRequest.swift
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

@objc public enum UploadExtension: Int
{
    case PNG
    case JPG
    case JPEG
    case H264
    case MPEG4
    case WMV
    case WEBM
    case FLV
    case OGG
    case OGV
    case MP4
    case M4V
    case MOV
    case UZPB
    
    var stringValue: String
    {
        switch self
        {
            case .PNG: return "png"
            case JPG: return "jpg"
            case JPEG: return "jpeg"
            case H264: return "h264"
            case MPEG4: return "mpeg4"
            case WMV: return "wmv"
            case WEBM: return "webm"
            case FLV: return "flv"
            case OGG: return "ogg"
            case OGV: return "ogv"
            case MP4: return "mp4"
            case M4V: return "m4v"
            case MOV: return "mov"
            case UZPB: return "uzpb"
        }
    }
    
    static func fromString(stringValue: String) -> UploadExtension?
    {
        if stringValue == "png"   { return .PNG }
        if stringValue == "jpg"   { return .JPG }
        if stringValue == "jpeg"  { return .JPEG }
        if stringValue == "h264"  { return .H264 }
        if stringValue == "mpeg4" { return .MPEG4 }
        if stringValue == "wmv"   { return .WMV }
        if stringValue == "webm"  { return .WEBM }
        if stringValue == "flv"   { return .FLV }
        if stringValue == "ogg"   { return .OGG }
        if stringValue == "ogv"   { return .OGV }
        if stringValue == "mp4"   { return .MP4 }
        if stringValue == "m4v"   { return .M4V }
        if stringValue == "mov"   { return .MOV }
        if stringValue == "uzpb"  { return .UZPB }
        return nil
    }
}

class NewCreationUploadRequest: Request
{
    override var method: RequestMethod  { return .POST }
    override var endpoint: String       { return "creations/"+creationId+"/uploads" }
    override var parameters: Dictionary<String, AnyObject>
    {
        if let ext = creationExtension
        {
            return ["extension": ext.stringValue]
        }
        return Dictionary<String, AnyObject>()
    }
    
    private let creationId: String
    private let creationExtension: UploadExtension?
    
    init(creationId: String, creationExtension: UploadExtension? = nil)
    {
        self.creationId = creationId
        self.creationExtension = creationExtension
    }
}
