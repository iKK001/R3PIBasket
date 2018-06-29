//
//  EntryViewController.swift
//  R3PIBasket
//
//  Created by Stephan Korner on 29.06.18.
//  Copyright © 2018 Ideen Kaffee Korner. All rights reserved.
//

import Foundation
import UIKit

class EntryViewController: UIViewController, CurrencyDelegate {

    fileprivate let defaults = UserDefaults(suiteName: "ch.ideenkaffee.UserDefaults")!
    
    @IBOutlet weak var startButtonOutlet: UIButton_iKK!
    @IBOutlet weak var currencyChoiceButtonOutlet: UIButton!
    
    var currencyChoice: Currency {
        get { return Currency(rawValue: self.defaults.object(forKey: AppConstants.USERDEFAULTS.USER_DEFAULT_CURRENCY_CHOICE) as? String ?? "USD")! }
        set {
            self.defaults.set(newValue.rawValue, forKey: AppConstants.USERDEFAULTS.USER_DEFAULT_CURRENCY_CHOICE)
            self.defaults.synchronize()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setLookAndFeel()
        
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
    
    func setLookAndFeel() {
    self.currencyChoiceButtonOutlet.setTitle(self.currencyChoice.rawValue + " >", for: .normal)
        self.startButtonOutlet.cornerRadius = self.startButtonOutlet.bounds.width / 2
    }
    
    // MARK: Segue method
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        switch segue.identifier! {
        case "goToCurrencyChoice":
            let currencySearchVC = segue.destination as! CurrenyChoiceTableViewController
            
            currencySearchVC.delegate = self
            currencySearchVC.currentTag = 0
            currencySearchVC.title = "Currency Choice"
        default:
            break
        }
    }
    
    // MARK: Target-Actions
    @IBAction func currencyChoiceButtonPressed(_ sender: Any) {
        self.performSegue(withIdentifier: "goToCurrencyChoice", sender: nil)
    }
    
    @IBAction func startButtonPressed(_ sender: Any) {
    }
    
    // MARK: Back Delegates
    func setBackDataNow(currency: Currency) {
        self.currencyChoice = currency
        self.currencyChoiceButtonOutlet.setTitle(currency.rawValue + " >", for: .normal)
    }
}

