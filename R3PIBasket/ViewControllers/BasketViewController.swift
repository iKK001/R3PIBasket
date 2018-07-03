//
//  BasketViewController.swift
//  R3PIBasket
//
//  Created by Stephan Korner on 01.07.18.
//  Copyright © 2018 Ideen Kaffee Korner. All rights reserved.
//

import Foundation
import UIKit

protocol ProductsDelegate: class {
    func signalProductUpdate()
}

class BasketViewController: UIViewController, CurrencyDelegate, UITableViewDelegate, UITableViewDataSource {
    
    fileprivate let defaults = UserDefaults(suiteName: AppConstants.USERDEFAULTS.USER_DEFAULT_SUITE_NAME)!
    
    weak var delegate: ProductsDelegate?
    
    @IBOutlet weak var basketTableView: UITableView!
    @IBOutlet weak var currencyChoiceBtnOutlet: UIButton!
    
    var conversionFactor: Float?
    
    var products: [Product]?
    
    // persistency of Basket
    // if more time - this would perferably be done by CoreData or Realm
    //
    // Since User-Defaults can store Int's, String's or [String]'s
    // there is a composition of the Basket-object
    var basket: Basket?
    
    override func viewDidLoad() {
        
        // set delegates
        self.basketTableView.delegate = self
        self.basketTableView.dataSource = self
        
        // allow user to tap next to keyboard and make it dissappear
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.hideKeyboardByTappingOutside))
        self.view.addGestureRecognizer(tap)
        
        // set properties
        self.currencyChoiceBtnOutlet.setTitle(self.basket?.basketCurrency.rawValue ?? "USD" + " >", for: .normal)
        
        self.setCurrencyForAllProducts()
    }
    
    @objc func hideKeyboardByTappingOutside() {
        self.view.endEditing(true)
    }
    
    // MARK: Segue method
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        switch segue.identifier! {
        case SegueNames.GoToCurrencyChoice.rawValue:
            let currencySearchVC = segue.destination as! CurrenyChoiceTableViewController
            currencySearchVC.delegate = self
            currencySearchVC.currentTag = 0
            currencySearchVC.title = "Currency Choice"
        default:
            break
        }
    }
    
    // MARK: TableView Delegate methods
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 134
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.basket?.itemsTypes?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let defaultCell = UITableViewCell(style: .default, reuseIdentifier: CellNames.BasketCell.rawValue)
        guard let basketCell = tableView.dequeueReusableCell(withIdentifier: CellNames.BasketCell.rawValue, for: indexPath) as? BasketCustomTableViewCell else {
            return defaultCell
        }
        
        // define look and feel
        basketCell.selectionStyle = .none
        basketCell.configureCell(tag: indexPath.row)
        
        basketCell.updateBasketCompletion = { newAmount in
            
            self.basket?.productAmounts![ProductName(rawValue: self.products![indexPath.row].productName.rawValue)!] = newAmount
        }
        
        basketCell.removeFromBasketBtnCompletion = { product in
            self.products?.remove(at: indexPath.row)
            if let product = product {
                self.basket?.removeItem(withName: product)
            }
            if self.products?.count ?? 0 >= indexPath.row + 1 {
                if let _ = self.basket?.productAmounts,
                    let pro = self.products?[indexPath.row],
                    let productN = ProductName(rawValue: pro.productName.rawValue) {
                    self.basket?.productAmounts![productN] = 0
                }
            }

            self.basketTableView.reloadData()
        }
        
        // 1st: create temporary-product
        var tempProduct = self.products![indexPath.row]
        // 2nd: add more product-properties from the basket
        // (since only a generic product was instantiated and injected)
        if let productName = self.basket?.itemsTypes?[indexPath.row],
            let unitPrice = ProductUnitPriceInUSD.getUnitPriceInUSD(productName: productName) {
            
            let nrOfProducts = (self.basket?.productAmounts?[productName])!
            tempProduct.productPrice = Float(nrOfProducts) * unitPrice
            tempProduct.nrOfProducts = nrOfProducts
            // 3rd: assign the product
            basketCell.product = tempProduct
            basketCell.nrOfProductsTextField.text = "\(nrOfProducts)"
            //43rd: calculateConversion (order matters!)
            basketCell.calculateConversion(conversionFactor: self.conversionFactor)
        }
        return basketCell
    }
    
    // MARK: Helper functions
    
    func setCurrencyForAllProducts() {
        // set currency for all products
        if let products = self.products {
            for (idx, _) in products.enumerated() {
                self.products?[idx].productCurrency = self.basket?.basketCurrency ?? .USD
            }
        }
    }
    
    // MARK: Network-calls
    
    func getNewestConversionFactor() {
        // make a network-call to get most up-to-date Currency conversion
        // ..do this in the background not to bother the UI..
        let workItem_BG_CurrencyFetch = DispatchWorkItem {
            let currencyAPI = CurrencyPlayerAPI()
            
            let access_key = AppConstants.APIKeys.CURRENCY_PLAYER_API_KEY
            let source = "USD"
            let currencies = self.basket?.basketCurrency.rawValue ?? "USD"
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
                // if successful:
                // get currency-conversion-factor from API
                // (there is only one non-nil quotes-entry since we only asked for one)
                self.conversionFactor = currencyResult?.quotes?.getFirstNonNilValue()
                // reload tableView with new conversion-factor
                DispatchQueue.main.async {
                    self.basketTableView.reloadData()
                }
            }
        }
        // then call the new workItem to be carried out in a concurrent BG-thread
        DispatchQueue.global(qos:.userInteractive).async(execute: workItem_BG_CurrencyFetch)
    }
    
    // MARK: Target-Actions
    
    @IBAction func currencyChoiceBtnPressed(_ sender: Any) {
        self.performSegue(withIdentifier: SegueNames.GoToCurrencyChoice.rawValue, sender: nil)
    }
    
    @IBAction func continueShoppingBtnPressed(_ sender: Any) {
        
        self.delegate?.signalProductUpdate()
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func goToPaymentBtnPressed(_ sender: Any) {
    }
    
    // MARK: Delegate callbacks
    
    func setBackDataNow(currency: Currency) {
        self.basket?.basketCurrency = currency
        self.currencyChoiceBtnOutlet.setTitle(currency.rawValue + " >", for: .normal)
        self.setCurrencyForAllProducts()
        self.getNewestConversionFactor()
    }
}
