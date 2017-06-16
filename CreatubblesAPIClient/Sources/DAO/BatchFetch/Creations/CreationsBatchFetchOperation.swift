//
//  CreationsBatchFetchOperation.swift
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

class CreationsBatchFetchOperation: ConcurrentOperation {
    private let requestSender: RequestSender

    private let userId: String?
    private let galleryId: String?
    private let keyword: String?
    private let partnerApplicationId: String?
    private let sort: SortOrder?
    private let onlyPublic: Bool

    let pagingData: PagingData
    private(set) var creations: Array<Creation>?
    private var requestHandler: RequestHandler?

    init(requestSender: RequestSender, userId: String?, galleryId: String?, keyword: String?, partnerApplicationId: String?, sort: SortOrder?, onlyPublic: Bool, pagingData: PagingData, complete: OperationCompleteClosure?) {
        self.requestSender = requestSender
        self.userId = userId
        self.galleryId = galleryId
        self.keyword = keyword
        self.partnerApplicationId = partnerApplicationId
        self.sort = sort
        self.onlyPublic = onlyPublic
        self.pagingData = pagingData

        super.init(complete: complete)
    }

    override func main() {
        guard isCancelled == false else { return }

        let request = FetchCreationsRequest(page: pagingData.page, perPage: pagingData.pageSize, galleryId: galleryId, userId: userId, sort: sort, keyword: keyword, partnerApplicationId: partnerApplicationId, onlyPublic: onlyPublic)
        let handler = FetchCreationsResponseHandler {
            [weak self](creations, _, error) -> (Void) in
            self?.creations = creations
            self?.finish(error)
        }
        requestHandler = requestSender.send(request, withResponseHandler: handler)
    }

    override func cancel() {
        requestHandler?.cancel()
        super.cancel()
    }
}
