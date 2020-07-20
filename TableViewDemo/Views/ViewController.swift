//
//  ViewController.swift
//  TableViewDemo
//
//  Created by Jitendra Kumar on 17/07/20.
//  Copyright © 2020 Jitendra Kumar. All rights reserved.
//

import UIKit

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
      safeArea = view.layoutMarginsGuide
      setupTableView()
      self.productVM.delegate = self
    }
    
    func setupTableView() {
      IndicatorView.shared.showProgressView()
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
        
      // add pull to refresh
      self.tableView.addSubview(refreshControl)
      self.refreshControl.tintColor = UIColor.blue
      let string = "Fetching Product Data.."
      let stringAttribute = [NSAttributedString.Key.foregroundColor: UIColor.blue]
      let atributeString = NSAttributedString(string: string, attributes: stringAttribute)
      self.refreshControl.attributedTitle = atributeString
      self.refreshControl.addTarget(self, action: #selector(refreshProductData(_:)), for: .valueChanged)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        self.navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    @objc private func refreshProductData(_ sender: Any) {
        // Fetch Products Data
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
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
       return UITableView.automaticDimension
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
        self.navigationController?.navigationBar.topItem?.title = productVM.title
        self.tableView.isHidden = false
        self.tableView.reloadData()
        self.refreshControl.endRefreshing()
    }
}

