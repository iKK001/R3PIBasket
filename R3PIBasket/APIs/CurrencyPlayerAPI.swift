//
//  CurrencyPlayerAPI.swift
//  R3PIBasket
//
//  Created by Stephan Korner on 29.06.18.
//  Copyright © 2017 Ideen Kaffee Korner. All rights reserved.
//

import Foundation

class CurrencyPlayerAPI {
    
    func getConversionFactor(currency: Currency, completionHandler: ((Float?, Error?) -> Void)?) {
    
        let access_key = AppConstants.APIKeys.CURRENCY_PLAYER_API_KEY
        let source = "USD"
        let currencies = currency.rawValue 
        let format = "1"
    
        let inputTerms: [String:String] = [
            CurrenyPlayerAPIAttributes.access_key.rawValue:access_key,
            CurrenyPlayerAPIAttributes.source.rawValue:source,
            CurrenyPlayerAPIAttributes.currencies.rawValue:currencies,
            CurrenyPlayerAPIAttributes.format.rawValue:format
        ]
        self.getCurrencyConversionResults(inputTerms: inputTerms) { (currencyResult, error) in
    
            // check for error
            guard error == nil else {
            completionHandler?(nil, error!)
            return
            }
            // if successful:
            // get currency-conversion-factor out of network-call-result
            // (there is only one non-nil quotes-entry since we only asked for one)
            let conversionFactor = currencyResult?.quotes?.getFirstNonNilValue()
            completionHandler?(conversionFactor, nil)
        }
    }
    
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

