//
//  SummaryViewModel.swift
//  R3PIBasket
//
//  Created by Stephan Korner on 04.07.18.
//  Copyright © 2018 Ideen Kaffee Korner. All rights reserved.
//

import Foundation

class SummaryViewModel {
    
    var conversionFactor: Float?
    var basketProducts: [Product]?
    var basket: Basket?
    
    var newCurrencyFetcher = NewCurrencyFetcher()
    
    // MARK: Helper functions
    
    func setCurrencyForAllProducts() {
        // set currency for all products
        if let products = self.basketProducts {
            for (idx, _) in products.enumerated() {
                self.basketProducts?[idx].productCurrency = self.basket?.basketCurrency ?? .USD
            }
        }
    }
    
    func calculatePurchaseSummary() -> Float {
        var total: Float = 0.0
        if let products = self.basketProducts {
            for (_, product) in products.enumerated() {
                total = total + (product.productPrice ?? 0.0) *  (self.conversionFactor ?? 1.0)
            }
        }
        return total
    }
    
    // cosmetics-helper function
    func cleanZeros() -> ([Product]?, Basket?) {
        
        let productHelper = ProductHelper()
        let (products, basket) = productHelper.cleanZeros(products: self.basketProducts, basket: self.basket)
        self.basketProducts = products
        self.basket = basket
        return (products, basket)
    }
    
    // MARK: Network-calls
    
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
}
