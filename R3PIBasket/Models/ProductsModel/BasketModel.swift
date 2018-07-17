//
//  BasketModel.swift
//  R3PIBasket
//
//  Created by Stephan Korner on 02.07.18.
//  Copyright © 2018 Ideen Kaffee Korner. All rights reserved.
//

import Foundation

protocol BasketItem {
    var itemsTypes: [String]? { get set }
    var productAmounts: [String: Int]? { get set }
    var basketCurrency: Currency { get set }
}

extension BasketItem {
    var itemsTypes: [String]? {
        return [String]()
    }
    var productAmounts: [String: Int]? {
        return [String:Int]()
    }
    var basketCurrency: Currency {
        return .USD
    }
}

struct Basket: BasketItem {
    
    fileprivate let defaults = UserDefaults(suiteName: AppConstants.USERDEFAULTS.USER_DEFAULT_SUITE_NAME)!
    
    var itemsTypes: [String]? {
        get {
            // persistency-GET
            let itemTypeStrArr = self.defaults.object(forKey: AppConstants.USERDEFAULTS.USER_DEFAULT_BASKET_ITEM_TYPES) as? [String]
            return itemTypeStrArr
        }
        set {
            // persistency-SET
            self.defaults.set(newValue, forKey: AppConstants.USERDEFAULTS.USER_DEFAULT_BASKET_ITEM_TYPES)
            self.defaults.synchronize()
        }
    }
    
    var productAmounts: [String: Int]? {
        get {
            // persistency-GET
            let productAmountDict = self.defaults.object(forKey: AppConstants.USERDEFAULTS.USER_DEFAULT_BASKET_PRODUCT_AMOUNT_KEY) as? [String: Int]
            return productAmountDict
        }
        set {
            // persistency-SET
            self.defaults.set(newValue, forKey: AppConstants.USERDEFAULTS.USER_DEFAULT_BASKET_PRODUCT_AMOUNT_KEY)
            self.defaults.synchronize()
        }
    }
    var basketCurrency: Currency {
        get {
            // persistency-GET
            // since only STRING's can be restored - some sort of wrapper is needed
            let _currency: Currency = Currency(rawValue: self.defaults.object(forKey: AppConstants.USERDEFAULTS.USER_DEFAULT_CURRENCY_CHOICE) as? String ?? AppConstants.DefaultValues.USD_Currency)!
            return _currency
        }
        set {
            // persistency-SET
            // since only STRING's can be stored - some sort of wrapper is needed
            let _currency: String = newValue.rawValue
            self.defaults.set(_currency, forKey: AppConstants.USERDEFAULTS.USER_DEFAULT_CURRENCY_CHOICE)
            
            self.defaults.synchronize()
        }
    }
    
    mutating func removeBasketItem(withName: String) {
        var indexToRemove: Int = -1
        var nameToRemove: String = ""
        let products = ProductNames()
        if let itemTs = self.itemsTypes {
            for (idx, name) in itemTs.enumerated() {
                if name == withName {
                    indexToRemove = idx
                    nameToRemove = products.getProductName(idx: idx)
                    break
                }
            }
        }
        if indexToRemove != -1 {
            self.itemsTypes?.remove(at: indexToRemove)
            self.productAmounts?.removeValue(forKey: nameToRemove)
        }
    }
}
