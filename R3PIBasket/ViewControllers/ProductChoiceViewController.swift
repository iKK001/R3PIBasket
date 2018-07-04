//
//  ProductChoiceViewController.swift
//  R3PIBasket
//
//  Created by Stephan Korner on 01.07.18.
//  Copyright © 2018 Ideen Kaffee Korner. All rights reserved.
//

import Foundation
import UIKit

class ProductChoiceViewController: UIViewController, CurrencyDelegate, UITableViewDelegate, UITableViewDataSource, ProductsDelegate {
    
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
    var basket: Basket?
    
    override func viewDidLoad() {
        
        // set delegates
        self.productTableView.delegate = self
        self.productTableView.dataSource = self
        
        // allow user to tap next to keyboard and make it dissappear
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.hideKeyboardByTappingOutside))
        self.view.addGestureRecognizer(tap)
        
        // set properties
        self.nrOfItemsLblOutlet.text = "\(self.basket?.itemsTypes?.count ?? 0)"
        self.currencyChoiceBtnOutlet.setTitle((self.basket?.basketCurrency.rawValue ?? "USD") + " >", for: .normal)
        
        self.setCurrencyForAllProducts()
        self.getNewestConversionFactor()
        
        // move view out of the way-observers when keyboard shows
        NotificationCenter.default.addObserver(self, selector: #selector(ProductChoiceViewController.keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(ProductChoiceViewController.keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    @objc func keyboardWillShow(_ notification:Notification) {
        
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            self.productTableView.contentInset = UIEdgeInsetsMake(0, 0, keyboardSize.height + 25, 0)
        }
    }
    
    @objc func keyboardWillHide(_ notification:Notification)
    {
        if let _ = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            self.productTableView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0)
        }
    }
        
    deinit {
        // If your app supports iOS 8 or earlier, you need to manually
        // remove the observer from the center. In later versions
        // this is done automatically.
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc func hideKeyboardByTappingOutside() {
        self.view.endEditing(true)
    }
    
    // MARK: Segue method
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        switch segue.identifier! {
        case SegueNames.GoToCurrencyChoice.rawValue:
            let currencySearchVC = segue.destination as! CurrenyChoiceTableViewController
            currencySearchVC.title = "Currency Choice"
            currencySearchVC.delegate = self
            currencySearchVC.currentTag = 0
        case SegueNames.GoToBasket.rawValue:
            let basketVC = segue.destination as! BasketViewController
            basketVC.title = "Basket"
            basketVC.delegate = self
            basketVC.basket = self.basket
            basketVC.conversionFactor = self.conversionFactor
            basketVC.basketProducts = [Product]()
            // inject what you have from the basket into the new VC's products
            if let itemTypes = self.basket?.itemsTypes {
                for (idx, item) in itemTypes.enumerated() {
                    if let anyProd = GenericProduct.createProduct(productName: item) {
                        
                        var anyProduct = anyProd
                        basketVC.basketProducts?.append(anyProduct)
                        if let productName = self.basket?.itemsTypes?[idx],
                            let unitPrice = ProductUnitPriceInUSD.getUnitPriceInUSD(productName: productName) {
                            let nrOfProducts = (self.basket?.productAmounts?[productName])!
                            anyProduct.productPrice = Float(nrOfProducts) * unitPrice
                            anyProduct.nrOfProducts = nrOfProducts
                            basketVC.basketProducts?[idx] = anyProduct
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
            self.updateAmountsAndNumberOfItems(tag: tag, productName: ProductName(rawValue: productCell.productName.text ?? "")!, amount: Int(productCell.nrOfProductsTextField.text ?? "") ?? 0)
        }
        
        productCell.deleteItemBtnCompletion = { tag in
            // update products
            self.products![indexPath.row].nrOfProducts = 0
        }
        
        if let items = self.basket?.itemsTypes {
            if items.contains(productCell.product.productName) {
                productCell.greenIsInBasketView.isHidden = false
            } else {
                productCell.greenIsInBasketView.isHidden = true
                productCell.nrOfProductsTextField.text = "0"
            }
        }

        return productCell
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
    
    func setNewAmountForProduct(tag: Int, amount: Int) {
        self.products?[tag].nrOfProducts = amount
    }
    
    func setNewAmountInBasket(productName: ProductName?, amount: Int) {
        if let prodName = productName {
            self.basket?.productAmounts![prodName] = amount
        }
    }
    
    func updateAmountsAndNumberOfItems(tag: Int, productName: ProductName, amount: Int) {
        
        if amount > 0 {
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
            
            self.setNewAmountForProduct(tag: tag, amount: amount)
            self.setNewAmountInBasket(productName: productName, amount: amount)
        }
    }
    
    // MARK: Network-calls
    
    func getNewestConversionFactor() {
        
        if self.self.basket?.basketCurrency != .USD {
            if iKKHelperClass.checkWiFi() {
                
                // make a network-call to get most up-to-date Currency conversion
                // ..do this in the background not to bother the UI..
                let workItem_BG_CurrencyFetch = DispatchWorkItem {
                    let currencyAPI = CurrencyPlayerAPI()
                    let currency = self.basket?.basketCurrency ?? .USD
                    currencyAPI.getConversionFactor(currency: currency) { (conversionFactor, error) in
                        
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
                        self.conversionFactor = conversionFactor
                        // reload tableView with new conversion-factor
                        DispatchQueue.main.async {
                            self.productTableView.reloadData()
                        }
                    }
                }
                // then call the new workItem to be carried out in a concurrent BG-thread
                DispatchQueue.global(qos:.userInteractive).async(execute: workItem_BG_CurrencyFetch)
            } else {
                DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(300)) {
                    let alertController = UIAlertController(title: "No inernet !", message: "You must be online in order to get newest product currency information.", preferredStyle: UIAlertControllerStyle.alert)
                    alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default,handler: nil))
                    self.present(alertController, animated: true, completion: nil)
                    // also set currency to USD since no online-data available
                    self.basket?.basketCurrency = .USD
                    self.setCurrencyForAllProducts()
                    self.conversionFactor = 1
                    self.currencyChoiceBtnOutlet.setTitle((self.basket?.basketCurrency.rawValue ?? "") + " >", for: .normal)
                    // reload tableView with new conversion-factor
                    DispatchQueue.main.async {
                        self.productTableView.reloadData()
                    }
                }
            }
        }
    }
    
    // MARK: Target-Actions
    
    @IBAction func currencyChoiceBtnPressed(_ sender: Any) {
        self.performSegue(withIdentifier: SegueNames.GoToCurrencyChoice.rawValue, sender: nil)
    }
    
    // MARK: Delegate callbacks
    
    func setBackDataNow(currency: Currency) {
        self.basket?.basketCurrency = currency
        self.currencyChoiceBtnOutlet.setTitle(currency.rawValue + " >", for: .normal)
        self.setCurrencyForAllProducts()
        self.getNewestConversionFactor()
    }
    
    func signalProductUpdate() {
        
        // update products
        if let _ = self.basket?.itemsTypes,
            let products = self.products,
            let amounts = self.basket?.productAmounts {
            for (prodIdx, prod) in products.enumerated() {
                for (key, value) in amounts {  // amounts is of type [ProductName: Int]
                    if key == prod.productName {
                        self.products![prodIdx].nrOfProducts = value
                    }
                }
            }
        }
        // update currency
    self.currencyChoiceBtnOutlet.setTitle((self.basket?.basketCurrency.rawValue ?? "") + " >", for: .normal)
        // update Item counter in Basket
        self.nrOfItems = self.basket?.itemsTypes?.count
        self.nrOfItemsLblOutlet.text = "\(self.nrOfItems ?? 0)"
        self.setCurrencyForAllProducts()
        self.getNewestConversionFactor()
    }
}
