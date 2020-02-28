//
//  APIError.swift
//
//  Created by MD AL Mamun on 2020-02-28.
//  Copyright © 2020 MD AL Mamun. All rights reserved.
//

import Foundation

enum APIError: Error {
    case invalidUrl(String)
    case unknownRequestType
    case responseFailed(Int)
    case invalidQueryItems([URLQueryItem]?)
}

