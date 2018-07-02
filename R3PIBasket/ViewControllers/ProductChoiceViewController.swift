//
//  ProductChoiceViewController.swift
//  R3PIBasket
//
//  Created by Stephan Korner on 01.07.18.
//  Copyright © 2018 Ideen Kaffee Korner. All rights reserved.
//

import Foundation
import UIKit

enum CellNames: String {
    case ProductChoiceCell = "ProductChoiceCell"
}

class ProductChoiceViewController: UIViewController, CurrencyDelegate, UITableViewDelegate, UITableViewDataSource {
    
    fileprivate let defaults = UserDefaults(suiteName: AppConstants.USERDEFAULTS.USER_DEFAULT_SUITE_NAME)!
    
    @IBOutlet weak var productTableView: UITableView!
    @IBOutlet weak var currencyChoiceBtnOutlet: UIButton!
    @IBOutlet weak var nrOfItemsLblOutlet: UILabel!
    
    private var conversionFactor: Float?
    private var nrOfItems: Int?
    var products: [Product]?
    
    // persistency of Basket
    // if more time - this would perferably be done by CoreData or Realm
    //
    // Since User-Defaults can store Int's, String's or [String]'s
    // there is a composition of the Basket-object
    var basket: Basket? {
        get {
            var itemsTypes: [ProductName]? = [ProductName]()
            var productAmounts: [ProductName: Int] = [ProductName: Int]()
            let currency: Currency = Currency(rawValue: self.defaults.object(forKey: AppConstants.USERDEFAULTS.USER_DEFAULT_CURRENCY_CHOICE) as? String ?? "USD")!
            let itemTypeStrArr = self.defaults.object(forKey: AppConstants.USERDEFAULTS.USER_DEFAULT_BASKET_ITEM_TYPES) as? [String] ?? [""]
            let productAmountIntArr = self.defaults.object(forKey: AppConstants.USERDEFAULTS.USER_DEFAULT_BASKET_PRODUCT_AMOUNT) as? [Int] ?? [0]
            itemsTypes?.removeAll()
            productAmounts.removeAll()
            var i = 0
            for itemT in itemTypeStrArr  {
                if let item = ProductName(rawValue: itemT) {
                    itemsTypes?.append(item)
                    productAmounts[item] = productAmountIntArr[i]
                    i = i + 1
                }
            }
            return Basket(itemsTypes: itemsTypes, productAmounts: productAmounts, basketCurrency: currency)
        }
        set {
            var itemsTypeStrArr: [String] = [String]()
            var productAmounts: [Int] = [Int]()
            let currency: String = (newValue?.basketCurrency.rawValue)!
            itemsTypeStrArr.removeAll()
            productAmounts.removeAll()
            if let items = newValue?.itemsTypes {
                for item in items {
                    itemsTypeStrArr.append(item.rawValue)
                    productAmounts.append(newValue?.productAmounts![item] ?? 0)
                }
            }
            self.defaults.set(itemsTypeStrArr, forKey: AppConstants.USERDEFAULTS.USER_DEFAULT_BASKET_ITEM_TYPES)
            self.defaults.set(productAmounts, forKey: AppConstants.USERDEFAULTS.USER_DEFAULT_BASKET_PRODUCT_AMOUNT)
            self.defaults.set(currency, forKey: AppConstants.USERDEFAULTS.USER_DEFAULT_CURRENCY_CHOICE)

            self.defaults.synchronize()
        }
    }
    
    override func viewDidLoad() {
        
        // set delegates
        self.productTableView.delegate = self
        self.productTableView.dataSource = self
        
        // allow user to tap next to keyboard and make it dissappear
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.hideKeyboardByTappingOutside))
        self.view.addGestureRecognizer(tap)
        
        // set properties
        self.nrOfItemsLblOutlet.text = "\(self.basket?.itemsTypes?.count ?? 0)"
        self.currencyChoiceBtnOutlet.setTitle(self.basket?.basketCurrency.rawValue ?? "USD" + " >", for: .normal)
        
        self.setCurrencyForAllProducts()
        self.getNewetsConversionFactor()
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
        return self.products?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let defaultCell = UITableViewCell(style: .default, reuseIdentifier: CellNames.ProductChoiceCell.rawValue)
        guard let productCell = tableView.dequeueReusableCell(withIdentifier: CellNames.ProductChoiceCell.rawValue, for: indexPath) as? ProductChoiceCustomTableViewCell else {
            return defaultCell
        }
        
        // define look and feel
        productCell.selectionStyle = .none
        productCell.configureCell(tag: indexPath.row)
        
        // 1st: assign the product
        productCell.product = self.products![indexPath.row]
        // 2nd: calculateConversion (order matters!)
        productCell.calculateConversion(conversionFactor: self.conversionFactor)
        
        // completion-handler when AddBasket-Button of a cell is pressed
        productCell.addToBasketBtnCompletion = { tag in
            self.setNewAmountForProduct(tag: tag, amount: Int(productCell.nrOfProductsTextField.text ?? "") ?? 0)
            self.setNewAmountInBasket(productName: ProductName(rawValue: productCell.productName.text ?? ""), amount: Int(productCell.nrOfProductsTextField.text ?? "") ?? 0)
            self.updateNrOfItemsInBasket(tag: tag)
            print(self.basket)
        }

        return productCell
    }
    
    // MARK: Helper functions
    func setCurrencyForAllProducts() {
        // set currency for all products
        // TODO: Make [Products]() confrom to Sequence-Type to make this easier
        if let products = self.products {
            var i = 0
            for _ in products {
                self.products?[i].productCurrency = self.basket?.basketCurrency ?? .USD
                i = i + 1
            }
        }
    }
    
    func setNewAmountForProduct(tag: Int, amount: Int) {
        self.products?[tag].nrOfProducts = amount
    }
    
    func setNewAmountInBasket(productName: ProductName?, amount: Int) {
        if let _ = self.basket?.productAmounts,
            let prodName = productName {
            self.basket?.productAmounts![prodName] = amount
        }
    }
    
    func updateNrOfItemsInBasket(tag: Int) {
        
        // if basket does not contain product-Item, add it
        if let items = self.basket?.itemsTypes,
            let name = self.products?[tag].productName {
            if !items.contains(name) {
                self.basket?.itemsTypes?.append(name)
                let amount = self.products?[tag].nrOfProducts
                self.basket?.productAmounts?[name] = amount ?? 0
            }
        }
        self.nrOfItems = self.basket?.itemsTypes?.count
        self.nrOfItemsLblOutlet.text = "\(self.nrOfItems ?? 0)"
    }
    
    // MARK: Network-calls
    
    func getNewetsConversionFactor() {
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
                    self.productTableView.reloadData()
                }
            }
        }
        // then call the new workItem to be carried out in a concurrent BG-thread
        DispatchQueue.global(qos:.userInteractive).async(execute: workItem_BG_CurrencyFetch)
    }
    
    // MARK: Target-Actions
    
    @IBAction func currencyChoiceBtnPressed(_ sender: Any) {
        self.performSegue(withIdentifier: "goToCurrencyChoice", sender: nil)
    }
    
    @IBAction func goToBasketBtnPressed(_ sender: Any) {
    }
    
    // MARK: Delegate callbacks
    
    func setBackDataNow(currency: Currency) {
        self.basket?.basketCurrency = currency
        self.currencyChoiceBtnOutlet.setTitle(currency.rawValue + " >", for: .normal)
        self.setCurrencyForAllProducts()
        self.getNewetsConversionFactor()
    }
}
