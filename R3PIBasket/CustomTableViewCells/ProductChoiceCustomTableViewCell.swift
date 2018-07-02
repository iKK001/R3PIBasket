//
//  ProductChoiceCustomTableViewCell.swift
//  R3PIBasket
//
//  Created by Stephan Korner on 01.07.18.
//  Copyright © 2018 Ideen Kaffee Korner. All rights reserved.
//

import Foundation
import UIKit

class ProductChoiceCustomTableViewCell: UITableViewCell {

    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var productCurrency: UILabel!
    @IBOutlet weak var productPrice: UILabel!
    @IBOutlet weak var unitDescriptionLabel: UILabel!
    @IBOutlet weak var nrOfProductsTextField: UITextField!
    
    var deleteBtnCompletion : (() -> Void)? = nil
    var addToBasketBtnCompletion : ((Int?) -> Void)? = nil
    
    func configureCell(tag: Int, product: Product) {
        self.tag = tag
        self.productName.text = product.productName
        self.productImage.image = product.productImage
        self.productCurrency.text = product.productCurrency.rawValue
        self.productPrice.text = "\(product.productPrice)"
        self.unitDescriptionLabel.text = product.unitDescriptionLabel.rawValue
    }
    
    @IBAction func deleteBtnPressed(_ sender: Any) {
        // execute the deletion-completion closure
        if let deleteBtnAction = self.deleteBtnCompletion {
            deleteBtnAction()
        }
    }
    
    @IBAction func addToBasketBtnPressed(_ sender: Any) {
        // execute the addToBasket-completion closure
        if let addToBasketBtnAction = self.addToBasketBtnCompletion {
            addToBasketBtnAction(Int(self.nrOfProductsTextField.text ?? "0"))
        }
    }
}
