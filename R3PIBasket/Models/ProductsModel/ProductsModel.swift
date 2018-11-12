//
//  ProductsChoiceModel.swift
//  R3PIBasket
//
//  Created by Stephan Korner on 01.07.18.
//  Copyright © 2018 Ideen Kaffee Korner. All rights reserved.
//

import Foundation
import UIKit

protocol Productable {
    var productName: String { get set }
    var productImage: UIImage? { get set }
    var productCurrency: Currency { get set }
    var productPrice: Float? { get set }
    var unitDescriptionLabel: String? { get set }
    var nrOfProducts: Int { get set }
}

struct ProductNames {
    
    var products: [String] = [
        "Peas",
        "Eggs",
        "Milk",
        "Beans",
        "Ham",
        "Thon"
    ]
    
    func getProductName(idx: Int) -> String {
        return self.products[idx]
    }
}

struct ProductUnitPriceInUSD {
    
    static var prices: [String: Float] = [
        "Peas": 0.95,
        "Eggs": 2.10,
        "Milk": 1.30,
        "Beans": 0.73,
        "Ham": 3.20,
        "Thon": 0.80
    ]
    
    static func getUnitPriceInUSD(prodName: String) -> Float? {
        
        if ProductUnitPriceInUSD.prices[prodName] != nil {
            return ProductUnitPriceInUSD.prices[prodName]
        } else {
            return nil
        }
    }
}


struct ProductUnitDescription {
    
    static var description: [String: String] = [
        "Peas": "per bag",
        "Eggs": "per dozen",
        "Milk": "per bottle",
        "Beans": "per can",
        "Ham": "per piece",
        "Thon": "per box"
    ]
    
    static func getProductUnitDescription(prodName: String) -> String? {
        if ProductUnitDescription.description[prodName] != nil {
            return ProductUnitDescription.description[prodName]
        } else {
            return nil
        }
    }
    
    static func setProductUnitDescription(descrs: [String: String]) {
        for (key, value) in descrs {
            ProductUnitDescription.description[key] = value
        }
    }
}

struct Product: Productable {
    
    var productName: String
    var productImage: UIImage?
    var productCurrency: Currency
    var productPrice: Float?
    var unitDescriptionLabel: String?
    var nrOfProducts: Int
}

class ProductFactory {
    
    var product: Product
    
    init(prodName: String) {
        self.product = Product(productName: prodName, productImage: UIImage(named: prodName + ".png"), productCurrency: .USD, productPrice: ProductUnitPriceInUSD.getUnitPriceInUSD(prodName: prodName), unitDescriptionLabel: ProductUnitDescription.getProductUnitDescription(prodName: prodName), nrOfProducts: 0)
        
//        let productNames = ProductNames()
//        for prod in productNames.products.lazy {
//            if prod == prodName {
//                // overwrite name-dependent properties - if there...
//                // (the rest is by default from the Protocol-extension)
//                product.productName = prod
//                product.productImage = UIImage(named: prod + ".png")
//                product.productPrice = ProductUnitPriceInUSD.getUnitPriceInUSD(prodName: prod)
//                product.unitDescriptionLabel = ProductUnitDescription.getProductUnitDescription(prodName: prod)
//            }
//        }
    }
}
