//
//  NetworkManager.swift
//  CreatubblesAPIClient
//
//  Created by Dawid Płatek on 26.10.2016.
//  Copyright © 2016 Nomtek. All rights reserved.
//

import UIKit

class NetworkManager: NSObject {
    private lazy var session: URLSession = {
        var configuration = URLSessionConfiguration.default
        configuration.httpAdditionalHeaders = HTTPHeadersBuilder.defaultHTTPHeaders
        return URLSession(configuration: configuration, delegate: nil, delegateQueue: nil)
    }()
    
    private let settings: APIClientSettings
    let authClient = OAuth2Client()
    
    public init(settings: APIClientSettings) {
        self.settings = settings
    }
    
    func dataTask(request: Request, completion: @escaping (_ success: Bool, _ object: AnyObject?) -> ()) {
        session.dataTask(with: clientURLRequest(request: request)) { (data, response, error) -> Void in
            if let data = data {
                let json = try? JSONSerialization.jsonObject(with: data, options: [])
                if let response = response as? HTTPURLResponse , 200...299 ~= response.statusCode {
                    completion(true, json as AnyObject?)
                } else {
                    completion(false, json as AnyObject?)
                }
            }
        }.resume()
    }
    
    private func clientURLRequest(request: Request) -> URLRequest {
        var urlRequest = URLRequest(url: NSURL(string: urlStringWithRequest(request))! as URL)
        urlRequest.httpMethod = request.method.rawValue
        
        urlRequest.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        if let locale = settings.locale {
            urlRequest.setValue(locale, forHTTPHeaderField: "Accept-Language")
        }
        
        let parametersEncoder = ParametersEncoder()
        urlRequest.httpBody = parametersEncoder.encode(request.parameters).data(using: String.Encoding.utf8)
        
        if let accessToken = authClient.accessToken {
            urlRequest.addValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
        }
        
        return urlRequest
    }
    
    fileprivate func urlStringWithRequest(_ request: Request) -> String {
        return String(format: "%@/%@/%@", arguments: [settings.baseUrl, settings.apiVersion, request.endpoint])
    }
}
