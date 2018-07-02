//
//  BasketModel.swift
//  R3PIBasket
//
//  Created by Stephan Korner on 02.07.18.
//  Copyright © 2018 Ideen Kaffee Korner. All rights reserved.
//

import Foundation

protocol BasketItem {
    var itemsTypes: [ProductName]? { get set }
    var productAmounts: [ProductName: Int]? { get set }
    var basketCurrency: Currency { get set }
}

extension BasketItem {
    var itemsTypes: [ProductName]? {
        return [ProductName]()
    }
    var productAmounts: [ProductName: Int]? {
        return [ProductName:Int]()
    }
    var basketCurrency: Currency {
        return .USD
    }
}

struct Basket: BasketItem {
    var itemsTypes: [ProductName]?
    var productAmounts: [ProductName: Int]?
    var basketCurrency: Currency
    
    mutating func removeItem(withName: ProductName) {
        var indexToRemove: Int = -1
        if let itemTs = self.itemsTypes {
            for (idx, name) in itemTs.enumerated() {
                if name == withName {
                    indexToRemove = idx
                    break
                }
            }
        }
        if indexToRemove != -1 {
            self.itemsTypes?.remove(at: indexToRemove)
        }
    }
}
