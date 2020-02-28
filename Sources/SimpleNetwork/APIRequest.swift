//
//  APIRequest.swift
//
//  Created by MD AL Mamun on 2020-02-28.
//  Copyright © 2020 MD AL Mamun. All rights reserved.
//

import Foundation

typealias HTTPHeader = (key: String, value: String)

enum HTTPMethod: String {
    case get    = "GET"
    case post   = "POST"
}

protocol APIRequestType {
    associatedtype Body: Encodable
    associatedtype ResponseBody: Decodable
    
    var method: HTTPMethod          { get }
    var path: String                { get }
    var queries: [URLQueryItem]?    { get }
    var body: Body                  { get }
    var headers: [HTTPHeader]?      { get }
}

extension APIRequestType {
    var rawHeaders: [String: String]? {
        guard let headers = headers else { return nil }
        return headers.reduce(into: [:]) { (result, header) in
            return result[header.key] = header.value
        }
    }
}

