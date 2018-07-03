//
//  SummaryCustomTableViewCell.swift
//  R3PIBasket
//
//  Created by Stephan Korner on 01.07.18.
//  Copyright © 2018 Ideen Kaffee Korner. All rights reserved.
//

import Foundation
import UIKit

class SummaryCustomTableViewCell: UITableViewCell {

    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var productCurrency1: UILabel!
    @IBOutlet weak var productCurrency2: UILabel!
    @IBOutlet weak var unitPrice: UILabel!
    @IBOutlet weak var productPrice: UILabel!
    @IBOutlet weak var unitDescriptionLabel: UILabel!
    @IBOutlet weak var nrOfProductsLabel: UILabel!
    
    var product: Product! {
        didSet {
            self.productName.text = self.product.productName.rawValue
            self.productImage.image = self.product.productImage
            self.productCurrency1.text = self.product.productCurrency.rawValue
            self.productCurrency2.text = self.product.productCurrency.rawValue
            self.unitPrice.text = String(format: "%.2f", ProductUnitPriceInUSD.getUnitPriceInUSD(productName: self.product.productName) ?? "0.00")
            self.productPrice.text = String(format: "%.2f", self.product.productPrice)
            self.unitDescriptionLabel.text = self.product.unitDescriptionLabel.description()
            self.nrOfProductsLabel.text = "\(self.product.nrOfProducts)"
        }
    }
    
    func configureCell(tag: Int) {
        self.tag = tag
    }
    
    func calculateConversion(conversionFactor: Float?) {
        if let conversionF = conversionFactor {
            let USDprice: Float = self.product.productPrice
            let newPrice: Float = USDprice * conversionF
            self.productPrice.text = String(format: "%.2f", newPrice)
        } else {
            self.productPrice.text = String(format: "%.2f", self.product.productPrice)
        }
    }
}
