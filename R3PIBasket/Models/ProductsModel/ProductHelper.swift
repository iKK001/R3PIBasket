//
//  ProductHelper.swift
//  R3PIBasket
//
//  Created by Stephan Korner on 04.07.18.
//  Copyright © 2018 Ideen Kaffee Korner. All rights reserved.
//

import Foundation

class ProductHelper {
    
    func generateProductsFromBasketInUSD(basket: Basket?) -> [Product] {
        
        var returnBasketProducts: [Product] = [Product]()
        
        if let itemTypes = basket?.itemsTypes {
            for (idx, item) in itemTypes.enumerated() {
                let prodFactory = ProductFactory(prodName: item)
                let anyProd = prodFactory.product
                var anyProduct = anyProd
                returnBasketProducts.append(anyProduct)
                if let productName = basket?.itemsTypes?[idx] {
                    let unitPrice = (ProductUnitPriceInUSD.getUnitPriceInUSD(prodName: productName) ?? 0.0)
                    let nrOfProducts = basket?.productAmounts?[productName] ?? 0
                    anyProduct.productPrice = Float(nrOfProducts) * unitPrice
                    anyProduct.nrOfProducts = nrOfProducts
                    returnBasketProducts[idx] = anyProduct
                }
            }
        }
        return returnBasketProducts
    }
    
    // cosmetics-helper function, that...
    // - returns a tuple of products and basket
    // - the returnProd does not contain any zero-amount items
    // - the returnBasket deos not contain any zero-amount items
    // (the method is needed to clean up before dependency injection to next ViewController)
    func cleanZeros(products: [Product]?, basket: Basket?) -> ([Product]?, Basket?) {
        
        var returnProd = products
        if let products = products {
            for (idx, product) in products.enumerated() {
                if product.nrOfProducts == 0 {
                    returnProd?.remove(at: idx)
                }
            }
        }
        
        var returnBasket = basket
        if let items = basket?.itemsTypes {
            for (idx, item) in items.enumerated() {
                if let amount = basket?.productAmounts?[item] {
                    if amount == 0 {
                        returnBasket?.itemsTypes?.remove(at: idx)
                        returnBasket?.productAmounts?.removeValue(forKey: item)
                    }
                }
            }
        }
        return (returnProd!, returnBasket!)
    }
}
