
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
    case UploadCancelled
    
    case BadRequest
    case NotAuthorized
    case Forbidden
    case NotFound
    case NotAcceptable
    case ValidationError
    case TooManyRequests
    case InternalServerError
    case ServiceUnavailable
    
    public static var Domain: String { return "com.creatubbles.errordomain" }
    
    public var code: Int
    {
        switch self
        {
        case .Generic: return -6000
        case .NetworkError: return -6001
        case .Unknown: return -6002
        case .LoginError: return -6003
        case .UploadCancelled: return -6004
            
        case .BadRequest: return -6400
        case .NotAuthorized: return -6401
        case .Forbidden: return -6403
        case .NotFound: return -6404
        case .NotAcceptable: return -6406
        case .ValidationError: return -6422
        case .TooManyRequests: return -6429
        case .InternalServerError: return -6500
        case .ServiceUnavailable: return -6503
        }
    }
    
    public var errorDescription: String
    {
        switch self
        {
        case .Generic(let desc): return desc
        case .NetworkError:  return "Network error"
        case .Unknown: return "Unknown"
        case .LoginError: return "Error during login"
        case .UploadCancelled: return "Creation upload cancelled"
            
        case .BadRequest: return "Bad request"
        case .NotAuthorized: return "Not authorized"
        case .Forbidden: return "Forbidden"
        case .NotFound: return "Not found"
        case .NotAcceptable: return "Not acceptable"
        case .ValidationError: return "Validation error"
        case .TooManyRequests: return "Too many requests"
        case .InternalServerError: return "Internal server error"
        case .ServiceUnavailable: return "Service unavailable"
            
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
        } else if let response = response, let errorDescription = response["error_description"] as? String {
            return [APIClientError.Generic(errorDescription)]
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