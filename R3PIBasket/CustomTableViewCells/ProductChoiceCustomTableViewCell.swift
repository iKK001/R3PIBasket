//
//  ProductChoiceCustomTableViewCell.swift
//  R3PIBasket
//
//  Created by Stephan Korner on 01.07.18.
//  Copyright © 2018 Ideen Kaffee Korner. All rights reserved.
//

import Foundation
import UIKit

class ProductChoiceCustomTableViewCell: UITableViewCell, UITextFieldDelegate {

    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var productCurrency: UILabel!
    @IBOutlet weak var productPrice: UILabel!
    @IBOutlet weak var unitDescriptionLabel: UILabel!
    @IBOutlet weak var nrOfProductsTextField: UITextField!
    
    var addToBasketBtnCompletion : ((Int?) -> Void)? = nil
    
    var product: Product! {
        didSet {
            self.productName.text = product.productName
            self.productImage.image = product.productImage
            self.productCurrency.text = product.productCurrency.rawValue
            self.productPrice.text = String(format: "%.2f", product.productPrice)
            self.unitDescriptionLabel.text = product.unitDescriptionLabel.rawValue
        }
    }
    
    func configureCell(tag: Int) {
        self.tag = tag
        
        self.nrOfProductsTextField.keyboardType = .numbersAndPunctuation
        self.nrOfProductsTextField.delegate = self
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        // limit to Integers only
        let text = (textField.text as NSString?)?.replacingCharacters(in: range, with: string)
        if text == "" {
            return true
        } else if let txt = text,
            let _ = Int(txt) {
            return true
        } else {
            return false
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    @IBAction func deleteBtnPressed(_ sender: Any) {
        self.nrOfProductsTextField.text = "\(0)"
    }
    
    @IBAction func addToBasketBtnPressed(_ sender: Any) {
        // execute the addToBasket-completion closure
        if let addToBasketBtnAction = self.addToBasketBtnCompletion {
            addToBasketBtnAction(Int(self.nrOfProductsTextField.text ?? "0"))
        }
    }
}
