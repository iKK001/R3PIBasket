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
    @IBOutlet weak var greenIsInBasketView: UIView!
    
    var addToBasketBtnCompletion : ((Int) -> Void)? = nil
    var deleteItemBtnCompletion : ((Int) -> Void)? = nil
    
    var product: Product! {
        didSet {
            self.productName.text = self.product.productName
            self.productImage.image = self.product.productImage
            self.productCurrency.text = self.product.productCurrency.rawValue
            self.productPrice.text = iKKHelperClass.setPriceText(price: self.product.productPrice)
            self.unitDescriptionLabel.text = self.product.unitDescriptionLabel ?? ""
            self.nrOfProductsTextField.text = "\(self.product.nrOfProducts)"
        }
    }
    
    func configureCell(tag: Int) {
        self.greenIsInBasketView.isHidden = true
        self.tag = tag
        self.nrOfProductsTextField.keyboardType = .numbersAndPunctuation
        self.nrOfProductsTextField.autocorrectionType = .no
        self.nrOfProductsTextField.delegate = self
    }
    
    func calculateConversion(conversionFactor: Float?) {
        if let conversionF = conversionFactor {
            let USDprice: Float = self.product.productPrice ?? 0.0
            let newPrice: Float = USDprice * conversionF
            self.productPrice.text = iKKHelperClass.setPriceText(price: newPrice)
        } else {
            self.productPrice.text = iKKHelperClass.setPriceText(price: self.product.productPrice)
        }
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField.text == "0" {
            textField.text = ""
        }
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
        
        // execute the addToBasket-completion closure
        if let deleteItemAction = self.deleteItemBtnCompletion {
            deleteItemAction(self.tag)
        }
    }
    
    @IBAction func addToBasketBtnPressed(_ sender: Any) {
        
        if let nrOfItems = Int(self.nrOfProductsTextField.text ?? "0") {
            if nrOfItems > 0 { self.greenIsInBasketView.isHidden = false }
        }

        // execute the addToBasket-completion closure
        if let addToBasketBtnAction = self.addToBasketBtnCompletion {
            addToBasketBtnAction(self.tag)
        }
    }
}
