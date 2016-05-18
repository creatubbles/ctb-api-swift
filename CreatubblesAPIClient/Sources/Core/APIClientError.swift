
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

public enum APIClientError: ErrorType
{
    case Generic(String)
    case NetworkError
    case LoginError
    case Unknown
    
    public var errorDescription: String
    {
        switch self
        {
            case .Generic(let desc): return desc
            case .NetworkError:  return "Network error"
            case .Unknown: return "Unknown"
            case .LoginError: return "Error during login"
        }
    }
}

class ErrorTransformer
{
    class func errorFromResponse(response: Dictionary<String, AnyObject>?,error: ErrorType?) -> APIClientError?
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
        if  let response = response,
            let mappers = Mapper<ErrorMapper>().mapArray(response["errors"])
        {
            var errors = Array<APIClientError>()
            for mapper in mappers
            {
                if let detail = mapper.detail
                {
                    errors.append(APIClientError.Generic(detail))
                }
            }
            return errors
        }
        return Array<APIClientError>()
    }
    
    
    private class func errorFromErrorType(error: ErrorType?) -> APIClientError?
    {
        //TODO: Handle it properly.
        if let _ = error
        {
            return APIClientError.Unknown;
        }
        
        return nil
    }
}