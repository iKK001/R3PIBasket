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
    
    fileprivate let defaults = UserDefaults(suiteName: AppConstants.USERDEFAULTS.USER_DEFAULT_SUITE_NAME)!
    
    var itemsTypes: [ProductName]? {
        get {
            // persistency-GET
            // since only STRING-arrays can be restored - some sort of wrapper is needed
            var _itemsTypes: [ProductName]? = [ProductName]()
            let _itemTypeStrArr = self.defaults.object(forKey: AppConstants.USERDEFAULTS.USER_DEFAULT_BASKET_ITEM_TYPES) as? [String] ?? [""]
            _itemsTypes?.removeAll()
            for (_, itemT) in _itemTypeStrArr.enumerated()  {
                if let item = ProductName(rawValue: itemT) {
                    _itemsTypes?.append(item)
                }
            }
            return _itemsTypes
        }
        set {
            // persistency-SET
            // since only STRING-arrays can be stored - some sort of wrapper is needed
            var _itemsTypeStrArr: [String] = [String]()
            _itemsTypeStrArr.removeAll()
            if let items = newValue {
                for item in items {
                    _itemsTypeStrArr.append(item.rawValue)
                }
            }
            self.defaults.set(_itemsTypeStrArr, forKey: AppConstants.USERDEFAULTS.USER_DEFAULT_BASKET_ITEM_TYPES)
            
            self.defaults.synchronize()
        }
    }
    
    var productAmounts: [ProductName: Int]? {
        get {
            // persistency-GET
            // since only INT-arrays and STRING-arrays can be restored - some sort of wrapper is needed
            var _productAmounts: [ProductName: Int] = [ProductName: Int]()
            let productAmountIntArr = self.defaults.object(forKey: AppConstants.USERDEFAULTS.USER_DEFAULT_BASKET_PRODUCT_AMOUNT) as? [Int] ?? [0]
            let productAmountKeyArr = self.defaults.object(forKey: AppConstants.USERDEFAULTS.USER_DEFAULT_BASKET_PRODUCT_AMOUNT_KEY) as? [String] ?? [""]
            _productAmounts.removeAll()
            for (idx, _) in productAmountIntArr.enumerated()  {
                if productAmountKeyArr.count > idx {
                    if let prodN = ProductName(rawValue: productAmountKeyArr[idx]) {
                        _productAmounts[prodN] = productAmountIntArr[idx]
                    }
                }
            }
            return _productAmounts
        }
        set {
            // persistency-SET
            // since only INT-arrays and STRING-arrays can be stored - some sort of wrapper is needed
            var _productAmounts: [Int] = [0]
            var _productAmountKeys: [String] = [""]
            _productAmounts.removeAll()
            _productAmountKeys.removeAll()
            if let items = self.itemsTypes {  // !!!!
                for item in items {
                    _productAmounts.append(newValue![item] ?? 0)
                    _productAmountKeys.append(item.rawValue)
                }
            }
            self.defaults.set(_productAmounts, forKey: AppConstants.USERDEFAULTS.USER_DEFAULT_BASKET_PRODUCT_AMOUNT)
            self.defaults.set(_productAmountKeys, forKey: AppConstants.USERDEFAULTS.USER_DEFAULT_BASKET_PRODUCT_AMOUNT_KEY)
            
            self.defaults.synchronize()
        }
    }
    var basketCurrency: Currency {
        get {
            // persistency-GET
            // since only STRING's can be restored - some sort of wrapper is needed
            let _currency: Currency = Currency(rawValue: self.defaults.object(forKey: AppConstants.USERDEFAULTS.USER_DEFAULT_CURRENCY_CHOICE) as? String ?? "USD")!
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
    
    mutating func removeBasketItem(withName: ProductName) {
        var indexToRemove: Int = -1
        var nameToRemove: ProductName? = nil
        if let itemTs = self.itemsTypes {
            for (idx, name) in itemTs.enumerated() {
                if name == withName {
                    indexToRemove = idx
                    nameToRemove = name
                    break
                }
            }
        }
        if indexToRemove != -1 {
            if let ntr = nameToRemove {
                self.itemsTypes?.remove(at: indexToRemove)
                self.productAmounts?.removeValue(forKey: ntr)
            }
        }
    }
}
