//
//  MockProductWebService.swift
//  TableViewDemoTests
//
//  Created by Jitendra Kumar on 18/07/20.
//  Copyright © 2020 Jitendra Kumar. All rights reserved.
//

import Foundation

@testable import TableViewDemo


class MockProductWebService {
 
    var isProductMethodCalled: Bool = false
    var shouldReturnError: Bool = false
 
    func getProducts(completion: @escaping (ProductResult?, ProductAPIError?) -> (Void)) {
        isProductMethodCalled = true
        if shouldReturnError {
            completion(nil, ProductAPIError.failedRequest(description: "Product request was not successful"))
        } else {
            let responseModel = ProductResult(title: "Some Title", products: [Product(title: "Any Title", imageURL: "Some URL", description: "Some Description")])
            completion(responseModel, nil)
        }
    }
}
