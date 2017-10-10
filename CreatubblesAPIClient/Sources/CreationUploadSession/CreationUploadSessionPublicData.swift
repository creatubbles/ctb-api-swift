//
//  CreationUploadSessionPublicData.swift
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

import UIKit

@objc
open class CreationUploadSessionPublicData: NSObject {
    public enum Status: Equatable {
        case inProgress
        // completed successfully
        case completed
        // cancelled by user
        case cancelled
        // failed due to error
        case failed
    }

    open let identifier: String
    open let creationData: NewCreationData
    open let creation: Creation?
    open let error: Error?
    open let status: Status

    init(creationUploadSession: CreationUploadSession) {
        identifier = creationUploadSession.localIdentifier
        creation = creationUploadSession.creation
        creationData = creationUploadSession.creationData
        error = creationUploadSession.error

        if creationUploadSession.isFailed {
            status = .failed
        } else if creationUploadSession.isAlreadyFinished {
            status = .completed
        } else if creationUploadSession.isCancelled {
            status = .cancelled
        } else {
            status = .inProgress
        }
    }

    open func includesSubmittingToGallery(withIdentifier galleryIdentifier: String) -> Bool {
        return creationData.galleryIds?.contains(galleryIdentifier) ?? false
    }
}
