//
//  EntryViewController.swift
//  R3PIBasket
//
//  Created by Stephan Korner on 29.06.18.
//  Copyright © 2018 Ideen Kaffee Korner. All rights reserved.
//

import UIKit

class EntryViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let currencyAPI = CurrencyPlayerAPI()
        
        let access_key = AppConstants.APIKeys.CURRENCY_PLAYER_API_KEY
        let source = "USD"
        let currencies = "CHF,EUR"
        let format = "1"
        
        let inputTerms: [String:String] = [
            CurrenyPlayerAPIAttributes.access_key.rawValue:access_key,
            CurrenyPlayerAPIAttributes.source.rawValue:source,
            CurrenyPlayerAPIAttributes.currencies.rawValue:currencies,
            CurrenyPlayerAPIAttributes.format.rawValue:format
        ]
        currencyAPI.getCurrencyConversionResults(inputTerms: inputTerms) { (currencyResult, error) in
            
            // check for error
            guard error == nil else {
                // inform user that the network-fetch was not successful
                let alertController = UIAlertController(title: "Currency Conversion Error!", message: "The Network-provider was not able to deliver the required Currency-Information.\r\n\r\nPlease try again later...", preferredStyle: UIAlertControllerStyle.alert)
                alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default,handler: nil))
                self.present(alertController, animated: true, completion: nil)
                return
            }
            // if successful
            print(currencyResult)
        }

    }
}

