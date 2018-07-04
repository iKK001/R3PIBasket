//
//  NewCurrencyFetcher.swift
//  R3PIBasket
//
//  Created by Stephan Korner on 04.07.18.
//  Copyright © 2018 Ideen Kaffee Korner. All rights reserved.
//

import Foundation

class NewCurrencyFetcher {
    
    func getNewestConversionFactor(currency: Currency, completionHandler: ((Float?, Error?) -> Void)?) {
        
        if iKKHelperClass.checkWiFi() {
            
            // make a network-call to get most up-to-date Currency conversion
            // ..do this in the background not to bother the UI..
            let workItem_BG_CurrencyFetch = DispatchWorkItem {
                let currencyAPI = CurrencyPlayerAPI()
                currencyAPI.getConversionFactor(currency: currency) { (conversionFactor, error) in
                    
                    // check for error
                    guard error == nil else {
                        
                        var alertText = [String:String]()
                        alertText["title"] = "Currency Conversion Error!"
                        alertText["message"] = "The Network-provider was not able to deliver the required Currency-Information.\r\n\r\nPlease try again later..."
                        NotificationCenter.default.post(name: .AlertNotif, object: alertText)
                        let error = CurrencyConversionError.conversionError(reason: "Could not convert currency")
                        completionHandler?(nil, error)
                        return
                    }
                    completionHandler?(conversionFactor, nil)
                }
            }
            // then call the new workItem to be carried out in a concurrent BG-thread
            DispatchQueue.global(qos:.userInteractive).async(execute: workItem_BG_CurrencyFetch)
        } else {
            DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(300)) {
                if currency != .USD {
                    var alertText = [String:String]()
                    alertText["title"] = "No inernet !"
                    alertText["message"] = "You must be online in order to get newest product currency information."
                    NotificationCenter.default.post(name: .AlertNotif, object: alertText)
                }
                NotificationCenter.default.post(name: .TableViewReloadNotif, object: nil)
            }
            let error = CurrencyConversionError.conversionError(reason: "Could not convert currency")
            completionHandler?(nil, error)
        }
    }
}
