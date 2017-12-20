//
//  NewCreationUploadRequest.swift
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

import UIKit

@objc public enum UploadExtension: Int {
    case png
    case jpg
    case jpeg
    case h264
    case mpeg4
    case wmv
    case webm
    case flv
    case ogg
    case ogv
    case mp4
    case m4V
    case mov
    case uzpb
    case zip

    public var stringValue: String {
        switch self {
            case .png: return "png"
            case .jpg: return "jpg"
            case .jpeg: return "jpeg"
            case .h264: return "h264"
            case .mpeg4: return "mpeg4"
            case .wmv: return "wmv"
            case .webm: return "webm"
            case .flv: return "flv"
            case .ogg: return "ogg"
            case .ogv: return "ogv"
            case .mp4: return "mp4"
            case .m4V: return "m4v"
            case .mov: return "mov"
            case .uzpb: return "uzpb"
            case .zip: return "zip"
        }
    }

    public static func fromString(_ stringValue: String) -> UploadExtension? {
        if stringValue == "png" { return .png }
        if stringValue == "jpg" { return .jpg }
        if stringValue == "jpeg" { return .jpeg }
        if stringValue == "h264" { return .h264 }
        if stringValue == "mpeg4" { return .mpeg4 }
        if stringValue == "wmv" { return .wmv }
        if stringValue == "webm" { return .webm }
        if stringValue == "flv" { return .flv }
        if stringValue == "ogg" { return .ogg }
        if stringValue == "ogv" { return .ogv }
        if stringValue == "mp4" { return .mp4 }
        if stringValue == "m4v" { return .m4V }
        if stringValue == "mov" { return .mov }
        if stringValue == "uzpb" { return .uzpb }
        return nil
    }
}

class NewCreationUploadRequest: Request {
    override var method: RequestMethod { return .post }
    override var endpoint: String { return "creations/"+creationId+"/uploads" }
    override var parameters: Dictionary<String, AnyObject> {
        if let ext = creationExtension {
            return ["extension": ext.stringValue as AnyObject]
        }
        return Dictionary<String, AnyObject>()
    }

    fileprivate let creationId: String
    fileprivate let creationExtension: UploadExtension?

    init(creationId: String, creationExtension: UploadExtension? = nil) {
        self.creationId = creationId
        self.creationExtension = creationExtension
    }
}
