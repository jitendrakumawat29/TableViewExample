//
//  WebService.swift
//  TableViewDemo
//
//  Created by Jitendra Kumar on 18/07/20.
//  Copyright © 2020 Jitendra Kumar. All rights reserved.
//

import Foundation

class WebService {
    
    private var urlSession: URLSession
    private var urlString: String
    
    init(urlString: String, urlSession: URLSession = .shared) {
        self.urlString = urlString
        self.urlSession = urlSession
    }
    
    func getProducts(completion: @escaping (ProductResult?, ProductAPIError?) -> (Void)) {
        
        guard let url = URL(string: urlString) else {
            completion(nil, ProductAPIError.invalidRequestURLString)
            return
        }

        urlSession.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                completion(nil, ProductAPIError.failedRequest(description: error!.localizedDescription))
                return
            }
            
            let utf8Data = String(decoding: data, as: UTF8.self).data(using: .utf8)
            let productResult = try? JSONDecoder().decode(ProductResult.self, from: utf8Data!)

            if let productResult = productResult {
                completion(productResult, nil)
            }
            else {
                completion(nil, ProductAPIError.invalidResponseModel)
            }
        }.resume()
    }
}
