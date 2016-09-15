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

public enum UploadExtension: String
{
    case PNG = "png"
    case JPG = "jpg"
    case JPEG = "jpeg"
    case H264 = "h64"
    case MPEG4 = "mpeg4"
    case WMV = "wmv"
    case WEBM = "webm"
    case FLV = "flv"
    case OGG = "ogg"
    case OGV = "ogv"
    case MP4 = "mp4"
    case M4V = "m4v"
    case MOV = "mov"
    case UZPB = "uzpb"
}

class NewCreationUploadRequest: Request
{
    override var method: RequestMethod  { return .POST }
    override var endpoint: String       { return "creations/"+creationId+"/uploads" }
    override var parameters: Dictionary<String, AnyObject>
    {
        if let ext = creationExtension
        {
            return ["extension": ext.rawValue]
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
