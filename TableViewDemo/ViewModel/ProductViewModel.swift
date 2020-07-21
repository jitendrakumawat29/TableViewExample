//
//  ProductViewModel.swift
//  TableViewDemo
//
//  Created by Jitendra Kumar on 18/07/20.
//  Copyright © 2020 Jitendra Kumar. All rights reserved.
//

import Foundation

class ProductViewModel {
    //MARK: class properties
    var productResult: ProductResult?
    var productWebService: WebService!
    weak var delegate: APIResponseProtocol?
    
    init() {
        // initialise the webservice instance
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
    
    // call the API to fetch data from server
     func fetchProducts() {
        self.productWebService.getProducts() { (productResult, error) in
            if let error = error { // failure condition
                DispatchQueue.main.async {
                    self.delegate?.errorHandler(error: error)
                }
                return
            }
            
            if let productResult = productResult { // success block
                DispatchQueue.main.async {
                    self.productResult = productResult
                    self.delegate?.didReceiveResponse()
                }
            }
        }
    }
}


