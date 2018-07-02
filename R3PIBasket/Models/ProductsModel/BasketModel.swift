//
//  BasketModel.swift
//  R3PIBasket
//
//  Created by Stephan Korner on 02.07.18.
//  Copyright © 2018 Ideen Kaffee Korner. All rights reserved.
//

import Foundation

protocol BasketItem {
    var itemsTypes: [ProductNames]? { get set }
    var basketCurrency: Currency { get set }
}

extension BasketItem {
    var itemsTypes: [ProductNames]? {
        return [ProductNames]()
    }
    var basketCurrency: Currency {
        return .USD
    }
}

struct Basket: BasketItem {
    var itemsTypes: [ProductNames]?
    var basketCurrency: Currency
}
