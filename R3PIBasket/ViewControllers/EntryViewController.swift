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
    @IBOutlet weak var startFromOldStateSwitchOutlet: UISwitch!
    @IBOutlet weak var ONLblOutlet: UILabel!
    @IBOutlet weak var versionOutlet: UILabel!
    
    var entryViewModel = EntryViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setLookAndFeel()
    }
    
    func setLookAndFeel() {
        
        if let buildString = Bundle.main.infoDictionary?["CFBundleVersion"] as? String {
            if let versionString = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String {
                let fullVersionString = "version v" + versionString + " (" + buildString + ")"
                versionOutlet.text = fullVersionString
            }
        }
   
        self.startFromOldStateSwitchOutlet.isOn ? (self.ONLblOutlet.isHidden = false) : (self.ONLblOutlet.isHidden = true)
    self.currencyChoiceButtonOutlet.setTitle(self.entryViewModel.currencyChoice.rawValue + " >", for: .normal)
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
            productsChoiceVC.prodVM.products = [Product]()
            
            let prodNames = ProductNames()
            for (_, prod) in prodNames.products.enumerated() {
                let prodProduced = ProductFactory(prodName: prod)
                productsChoiceVC.prodVM.products?.append(prodProduced.product)
            }

            // inject initial data to basket
            productsChoiceVC.prodVM.basket = Basket()
            productsChoiceVC.prodVM.basket?.basketCurrency = self.entryViewModel.currencyChoice
            // inject what you have from the basket into the new VC's products
            if let _ = productsChoiceVC.prodVM.basket?.itemsTypes,
                let products = productsChoiceVC.prodVM.products,
                let amounts = productsChoiceVC.prodVM.basket?.productAmounts {
                for (prodIdx, prod) in products.enumerated() {
                    for (key, value) in amounts {
                        if key == prod.productName {
                            productsChoiceVC.prodVM.products![prodIdx].nrOfProducts = value
                        }
                    }
                }
            }
            if !self.startFromOldStateSwitchOutlet.isOn {
                // if you want to start with virgin-basket, uncomment the following line of code....
                productsChoiceVC.prodVM.basket?.itemsTypes = [String]()
                productsChoiceVC.prodVM.basket?.productAmounts = [String:Int]()
            }

        default:
            break
        }
    }
    
    // MARK: Target-Actions
    @IBAction func currencyChoiceButtonPressed(_ sender: Any) {
        self.performSegue(withIdentifier: SegueNames.GoToCurrencyChoice.rawValue, sender: nil)
    }
    
    // MARK: Back Delegates
    func setBackDataNow(currency: Currency) {
        self.entryViewModel.currencyChoice = currency
        self.currencyChoiceButtonOutlet.setTitle(currency.rawValue + " >", for: .normal)
    }
    
    @IBAction func startFromOldStateSwitchChanged(_ sender: Any) {
        self.startFromOldStateSwitchOutlet.isOn ? (self.ONLblOutlet.isHidden = false) : (self.ONLblOutlet.isHidden = true)
    }
}

