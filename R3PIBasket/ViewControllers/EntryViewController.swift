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

    fileprivate let defaults = UserDefaults(suiteName: AppConstants.USERDEFAULTS.USER_DEFAULT_SUITE_NAME)!
    
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
    }
    
    func setLookAndFeel() {
    self.currencyChoiceButtonOutlet.setTitle(self.currencyChoice.rawValue + " >", for: .normal)
        self.startButtonOutlet.cornerRadius = self.startButtonOutlet.bounds.width / 2
    }
    
    // MARK: Segue method
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        switch segue.identifier! {
        case SegueNames.GoToCurrencyChoice.rawValue:
            let currencySearchVC = segue.destination as! CurrenyChoiceTableViewController
            currencySearchVC.title = "Currency Choice"
            currencySearchVC.delegate = self
            currencySearchVC.currentTag = 0
        case SegueNames.GoToProductsChoice.rawValue:
            let productsChoiceVC = segue.destination as! ProductChoiceViewController
            productsChoiceVC.title = "Product Choice"
            // inject initial data to productsChoice-VC's objects
            productsChoiceVC.products = [Product]()
            productsChoiceVC.products?.append(PeasProduct())
            productsChoiceVC.products?.append(EggsProduct())
            productsChoiceVC.products?.append(MilkProduct())
            productsChoiceVC.products?.append(BeansProduct())
            // start with virgin-basket
            productsChoiceVC.basket = Basket()
            productsChoiceVC.basket?.itemsTypes = [ProductName]()
            productsChoiceVC.basket?.productAmounts = [ProductName:Int]()
            productsChoiceVC.basket?.basketCurrency = self.currencyChoice
        default:
            break
        }
    }
    
    // MARK: Target-Actions
    @IBAction func currencyChoiceButtonPressed(_ sender: Any) {
        self.performSegue(withIdentifier: SegueNames.GoToCurrencyChoice.rawValue, sender: nil)
    }
    
    @IBAction func startButtonPressed(_ sender: Any) {
    }
    
    // MARK: Back Delegates
    func setBackDataNow(currency: Currency) {
        self.currencyChoice = currency
        self.currencyChoiceButtonOutlet.setTitle(currency.rawValue + " >", for: .normal)
    }
}

