//
//  BasketCustomTableViewCell.swift
//  R3PIBasket
//
//  Created by Stephan Korner on 01.07.18.
//  Copyright © 2018 Ideen Kaffee Korner. All rights reserved.
//

import Foundation
import UIKit

class BasketCustomTableViewCell: UITableViewCell, UITextFieldDelegate {

    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var productCurrency: UILabel!
    @IBOutlet weak var productPrice: UILabel!
    @IBOutlet weak var unitDescriptionLabel: UILabel!
    @IBOutlet weak var nrOfProductsTextField: UITextField!
    
    var removeFromBasketBtnCompletion : ((ProductName?) -> Void)? = nil
    var updateBasketCompletion : ((Int?) -> Void)? = nil
    var conversionFactor: Float?

    var product: Product! {
        didSet {
            self.productName.text = self.product.productName.rawValue
            self.productImage.image = self.product.productImage
            self.productCurrency.text = self.product.productCurrency.rawValue
            self.productPrice.text = String(format: "%.2f", self.product.productPrice)
            self.unitDescriptionLabel.text = self.product.unitDescriptionLabel.description()
            self.nrOfProductsTextField.text = "\(self.product.nrOfProducts)"
        }
    }
    
    func configureCell(tag: Int) {
        self.tag = tag
        self.nrOfProductsTextField.keyboardType = .numbersAndPunctuation
        self.nrOfProductsTextField.autocorrectionType = .no
        self.nrOfProductsTextField.delegate = self
    }
    
    func calculateConversion(conversionFactor: Float?) {
        self.conversionFactor = conversionFactor
        
        if let conversionF = conversionFactor {
            let prodN = self.product.productName
            let USDprice: Float = Float(self.product.nrOfProducts) * (ProductUnitPriceInUSD.getUnitPriceInUSD(productName: prodN) ?? 1.0)
            let newPrice: Float = USDprice * conversionF
            self.productPrice.text = String(format: "%.2f", newPrice)
        } else {
            self.productPrice.text = String(format: "%.2f", self.product.productPrice)
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
        // update productPrice
        self.product.nrOfProducts = Int(textField.text!) ?? 1
        self.calculateConversion(conversionFactor: self.conversionFactor)
        // execute the removeFromBasketCompletion closure
        if let updateBasketAction = self.updateBasketCompletion {
            updateBasketAction(Int(textField.text ?? ""))
        }
        return true
    }
    
    @IBAction func deleteBtnPressed(_ sender: Any) {
        self.nrOfProductsTextField.text = "\(0)"
        // update productPrice
        self.product.nrOfProducts = 0
        self.calculateConversion(conversionFactor: self.conversionFactor)
    }
    
    @IBAction func removeFromBasketBtnPressed(_ sender: Any) {
        // execute the removeFromBasketCompletion closure
        if let removeFromBasketBtnAction = self.removeFromBasketBtnCompletion {
            removeFromBasketBtnAction(ProductName(rawValue: self.productName.text ?? ""))
        }
    }
}
