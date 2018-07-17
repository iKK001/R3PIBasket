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
    @IBOutlet weak var spacerLeftSpaceLowerConstraint: NSLayoutConstraint!
    
    var product: Product! {
        didSet {
            self.productName.text = self.product.productName
            self.productImage.image = self.product.productImage
            self.productCurrency1.text = self.product.productCurrency.rawValue
            self.productCurrency2.text = self.product.productCurrency.rawValue
            self.unitPrice.text = iKKHelperClass.setPriceText(price: ProductUnitPriceInUSD.getUnitPriceInUSD(prodName: self.product.productName))
            self.productPrice.text = iKKHelperClass.setPriceText(price: self.product.productPrice)
            self.unitDescriptionLabel.text = self.product.unitDescriptionLabel ?? ""
            self.nrOfProductsLabel.text = "\(self.product.nrOfProducts)"
        }
    }
    
    func configureCell(tag: Int) {
        self.tag = tag
        
        switch AppConstants.FEATUREFLAG.DEVICE_MODEL_NAME {
        case Devices.IPhone5, Devices.IPhone5S, Devices.IPhone5C:
            self.spacerLeftSpaceLowerConstraint.constant = 195
        case Devices.IPhone6, Devices.IPhone6S, Devices.IPhone7, Devices.IPhone8:
            self.spacerLeftSpaceLowerConstraint.constant = 200
        case Devices.IPhone6Plus, Devices.IPhone6SPlus, Devices.IPhone7Plus, Devices.IPhone8Plus:
            self.spacerLeftSpaceLowerConstraint.constant = 205
        case Devices.IPhoneX:
            self.spacerLeftSpaceLowerConstraint.constant = 205
        default:
            self.spacerLeftSpaceLowerConstraint.constant = 195
        }
    }
    
    func calculateConversion(conversionFactor: Float?) {
        if let conversionF = conversionFactor {
            let USDprice: Float = self.product.productPrice ?? 0.0
            let newPrice: Float = USDprice * conversionF
            self.productPrice.text = iKKHelperClass.setPriceText(price: newPrice)
            if let unitPriceNonConverted: Float = ProductUnitPriceInUSD.getUnitPriceInUSD(prodName: self.product.productName) {
                let unitPrice = unitPriceNonConverted * conversionF
                self.unitPrice.text = iKKHelperClass.setPriceText(price: unitPrice)
            } else {
                self.unitPrice.text = iKKHelperClass.setPriceText(price: nil)
            }
        } else {
            self.productPrice.text = iKKHelperClass.setPriceText(price: self.product.productPrice)
            self.unitPrice.text = iKKHelperClass.setPriceText(price: ProductUnitPriceInUSD.getUnitPriceInUSD(prodName: self.product.productName))
        }
    }
}
