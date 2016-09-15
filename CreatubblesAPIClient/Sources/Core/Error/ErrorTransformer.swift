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
//

import Foundation
import ObjectMapper
import p2_OAuth2

class ErrorTransformer
{
    static func errorFromResponse(response: Dictionary<String, AnyObject>?, error: ErrorType?) -> APIClientError?
    {
        if let err = error as? APIClientError
        {
            return err
        }
        if let err = errorsFromResponse(response).first
        {
            return err
        }
        if let err = error as? NSError
        {
            return errorFromNSError(err)
        }
        return nil
    }
    
    static func errorsFromResponse(response: Dictionary<String, AnyObject>?) -> Array<APIClientError>
    {
        guard let response = response,
              let mappers = Mapper<ErrorMapper>().mapArray(response["errors"])
        else  { return Array<APIClientError>() }
        return mappers.map({ APIClientError(mapper: $0) })
    }
    
    static func errorFromNSError(error: NSError) -> APIClientError
    {        
        return APIClientError(status: error.code,
                              code: APIClientError.DefaultCode,
                              title: error.localizedDescription,
                              source: APIClientError.DefaultSource,
                              detail: error.localizedFailureReason ?? APIClientError.DefaultDomain,
                              domain: error.domain)
    }
    
    static func errorFromOAuthError(oauthError: OAuth2Error) -> APIClientError
    {
        return APIClientError(status: APIClientError.LoginStatus,
                              code: "authentication-error",
                              title: oauthError.description,
                              source: APIClientError.DefaultSource,
                              detail: APIClientError.DefaultDetail)
    }
}
