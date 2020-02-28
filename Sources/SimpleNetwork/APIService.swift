//
//  APIService.swift
//
//  Created by MD AL Mamun on 2020-02-27.
//  Copyright © 2020 MD AL Mamun. All rights reserved.
//

import Foundation
import Combine

protocol APISetviceType {
    func send<APIRequest: APIRequestType>(_ request: APIRequest) -> AnyPublisher<APIRequest.ResponseBody, Error>
}

final class APIService {
    let baseUrl: String
    let urlSession: URLSession
    
    init(baseUrl: String, urlSession: URLSession) {
        self.baseUrl    = baseUrl
        self.urlSession = urlSession
    }
}

extension APIService: APISetviceType {
    func send<APIRequest>(_ request: APIRequest) -> AnyPublisher<APIRequest.ResponseBody, Error> where APIRequest : APIRequestType {
        do {
            let urlRequest = try self.makeUrlRequest(request)
            return self.urlSession
                .dataTaskPublisher(for: urlRequest)
                .parse(to: APIRequest.ResponseBody.self)
        } catch {
            return Fail(error: error)
                .eraseToAnyPublisher()
        }
    }
    
    private func makeUrlRequest<APIRequest: APIRequestType>(_ request: APIRequest) throws -> URLRequest {
        let urlString = baseUrl + request.path
        guard var urlComponents = URLComponents(string: urlString) else {
            throw APIError.invalidUrl(urlString)
        }
        urlComponents.queryItems = request.queries
        guard let url = urlComponents.url else {
            throw APIError.invalidQueryItems(urlComponents.queryItems)
        }
        var urlRequest = URLRequest(url: url)
        urlRequest.httpBody = try JSONEncoder().encode(request.body)
        urlRequest.httpMethod = request.method.rawValue
        urlRequest.allHTTPHeaderFields = request.rawHeaders
        
        return urlRequest
    }
}

extension Publisher where Output == URLSession.DataTaskPublisher.Output {
    func parse<T: Decodable>(to type: T.Type) -> AnyPublisher<T, Error> {
        self.tryMap { output in
            guard let httpResponse = output.response as? HTTPURLResponse else {
                throw APIError.unknownRequestType
            }
            
            guard (200..<300).contains(httpResponse.statusCode) else {
                // TODO: Decode response body as Error
                throw APIError.responseFailed(httpResponse.statusCode)
            }
            return output.data
        }
        .decode(type: type, decoder: JSONDecoder())
        .eraseToAnyPublisher()
    }
}
