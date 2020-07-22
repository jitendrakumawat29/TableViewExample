//
//  ViewController.swift
//  TableViewDemo
//
//  Created by Jitendra Kumar on 17/07/20.
//  Copyright © 2020 Jitendra Kumar. All rights reserved.
//

import UIKit

// This protocol is implemented when we get response from server
protocol APIResponseProtocol:class {
    func didReceiveResponse()
    func errorHandler(error: ProductAPIError)
}

class ViewController: UIViewController {

    // MARK: Class Properties
    let tableView = UITableView()
    var safeArea: UILayoutGuide!
    let cellId = "cellId"
    var productVM = ProductViewModel()
    private let refreshControl = UIRefreshControl()

    // MARK: View Controller Cycle
    override func loadView() {
      super.loadView()
      view.backgroundColor = .white
      self.safeArea = view.layoutMarginsGuide
      self.setupTableView()
      self.productVM.delegate = self
    }
    
    // Add table view and it's Constraints to main view
    func setupTableView() {
       if #available(iOS 11.0, *) {
        IndicatorView.shared.showProgressView()
       } else {
            // Fallback on earlier versions
       }
      // call the api to fetch all the products from server
      productVM.fetchProducts()
        
      self.tableView.isHidden = true
      self.tableView.dataSource = self
      self.tableView.delegate = self
      
      self.tableView.rowHeight = UITableView.automaticDimension
      self.tableView.estimatedRowHeight = 100
      self.tableView.register(ProductCell.self, forCellReuseIdentifier: cellId)

      // Set table view constraint
      view.addSubview(self.tableView)
      self.tableView.translatesAutoresizingMaskIntoConstraints = false
      self.tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
      self.tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
      self.tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
      self.tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        
      // add pull to refresh to tableview and add target action
      self.tableView.addSubview(refreshControl)
      self.refreshControl.tintColor = UIColor.appThemeColor
      let string = "Fetching Product Data.."
      let stringAttribute = [NSAttributedString.Key.foregroundColor: UIColor.appThemeColor, NSAttributedString.Key.font: UIFont.regular(16)]
      let atributeString = NSAttributedString(string: string, attributes: stringAttribute)
      self.refreshControl.attributedTitle = atributeString
      self.refreshControl.addTarget(self, action: #selector(refreshProductData(_:)), for: .valueChanged)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // set navigation bar title and tint color
        self.navigationController?.navigationBar.barTintColor = UIColor.appThemeColor
        self.navigationController?.navigationBar.titleTextAttributes =
        [NSAttributedString.Key.foregroundColor: UIColor.white,
         NSAttributedString.Key.font: UIFont.bold(18)]

    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
    }
    @objc private func refreshProductData(_ sender: Any) {
        // call the api to fetch all the latest products from server
        productVM.fetchProducts()
    }
}

// MARK: Table view delegate
extension ViewController: UITableViewDelegate, UITableViewDataSource {
   func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! ProductCell
      cell.selectionStyle = .none
      let currentLastItem = productVM.products[indexPath.row]
      cell.product = currentLastItem
    
      return cell
  }
  
   func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return productVM.products.count
  }
}

// MARK: API response
extension ViewController: APIResponseProtocol {
    func errorHandler(error: ProductAPIError) {
        IndicatorView.shared.hideProgressView()
        self.refreshControl.endRefreshing()
    }
    
    func didReceiveResponse() {
        IndicatorView.shared.hideProgressView()
        // Once data has pulled from server then update table view and display to view
        self.navigationController?.navigationBar.topItem?.title = self.productVM.title
        self.tableView.isHidden = false
        self.tableView.reloadData()
        self.refreshControl.endRefreshing()
    }
}

