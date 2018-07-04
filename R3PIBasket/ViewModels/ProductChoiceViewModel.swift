//
//  ProductChoiceViewModel.swift
//  R3PIBasket
//
//  Created by Stephan Korner on 04.07.18.
//  Copyright © 2018 Ideen Kaffee Korner. All rights reserved.
//

import Foundation

class ProductChoiceViewModel {
    
    var conversionFactor: Float?
    var nrOfItems: Int?
    var products: [Product]?
    var basket: Basket?
    
    var newCurrencyFetcher = NewCurrencyFetcher()
    
    func setCurrencyForAllProducts() {
        // set currency for all products
        if let products = self.products {
            for (idx, _) in products.enumerated() {
                self.products?[idx].productCurrency = self.basket?.basketCurrency ?? .USD
            }
        }
    }
    
    // MARK: Helper functions
    func setNewAmountForProduct(tag: Int, amount: Int) {
        self.products?[tag].nrOfProducts = amount
    }
    
    func setNewAmountInBasket(productName: ProductName?, amount: Int) {
        if let prodName = productName {
            self.basket?.productAmounts![prodName] = amount
        }
    }
    
    func updateAmountsAndNumberOfItems(tag: Int, productName: ProductName, amount: Int) {
        
        if amount > 0 {
            // if basket does not contain product-Item, add it
            if let items = self.basket?.itemsTypes,
                let name = self.products?[tag].productName {
                if !items.contains(name) {
                    self.basket?.itemsTypes?.append(name)
                    let amount = self.products?[tag].nrOfProducts
                    self.basket?.productAmounts?[name] = amount ?? 0
                }
            }
            self.nrOfItems = self.basket?.itemsTypes?.count
            self.setNewAmountForProduct(tag: tag, amount: amount)
            self.setNewAmountInBasket(productName: productName, amount: amount)
        }
    }
    
    // MARK: Network calls
    
    func getNewestConversionFactor() {
        
        let currency = self.basket?.basketCurrency ?? .USD
        self.newCurrencyFetcher.getNewestConversionFactor(currency: currency) { (conversionFactor, error) in
            
            // check for error
            guard error == nil else {
                // set currency to USD since error happened
                self.basket?.basketCurrency = .USD
                self.setCurrencyForAllProducts()
                self.conversionFactor = 1
                return
            }
            // if successful:
            // assign the API-result's currency-conversion-factor
            self.conversionFactor = conversionFactor
            NotificationCenter.default.post(name: .TableViewReloadNotif, object: nil)
        }
    }
    
    // MARK: Delegate-callback methods
    
    func signalProductUpdate() {
        
        // update products
        if let _ = self.basket?.itemsTypes,
            let products = self.products,
            let amounts = self.basket?.productAmounts {
            for (prodIdx, prod) in products.enumerated() {
                for (key, value) in amounts {  // amounts is of type [ProductName: Int]
                    if key == prod.productName {
                        self.products![prodIdx].nrOfProducts = value
                    }
                }
            }
        }
        // update Item counter in Basket
        self.nrOfItems = self.basket?.itemsTypes?.count
        self.setCurrencyForAllProducts()
        self.getNewestConversionFactor()
    }
}

