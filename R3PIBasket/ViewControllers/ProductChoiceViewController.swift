//
//  ProductChoiceViewController.swift
//  R3PIBasket
//
//  Created by Stephan Korner on 01.07.18.
//  Copyright © 2018 Ideen Kaffee Korner. All rights reserved.
//

import Foundation
import UIKit

enum CellNames: String {
    case ProductChoiceCell = "ProductChoiceCell"
}

class ProductChoiceViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var productTableView: UITableView!
    
    var products: [Product]?
    
    override func viewDidLoad() {
        
        self.productTableView.delegate = self
        self.productTableView.dataSource = self
        
        self.productTableView.estimatedRowHeight = 134
    
        // allow user to tap next to keyboard and make it dissappear
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.hideKeyboardByTappingOutside))
        
        self.view.addGestureRecognizer(tap)
    }
    
    @objc func hideKeyboardByTappingOutside() {
        self.view.endEditing(true)
    }
    
    // MARK: TableView Delegate methods
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 134
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.products?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let defaultCell = UITableViewCell(style: .default, reuseIdentifier: CellNames.ProductChoiceCell.rawValue)
        guard let productCell = tableView.dequeueReusableCell(withIdentifier: CellNames.ProductChoiceCell.rawValue, for: indexPath) as? ProductChoiceCustomTableViewCell else {
            return defaultCell
        }
        
        // configure cell
        productCell.selectionStyle = .none
        productCell.configureCell(tag: indexPath.row)
        
        productCell.addToBasketBtnCompletion = { res in
            
        }
        
        // finally assign the product
        productCell.product = self.products![indexPath.row]
        
        return productCell
    }
}
