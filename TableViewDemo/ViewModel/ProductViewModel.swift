//
//  ProductViewModel.swift
//  TableViewDemo
//
//  Created by Jitendra Kumar on 18/07/20.
//  Copyright © 2020 Jitendra Kumar. All rights reserved.
//

import Foundation

class ProductViewModel {
    var productResult: ProductResult?
    var productWebService: WebService!
    weak var delegate: APIResponseProtocol?
    
    init() {
        self.productWebService = WebService(urlString: ProductConstant.productURLString)
    }
    
    var title: String {
        if let title = self.productResult?.title {
            return title
        }
        else {
            return ""
        }
    }
    
    var products: [Product] {
        if let products = self.productResult?.products {
            return products
        }
        else {
            return [Product]()
        }
    }
    
    
     func fetchProducts() {
        self.productWebService.getProducts() { (productResult, error) in
            
            if let error = error {
                self.delegate?.errorHandler(error: error)
                return
            }
            
            if let productResult = productResult {
                DispatchQueue.main.async {
                    self.productResult = productResult
                    self.delegate?.didReceiveResponse()
                }
            }
        }
    }
}


