//
//  ProductCell.swift
//  TableViewDemo
//
//  Created by Jitendra Kumar on 17/07/20.
//  Copyright © 2020 Jitendra Kumar. All rights reserved.
//

import UIKit
import SDWebImage


class ProductCell : UITableViewCell {
    
    var product : Product? {
        didSet {
            productImage.sd_setImage(with: URL(string: product?.imageURL ?? ""), placeholderImage: UIImage(named: "applelogo"))
            productNameLabel.text = product?.title
            productDescriptionLabel.text = product?.description
        }
    }
    
    private let productNameLabel : UILabel = {
        let lbl = UILabel()
        lbl.textColor = .black
        lbl.font = UIFont.boldSystemFont(ofSize: 16)
        lbl.textAlignment = .left
        return lbl
    }()
    
    
    private let productDescriptionLabel : UILabel = {
        let lbl = UILabel()
        lbl.textColor = .black
        lbl.font = UIFont.systemFont(ofSize: 16)
        lbl.textAlignment = .left
        lbl.numberOfLines = 0
        return lbl
    }()
    
    private let productImage : UIImageView = {
        let imgView = UIImageView(image: UIImage(named: "applelogo"))
        imgView.contentMode = .scaleAspectFit
        imgView.clipsToBounds = true
        return imgView
    }()
    
   
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(productNameLabel)
        contentView.addSubview(productDescriptionLabel)
        contentView.addSubview(productImage)
        
        // To set cell minimum height. It will be used when either title or description or both are null
        contentView.heightAnchor.constraint(greaterThanOrEqualToConstant: 60).isActive = true
        
        let marginGuide = contentView.layoutMarginsGuide
        
        // Product Imageview Constraint
        productImage.contentMode = .scaleAspectFit
        productImage.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            productImage.widthAnchor.constraint(equalToConstant: 50),
            productImage.heightAnchor.constraint(equalToConstant: 50),
            productImage.topAnchor.constraint(equalTo: marginGuide.topAnchor, constant: -5),
            productImage.leftAnchor.constraint(equalTo: marginGuide.leftAnchor),
        ])

        // Product Name
        productNameLabel.translatesAutoresizingMaskIntoConstraints = false
        productNameLabel.numberOfLines = 0
        productNameLabel.leadingAnchor.constraint(equalTo: productImage.trailingAnchor, constant: 10).isActive = true
        productNameLabel.topAnchor.constraint(equalTo: marginGuide.topAnchor).isActive = true
        productNameLabel.trailingAnchor.constraint(equalTo: marginGuide.trailingAnchor).isActive = true
        
        // Product Description
        productDescriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        productDescriptionLabel.numberOfLines = 0
        productDescriptionLabel.leadingAnchor.constraint(equalTo: productImage.trailingAnchor, constant: 10).isActive = true
        productDescriptionLabel.bottomAnchor.constraint(equalTo: marginGuide.bottomAnchor).isActive = true
        productDescriptionLabel.trailingAnchor.constraint(equalTo: marginGuide.trailingAnchor).isActive = true
        productDescriptionLabel.topAnchor.constraint(equalTo: productNameLabel.bottomAnchor).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

