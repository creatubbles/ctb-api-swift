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
    
    func dataTask(request: Request, completion: @escaping (_ response: AnyObject?, _ error: APIClientError?) -> ()) {
        let urlRequest = clientURLRequest(request: request)
        
        Logger.log.debug("cURL: \(urlRequest.cURLRepresentation(session: self.session))")
        session.dataTask(with: urlRequest) { (data, response, error) -> Void in
            if let data = data {
                let json = try? JSONSerialization.jsonObject(with: data, options: [])
                if let response = response as? HTTPURLResponse , 200...299 ~= response.statusCode {
                    completion(json as AnyObject?, nil)
                } else {
                    let error = APIClientError.invalidServerResponseError
                    completion(json as AnyObject?, error)
                }
            } else {
                let error = APIClientError.missingServerResponseError
                completion(nil, error)
            }
        }.resume()
    }
    
    private func clientURLRequest(request: Request) -> URLRequest {
        var urlRequest = URLRequest(url: URL(string: request.onlyPath ? urlStringWithRequest(request) : request.endpoint)!)
        urlRequest.httpMethod = request.method.rawValue
        
        if let locale = settings.locale {
            urlRequest.setValue(locale, forHTTPHeaderField: "Accept-Language")
        }
        
        if let accessToken = authClient.accessToken {
            urlRequest.addValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
        }
        
        urlRequest.addValue("application/json", forHTTPHeaderField: "Accept")
        
        if request.parameters.count == 0 { return urlRequest }
        guard let url = urlRequest.url else { return urlRequest }
        
        let parametersEncoder = ParametersEncoder()
        
        if encodesParametersInURL(with: request.method) {
            if var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false), !request.parameters.isEmpty {
                let percentEncodedQuery = (urlComponents.percentEncodedQuery.map { $0 + "&" } ?? "") + parametersEncoder.encode(request.parameters)
                urlComponents.percentEncodedQuery = percentEncodedQuery
                urlRequest.url = urlComponents.url
            }
        } else {
            if urlRequest.value(forHTTPHeaderField: "Content-Type") == nil {
                urlRequest.setValue("application/x-www-form-urlencoded; charset=utf-8", forHTTPHeaderField: "Content-Type")
            }
        
            urlRequest.httpBody = parametersEncoder.encode(request.parameters).data(using: .utf8, allowLossyConversion: false)
        }
        
        return urlRequest
    }
    
    private func urlStringWithRequest(_ request: Request) -> String {
        return String(format: "%@/%@/%@", arguments: [settings.baseUrl, settings.apiVersion, request.endpoint])
    }
    
    private func encodesParametersInURL(with method: RequestMethod) -> Bool {
        switch method {
            case .get, .head, .delete:
                return true
            default:
                return false
        }
    }
}
