
//
//  APIClientError.swift
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
import ObjectMapper


public class APIClientError: ErrorType
{
    public static let DefaultDomain: String = "com.creatubbles.errordomain"
    public static let DefaultStatus: Int = -6000
    public static let DefaultCode: String = ""
    public static let DefaultTitle: String = ""
    public static let DefaultSource: String = ""
    public static let DefaultDetail: String = ""
    
    public let status: Int
    public let code: String
    public let title: String
    public let source: String
    public let detail: String
    public let domain: String
    
    init(status: Int, code: String, title: String, source: String, detail: String, domain: String = APIClientError.DefaultDomain)
    {
        self.status = status
        self.code = code
        self.title = title
        self.source = source
        self.detail = detail
        self.domain = domain
    }
    
    init(mapper: ErrorMapper)
    {
        self.status = mapper.status ?? APIClientError.DefaultStatus
        self.code   = mapper.code   ?? APIClientError.DefaultCode
        self.title  = mapper.title  ?? APIClientError.DefaultTitle
        self.source = mapper.source ?? APIClientError.DefaultSource
        self.detail = mapper.detail ?? APIClientError.DefaultDetail
        self.domain = APIClientError.DefaultDomain
    }
}

class ErrorTransformer
{
    class func errorFromResponse(response: Dictionary<String, AnyObject>?, error: ErrorType?) -> APIClientError?
    {
        if let err = error as? APIClientError
        {
            return err
        }
        if let err = errorsFromResponse(response).first
        {
            return err
        }
        return errorFromErrorType(error)
    }
    
    private class func errorsFromResponse(response: Dictionary<String, AnyObject>?) -> Array<APIClientError>
    {
        guard let response = response,
              let mappers = Mapper<ErrorMapper>().mapArray(response["errors"])
        else  { return Array<APIClientError>() }
        return mappers.map({ APIClientError(mapper: $0) })
    }
    
    private class func errorFromErrorType(error: ErrorType?) -> APIClientError?
    {
        guard let err = error as? NSError
        else { return nil }        
        return APIClientError(status: err.code,
                              code: APIClientError.DefaultCode,
                              title: err.localizedDescription,
                              source: APIClientError.DefaultSource,
                              detail: err.localizedFailureReason ?? APIClientError.DefaultDomain,
                              domain: err.domain)
    
    }
}