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
                if let anyProd = GenericProduct.createProduct(productName: item) {
                    var anyProduct = anyProd
                    returnBasketProducts.append(anyProduct)
                    if let productName = basket?.itemsTypes?[idx] {
                        let unitPrice = (ProductUnitPriceInUSD.getUnitPriceInUSD(productName: productName) ?? 1.0)
                        let nrOfProducts = (basket?.productAmounts?[productName])!
                        anyProduct.productPrice = Float(nrOfProducts) * unitPrice
                        anyProduct.nrOfProducts = nrOfProducts
                        returnBasketProducts[idx] = anyProduct
                    }
                }
            }
        }
        return returnBasketProducts
    }
}
