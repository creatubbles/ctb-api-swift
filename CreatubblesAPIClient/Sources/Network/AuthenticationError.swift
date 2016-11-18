//
//  AuthenticationError.swift
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

/**
 All errors that might occur.
 
 The response errors return a description as defined in the spec: http://tools.ietf.org/html/rfc6749#section-4.1.2.1
 */
public enum AuthenticationError: Error, CustomStringConvertible {
    
    /// An error for which we don't have a specific one.
    case generic(String)
    
    /// An error holding on to an NSError.
    case nsError(Foundation.NSError)
    
    /// Invalid URL components, failed to create a URL
    case invalidURLComponents(URLComponents)
    
    
    // MARK: - Client errors
    
    /// There is no client id.
    case noClientId
    
    /// There is no client secret.
    case noClientSecret
    
    /// There is no redirect URL.
    case noRedirectURL
    
    /// There is no username.
    case noUsername
    
    /// There is no password.
    case noPassword
    
    /// The client is already authorizing.
    case alreadyAuthorizing
    
    /// There is no authorization context.
    case noAuthorizationContext
    
    /// The authorization context is invalid.
    case invalidAuthorizationContext
    
    /// The redirect URL is invalid; with explanation.
    case invalidRedirectURL(String)
    
    /// There is no refresh token.
    case noRefreshToken
    
    /// There is no registration URL.
    case noRegistrationURL
    
    
    // MARK: - Request errors
    
    /// The request is not using SSL/TLS.
    case notUsingTLS
    
    /// Unable to open the authorize URL.
    case unableToOpenAuthorizeURL
    
    /// The request is invalid.
    case invalidRequest
    
    /// The request was cancelled.
    case requestCancelled
    
    
    // MARK: - Response Errors
    
    /// There was no token type in the response.
    case noTokenType
    
    /// The token type is not supported.
    case unsupportedTokenType(String)
    
    /// There was no data in the response.
    case noDataInResponse
    
    /// Some prerequisite failed; with explanation.
    case prerequisiteFailed(String)
    
    /// The state parameter was missing in the response.
    case missingState
    
    /// The state parameter was invalid.
    case invalidState
    
    /// The JSON response could not be parsed.
    case jsonParserError
    
    /// Unable to UTF-8 encode.
    case utf8EncodeError
    
    /// Unable to decode to UTF-8.
    case utf8DecodeError
    

    // MARK: - OAuth2 errors
    
    /// The client is unauthorized (HTTP status 401).
    case unauthorizedClient
    
    /// The request was forbidden (HTTP status 403).
    case forbidden
    
    /// Username or password was wrong (HTTP status 403 on password grant).
    case wrongUsernamePassword
    
    /// Access was denied.
    case accessDenied
    
    /// Response type is not supported.
    case unsupportedResponseType
    
    /// Scope was invalid.
    case invalidScope
    
    /// A 500 was thrown.
    case serverError
    
    /// The service is temporarily unavailable.
    case temporarilyUnavailable
    
    /// Other response error, as defined in its String.
    case responseError(String)
    
    
    /**
     Instantiate the error corresponding to the OAuth2 response code, if it is known.
     
     - parameter code: The code, like "access_denied", that should be interpreted
     - parameter fallback: The error string to use in case the error code is not known
     - returns: An appropriate OAuth2Error
     */
    public static func fromResponseError(_ code: String, fallback: String? = nil) -> AuthenticationError {
        switch code {
        case "invalid_request":
            return .invalidRequest
        case "unauthorized_client":
            return .unauthorizedClient
        case "access_denied":
            return .accessDenied
        case "unsupported_response_type":
            return .unsupportedResponseType
        case "invalid_scope":
            return .invalidScope
        case "server_error":
            return .serverError
        case "temporarily_unavailable":
            return .temporarilyUnavailable
        default:
            return .responseError(fallback ?? "Authorization error: \(code)")
        }
    }
    
    /// Human understandable error string.
    public var description: String {
        switch self {
        case .generic(let message):
            return message
        case .nsError(let error):
            return error.localizedDescription
        case .invalidURLComponents(let components):
            return "Failed to create URL from components: \(components)"
            
        case .noClientId:
            return "error_auth_noClientId".localized
        case .noClientSecret:
            return "error_auth_noClientSecret".localized
        case .noRedirectURL:
            return "error_auth_noRedirectURL".localized
        case .noUsername:
            return "error_auth_noUsername".localized
        case .noPassword:
            return "error_auth_noPassword".localized
        case .alreadyAuthorizing:
            return "error_auth_alreadyAuthorizing".localized
        case .noAuthorizationContext:
            return "error_auth_noAuthorizationContext".localized
        case .invalidAuthorizationContext:
            return "error_auth_invalidAuthorizationContext".localized
        case .invalidRedirectURL(let url):
            return String(format: "error_auth_invalidRedirectURL".localized, url)
        case .noRefreshToken:
            return "error_auth_noRefreshToken".localized
            
        case .noRegistrationURL:
            return "error_auth_noRegistrationURL".localized
            
        case .notUsingTLS:
            return "error_auth_notUsingTLS".localized
        case .unableToOpenAuthorizeURL:
            return "error_auth_unableToOpenAuthorizeURL".localized
        case .invalidRequest:
            return "error_auth_invalidRequest".localized
        case .requestCancelled:
            return "error_auth_requestCancelled".localized
        case .noTokenType:
            return "error_auth_noTokenType".localized
        case .unsupportedTokenType(let message):
            return message
        case .noDataInResponse:
            return "error_auth_noDataInResponse".localized
        case .prerequisiteFailed(let message):
            return message
        case .missingState:
            return "error_auth_missingState".localized
        case .invalidState:
            return "error_auth_invalidState".localized
        case .jsonParserError:
            return "error_auth_jsonParserError".localized
        case .utf8EncodeError:
            return "error_auth_utf8EncodeError".localized
        case .utf8DecodeError:
            return "error_auth_utf8DecodeError".localized
            
        case .unauthorizedClient:
            return "error_auth_unauthorizedClient".localized
        case .forbidden:
            return "error_auth_forbidden".localized
        case .wrongUsernamePassword:
            return "error_auth_wrongUsernamePassword".localized
        case .accessDenied:
            return "error_auth_accessDenied".localized
        case .unsupportedResponseType:
            return "error_auth_unsupportedResponseType".localized
        case .invalidScope:
            return "error_auth_invalidScope".localized
        case .serverError:
            return "error_auth_serverError".localized
        case .temporarilyUnavailable:
            return "error_auth_temporarilyUnavailable".localized
        case .responseError(let message):
            return message
        }
    }
}
