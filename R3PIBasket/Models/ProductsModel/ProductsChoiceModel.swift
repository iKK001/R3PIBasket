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
    var productName: String { get set }
    var productImage: UIImage { get set }
    var productCurrency: Currency { get set }
    var productPrice: Float { get set }
    var unitDescriptionLabel: ProductUnitDescription { get set }
    var nrOfProducts: Int { get set }
}

enum ProductUnitDescription: String {
    case perBag = "per bag"
    case perDozen = "per dozen"
    case perBottle = "per bottle"
    case perCan = "per can"
}

struct PeasProduct: Product {
    var productName: String = "Peas"
    var productImage: UIImage = #imageLiteral(resourceName: "Peas")
    var productCurrency: Currency = .USD
    var productPrice: Float = 0.95
    var unitDescriptionLabel: ProductUnitDescription = .perBag
    var nrOfProducts: Int = 1
}

struct EggsProduct: Product {
    var productName: String = "Eggs"
    var productImage: UIImage = #imageLiteral(resourceName: "Eggs")
    var productCurrency: Currency = .USD
    var productPrice: Float = 2.10
    var unitDescriptionLabel: ProductUnitDescription = .perDozen
    var nrOfProducts: Int = 1
}

struct MilkProduct: Product {
    var productName: String = "Milk"
    var productImage: UIImage = #imageLiteral(resourceName: "Milk")
    var productCurrency: Currency = .USD
    var productPrice: Float = 1.30
    var unitDescriptionLabel: ProductUnitDescription = .perBottle
    var nrOfProducts: Int = 1
}

struct BeansProduct: Product {
    var productName: String = "Beans"
    var productImage: UIImage = #imageLiteral(resourceName: "Beans")
    var productCurrency: Currency = .USD
    var productPrice: Float = 0.73
    var unitDescriptionLabel: ProductUnitDescription = .perCan
    var nrOfProducts: Int = 1
}
