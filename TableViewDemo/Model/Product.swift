//
//  Product.swift
//  TableViewDemo
//
//  Created by Jitendra Kumar on 17/07/20.
//  Copyright © 2020 Jitendra Kumar. All rights reserved.
//

import UIKit

struct Product: Decodable {
    var title : String?
    var imageURL : String?
    var description : String?
    
    enum CodingKeys: String, CodingKey {
       case title
       case imageURL = "imageHref"
       case description
    }
    
}

struct ProductResult: Decodable {
    let title: String?
    let products: [Product]?

        enum CodingKeys: String, CodingKey {
           case title
           case products = "rows"
        }
       
    
    

}

