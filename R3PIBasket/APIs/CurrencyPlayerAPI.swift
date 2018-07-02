//
//  CurrencyPlayerAPI.swift
//  R3PIBasket
//
//  Created by Stephan Korner on 29.06.18.
//  Copyright © 2017 Ideen Kaffee Korner. All rights reserved.
//

import Foundation

class CurrencyPlayerAPI {
    
    func getCurrencyConversionResults(inputTerms: [String:String], completionHandler: ((CurrencyModelResult?, Error?) -> Void)?) {
        
        // fetch Connection from OpenData API (given inputTerms)
        let currencyFetcher = CurrencyPlayerFetcher()
        
        currencyFetcher.fetchCurrency(inputTerms: inputTerms) { (myCurrency, error) in
            
            // check for error
            guard error == nil else {
                completionHandler?(nil, error!)
                return
            }
            
            if let currency = myCurrency {
                completionHandler?(currency, nil)
            } else {
                let error = JSONFetchError.objectSerialization(reason: "no results from server")
                completionHandler?(nil, error)
            }
        }
    }
}

