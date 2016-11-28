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

import UIKit
import ObjectMapper

//MARK: Defaults
extension APIClientError
{
    public static let DefaultDomain: String = "com.creatubbles.apiclient.errordomain"
    public static let DefaultStatus: Int    = -6000
    public static let DefaultCode:   String = "creatubbles-apiclient-default-code"
    public static let DefaultTitle:  String = "creatubbles-apiclient-default-title"
    public static let DefaultSource: String = "creatubbles-apiclient-default-source"
    public static let DefaultDetail: String = "creatubbles-apiclient-default-detail"
    public static let DefaultAuthenticationCode:   String = "authentication-error"
    public static let InvalidResponseDataCode:   String = "invalid-response-error"
    public static let MissingResponseDataCode:   String = "missing-response-error"
}

//MARK: Error codes
extension APIClientError
{
    public static let UnknownStatus: Int = -6001
    public static let LoginStatus: Int = -6002
    public static let UploadCancelledStatus: Int = -6003
    public static let MissingResponseDataStatus: Int = -6004
    public static let InvalidResponseDataStatus: Int = -6005
}

//  For error documentation, please check:
//  https://partners.creatubbles.com/api/#errors
//  http://jsonapi.org/format/#error-objects
open class APIClientError: NSObject, Error, NSCoding
{    
    open let status: Int?
    open let code: String?
    open let title: String?
    open let source: String?
    open let detail: String?
    open let domain: String?
    
    init(status: Int?, code: String?, title: String?, source: String?, detail: String?, domain: String? = APIClientError.DefaultDomain)
    {
        self.status = status ?? APIClientError.DefaultStatus
        self.code   = code   ?? APIClientError.DefaultCode
        self.title  = title  ?? APIClientError.DefaultTitle
        self.source = source ?? APIClientError.DefaultSource
        self.detail = detail ?? APIClientError.DefaultDetail
        self.domain = APIClientError.DefaultDomain
        super.init()
    }
    
    init(mapper: ErrorMapper)
    {
        self.status = mapper.status ?? APIClientError.DefaultStatus
        self.code   = mapper.code   ?? APIClientError.DefaultCode
        self.title  = mapper.title  ?? APIClientError.DefaultTitle
        self.source = mapper.source ?? APIClientError.DefaultSource
        self.detail = mapper.detail ?? APIClientError.DefaultDetail
        self.domain = APIClientError.DefaultDomain
        super.init()

    }
    
    public func encode(with aCoder: NSCoder)
    {
        aCoder.encode(status, forKey: "nonce")
        aCoder.encode(code, forKey: "code")
        aCoder.encode(title, forKey: "title")
        aCoder.encode(source, forKey: "source")
        aCoder.encode(detail, forKey: "detail")
        aCoder.encode(domain, forKey: "domain")
    }
    
    public required init?(coder aDecoder: NSCoder)
    {
        self.status = aDecoder.decodeInteger(forKey: "status")
        self.code = aDecoder.decodeObject(forKey: "code") as? String
        self.title = aDecoder.decodeObject(forKey: "title") as? String
        self.source = aDecoder.decodeObject(forKey: "source") as? String
        self.detail = aDecoder.decodeObject(forKey: "detail") as? String
        self.domain = aDecoder.decodeObject(forKey: "domain") as? String
    }
}

extension APIClientError
{
    class var genericLoginError: APIClientError
    {
        return APIClientError(status: APIClientError.LoginStatus,
                              code:   APIClientError.DefaultAuthenticationCode,
                              title:  "error_auth_failed_title".localized,
                              source: "https://www.creatubbles.com/api/v2/users",
                              detail: "error_auth_failed_detail".localized)
    }
    
    class var genericUploadCancelledError: APIClientError
    {
        return APIClientError(status: APIClientError.UploadCancelledStatus,
                              code:   "upload-cancelled",
                              title:  "error_upload_cancelled_title".localized,
                              source: APIClientError.DefaultSource,
                              detail: "error_upload_cancelled_detail".localized)
    }
    
    class var missingServerResponseError: APIClientError
    {
        return APIClientError(status: APIClientError.MissingResponseDataStatus,
                              code:   APIClientError.MissingResponseDataCode,
                              title:  "error_missing_response_title".localized,
                              source: APIClientError.DefaultSource,
                              detail: "error_missing_response_detail".localized)
    }
    
    class var invalidServerResponseError: APIClientError
    {
        return APIClientError(status: APIClientError.InvalidResponseDataStatus,
                              code:   APIClientError.InvalidResponseDataCode,
                              title:  "error_invalid_response_title".localized,
                              source: APIClientError.DefaultSource,
                              detail: "error_invalid_response_detail".localized)
    }
    
    static func genericError(_ status: Int? = nil, code: String? = nil, title: String? = nil, source: String? = nil, detail: String? = nil, domain: String? = nil) -> APIClientError
    {
        return APIClientError(status: status ?? APIClientError.UnknownStatus,
                              code: code ?? APIClientError.DefaultCode,
                              title: title ?? APIClientError.DefaultTitle,
                              source: source ?? APIClientError.DefaultSource,
                              detail: detail ?? APIClientError.DefaultDetail,
                              domain: domain ?? APIClientError.DefaultDomain)
    }
}

