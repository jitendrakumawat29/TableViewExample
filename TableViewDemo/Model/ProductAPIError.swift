//
//  ProductAPIError.swift
//  TableViewDemo
//
//  Created by Jitendra Kumar on 21/07/20.
//  Copyright © 2020 Jitendra Kumar. All rights reserved.
//

import Foundation

enum ProductAPIError: LocalizedError, Equatable {
    
    case invalidResponseModel
    case invalidRequestURLString
    case failedRequest(description: String)
    
    var errorDescription: String? {
        switch self {
        case .failedRequest(let description):
            return description
        case .invalidResponseModel, .invalidRequestURLString:
            return ""
        }
    }
    
}
