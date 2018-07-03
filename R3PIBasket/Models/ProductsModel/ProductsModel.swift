//
//  ProductsChoiceModel.swift
//  R3PIBasket
//
//  Created by Stephan Korner on 01.07.18.
//  Copyright © 2018 Ideen Kaffee Korner. All rights reserved.
//

import Foundation
import UIKit

protocol Product {
    var productName: ProductName { get set }
    var productImage: UIImage { get set }
    var productCurrency: Currency { get set }
    var productPrice: Float { get set }
    var unitDescriptionLabel: ProductUnitDescription { get set }
    var nrOfProducts: Int { get set }
}

enum ProductName: String, EnumCollection {
    case Peas = "Peas"
    case Eggs = "Eggs"
    case Milk = "Milk"
    case Beans = "Beans"
}

enum ProductUnitPriceInUSD: Float, EnumCollection {
    case Peas = 0.95
    case Eggs = 2.10
    case Milk = 1.30
    case Beans = 0.73
    
    static func getUnitPriceInUSD(productName: ProductName?) -> Float? {
        if let productN = productName {
            switch productN {
            case .Peas:
                return ProductUnitPriceInUSD.Peas.rawValue
            case .Eggs:
                return ProductUnitPriceInUSD.Eggs.rawValue
            case .Milk:
                return ProductUnitPriceInUSD.Milk.rawValue
            case .Beans:
                return ProductUnitPriceInUSD.Beans.rawValue
            }
        }
        return nil
    }
}

enum ProductUnitDescription: String {
    case perBag = "per bag"
    case perDozen = "per dozen"
    case perBottle = "per bottle"
    case perCan = "per can"
    
    func description() -> String {
        switch self {
        case .perBag:
            return "bags"
        case .perDozen:
            return "dozens"
        case .perBottle:
            return "bottles"
        case .perCan:
            return "cans"
        }
    }
}

struct GenericProduct {
    
    static func createProduct(productName: ProductName?) -> Product? {
        if let productN = productName {
            switch productN {
            case .Peas:
                return PeasProduct()
            case .Eggs:
                return EggsProduct()
            case .Milk:
                return MilkProduct()
            case .Beans:
                return BeansProduct()
            }
        }
        return nil
    }
}

struct PeasProduct: Product {
    var productName: ProductName = ProductName.Peas
    var productImage: UIImage = #imageLiteral(resourceName: "Peas")
    var productCurrency: Currency = .USD
    var productPrice: Float = ProductUnitPriceInUSD.Peas.rawValue
    var unitDescriptionLabel: ProductUnitDescription = .perBag
    var nrOfProducts: Int = 0
}

struct EggsProduct: Product {
    var productName: ProductName = ProductName.Eggs
    var productImage: UIImage = #imageLiteral(resourceName: "Eggs")
    var productCurrency: Currency = .USD
    var productPrice: Float = ProductUnitPriceInUSD.Eggs.rawValue
    var unitDescriptionLabel: ProductUnitDescription = .perDozen
    var nrOfProducts: Int = 0
}

struct MilkProduct: Product {
    var productName: ProductName = ProductName.Milk
    var productImage: UIImage = #imageLiteral(resourceName: "Milk")
    var productCurrency: Currency = .USD
    var productPrice: Float = ProductUnitPriceInUSD.Milk.rawValue
    var unitDescriptionLabel: ProductUnitDescription = .perBottle
    var nrOfProducts: Int = 0
}

struct BeansProduct: Product {
    var productName: ProductName = ProductName.Beans
    var productImage: UIImage = #imageLiteral(resourceName: "Beans")
    var productCurrency: Currency = .USD
    var productPrice: Float = ProductUnitPriceInUSD.Beans.rawValue
    var unitDescriptionLabel: ProductUnitDescription = .perCan
    var nrOfProducts: Int = 0
}
