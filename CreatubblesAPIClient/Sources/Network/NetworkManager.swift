//
//  NetworkManager.swift
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
        
        Logger.log(.debug, "cURL: \(urlRequest.cURLRepresentation(session: self.session))")
        session.dataTask(with: urlRequest) { (data, response, error) -> Void in
            if let data = data {
                let json = try? JSONSerialization.jsonObject(with: data, options: [])
                if let response = response as? HTTPURLResponse , 200...299 ~= response.statusCode {
                    
                    let err: APIClientError? = error == nil ? nil : ErrorTransformer.errorFromNSError(error! as NSError)
                    completion(json as AnyObject?, err)
                } else {
                    
                    let err: APIClientError? = error == nil ? APIClientError.invalidServerResponseError : ErrorTransformer.errorFromNSError(error! as NSError)
                    completion(json as AnyObject?, err)
                }
            } else {
                let err: APIClientError? = error == nil ? APIClientError.missingServerResponseError : ErrorTransformer.errorFromNSError(error! as NSError)
                completion(nil, err)
            }
        }.resume()
    }
    
    private func clientURLRequest(request: Request) -> URLRequest {
        var urlRequest = URLRequest(url: URL(string: request.onlyPath ? urlStringWithRequest(request) : request.endpoint)!)
        urlRequest.httpMethod = request.method.rawValue
        
        if let locale = settings.locale {
            urlRequest.setValue(locale, forHTTPHeaderField: "Accept-Language")
        }
        
        if let accessToken = authClient.privateAccessToken ?? authClient.publicAccessToken  {
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
