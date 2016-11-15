//
//  URLRequest+CURL.swift
//  CreatubblesAPIClient
//
//  Created by Dawid Płatek on 15.11.2016.
//  Copyright © 2016 Nomtek. All rights reserved.
//

import UIKit

extension URLRequest {
    func cURLRepresentation(session: URLSession) -> String {
        var components = ["$ curl -i"]
        
        guard let url = self.url,
            let _ = url.host
            else {
                return "$ curl command could not be created"
        }
        
        if let httpMethod = self.httpMethod, httpMethod != "GET" {
            components.append("-X \(httpMethod)")
        }
        
        if session.configuration.httpShouldSetCookies {
            if
                let cookieStorage = session.configuration.httpCookieStorage,
                let cookies = cookieStorage.cookies(for: url), !cookies.isEmpty
            {
                let string = cookies.reduce("") { $0 + "\($1.name)=\($1.value);" }
                components.append("-b \"\(string.substring(to: string.characters.index(before: string.endIndex)))\"")
            }
        }
        
        var headers: [AnyHashable: Any] = [:]
        
        if let additionalHeaders = session.configuration.httpAdditionalHeaders {
            for (field, value) in additionalHeaders where field != AnyHashable("Cookie") {
                headers[field] = value
            }
        }
        
        if let headerFields = allHTTPHeaderFields {
            for (field, value) in headerFields where field != "Cookie" {
                headers[field] = value
            }
        }
        
        for (field, value) in headers {
            components.append("-H \"\(field): \(value)\"")
        }
        
        if let httpBodyData = self.httpBody, let httpBody = String(data: httpBodyData, encoding: .utf8) {
            var escapedBody = httpBody.replacingOccurrences(of: "\\\"", with: "\\\\\"")
            escapedBody = escapedBody.replacingOccurrences(of: "\"", with: "\\\"")
            
            components.append("-d \"\(escapedBody)\"")
        }
        
        components.append("\"\(url.absoluteString)\"")
        
        return components.joined(separator: " \\\n\t")
    }
}
