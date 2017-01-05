//
//  CreatubblesAPIClient.swift
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

open class AppScreenshot: NSObject, Identifiable {
    open let identifier: String
    open let imageURL: String?
    open let isVideo: Bool
    open let videoIdentifier: String?
    open let title: String?
    open let provider: AppScreenshotProvider
    open let thumbnailURL: String?
    open let position: Int
    
    init(mapper: AppScreenshotMapper)
    {
        self.identifier = mapper.identifier!
        self.imageURL = mapper.imageURL!
        self.isVideo = mapper.isVideo!
        self.videoIdentifier = mapper.videoIdentifier!
        self.title = mapper.title!
        self.provider = mapper.parseProvider()
        self.thumbnailURL = mapper.thumbnailURL!
        self.position = mapper.position!
    }
}
