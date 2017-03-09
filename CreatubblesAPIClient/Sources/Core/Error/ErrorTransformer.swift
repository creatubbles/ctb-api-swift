//
//  APIClientError.swift
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

import Foundation
import ObjectMapper

public class ErrorTransformer
{
    public static func errorFromResponse(_ response: Dictionary<String, AnyObject>?, error: Error?) -> APIClientError?
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
    
    static func errorsFromResponse(_ response: Dictionary<String, AnyObject>?) -> Array<APIClientError>
    {
        guard let response = response,
              let mappers = Mapper<ErrorMapper>().mapArray(JSONObject: response["errors"])
        else
        {
            return Array<APIClientError>()
        }
        var errorsArray = Array<APIClientError>()
        for mapper in mappers
        {
            if mapper.status != nil || mapper.statusAsString != nil || mapper.code != nil || mapper.title != nil || mapper.source != nil || mapper.detail != nil
            {
                errorsArray.append(APIClientError(status: mapper.status ?? (mapper.statusAsString != nil ? Int(mapper.statusAsString!) : nil), code: mapper.code, title: mapper.title, source: mapper.source, detail: mapper.detail))
            }
        }
        return errorsArray

//        return mappers.map({ APIClientError(mapper: $0) })
    }
    
    static func errorFromNSError(_ error: NSError) -> APIClientError
    {        
        return APIClientError(status: error.code,
                              code: APIClientError.DefaultCode,
                              title: error.localizedDescription,
                              source: APIClientError.DefaultSource,
                              detail: error.localizedFailureReason ?? APIClientError.DefaultDomain,
                              domain: error.domain)
    }
    
    static func errorFromAuthenticationError(_ authenticationError: AuthenticationError) -> APIClientError
    {
        return APIClientError(status: APIClientError.LoginStatus,
                              code: APIClientError.DefaultAuthenticationCode,
                              title: authenticationError.description,
                              source: APIClientError.DefaultSource,
                              detail: APIClientError.DefaultDetail)
    }
}
