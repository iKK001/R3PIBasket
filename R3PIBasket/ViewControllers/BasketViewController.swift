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
    var basketProducts: [Product]?
    var basket: Basket?
    
    override func viewDidLoad() {
        
        // set delegates
        self.basketTableView.delegate = self
        self.basketTableView.dataSource = self
        
        // allow user to tap next to keyboard and make it dissappear
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.hideKeyboardByTappingOutside))
        self.view.addGestureRecognizer(tap)
        
        // set properties
        self.currencyChoiceBtnOutlet.setTitle((self.basket?.basketCurrency.rawValue ?? "USD") + " >", for: .normal)
        
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
        case SegueNames.GoToSummary.rawValue:
            let summaryVC = segue.destination as! SummaryViewController
            summaryVC.title = "Purchase Summary"
            summaryVC.basket = self.basket
            summaryVC.conversionFactor = self.conversionFactor
            summaryVC.basketProducts = [Product]()
            // inject what you have from the basket into the new VC's products
            if let itemTypes = self.basket?.itemsTypes {
                for (idx, item) in itemTypes.enumerated() {
                    if let anyProd = GenericProduct.createProduct(productName: item) {
                        
                        var anyProduct = anyProd
                        summaryVC.basketProducts?.append(anyProduct)
                        if let productName = self.basket?.itemsTypes?[idx],
                            let unitPrice = ProductUnitPriceInUSD.getUnitPriceInUSD(productName: productName) {
                            let nrOfProducts = (self.basket?.productAmounts?[productName])!
                            anyProduct.productPrice = Float(nrOfProducts) * unitPrice
                            anyProduct.nrOfProducts = nrOfProducts
                            summaryVC.basketProducts?[idx] = anyProduct
                        }
                    }
                }
            }
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
            
            self.basket?.productAmounts![ProductName(rawValue: self.basketProducts![indexPath.row].productName.rawValue)!] = newAmount
        }
        
        basketCell.removeFromBasketBtnCompletion = { productN in
            
            self.basketProducts?.remove(at: indexPath.row)
            if let productN = productN {
                self.basket?.removeAmountItem(withName: productN)
                self.basket?.removeBasketItem(withName: productN)
            }
            
             if let _ = self.basket?.itemsTypes,
                 let products = self.basketProducts,
                 let amounts = self.basket?.productAmounts {
                 print(products)
                 print(amounts)
             }

            self.basketTableView.reloadData()
        }
        
        // 1st: create temporary-product
        var tempProduct = self.basketProducts![indexPath.row]
        // 2nd: assign the product
        basketCell.product = tempProduct
        let nrOfProducts = tempProduct.nrOfProducts
        basketCell.nrOfProductsTextField.text = "\(nrOfProducts)"
        //43rd: calculateConversion (order matters!)
        basketCell.calculateConversion(conversionFactor: self.conversionFactor)
        return basketCell
    }
    
    // MARK: Helper functions
    
    func setCurrencyForAllProducts() {
        // set currency for all products
        if let products = self.basketProducts {
            for (idx, _) in products.enumerated() {
                self.basketProducts?[idx].productCurrency = self.basket?.basketCurrency ?? .USD
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
        self.performSegue(withIdentifier: SegueNames.GoToSummary.rawValue, sender: nil)
    }
    
    // MARK: Delegate callbacks
    
    func setBackDataNow(currency: Currency) {
        self.basket?.basketCurrency = currency
        self.currencyChoiceBtnOutlet.setTitle(currency.rawValue + " >", for: .normal)
        self.setCurrencyForAllProducts()
        self.getNewestConversionFactor()
    }
}
