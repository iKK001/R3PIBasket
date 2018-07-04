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
    
    @IBOutlet weak var productTableView: UITableView!
    @IBOutlet weak var currencyChoiceBtnOutlet: UIButton!
    @IBOutlet weak var nrOfItemsLblOutlet: UILabel!
    
    var prodVM = ProductChoiceViewModel()
    
    override func viewDidLoad() {
        
        // set delegates
        self.productTableView.delegate = self
        self.productTableView.dataSource = self
        
        // allow user to tap next to keyboard and make it dissappear
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.hideKeyboardByTappingOutside))
        self.view.addGestureRecognizer(tap)
        
        // set properties
        self.nrOfItemsLblOutlet.text = "\(self.prodVM.basket?.itemsTypes?.count ?? 0)"
        self.currencyChoiceBtnOutlet.setTitle((self.prodVM.basket?.basketCurrency.rawValue ?? "USD") + " >", for: .normal)
        
        self.prodVM.setCurrencyForAllProducts()
        self.prodVM.getNewestConversionFactor()
        
        // move view out of the way-observers when keyboard shows
        NotificationCenter.default.addObserver(self, selector: #selector(ProductChoiceViewController.keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(ProductChoiceViewController.keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        
        // observer for productChoice-ViewModel callbacks
        NotificationCenter.default.addObserver(self, selector: #selector(ProductChoiceViewController.showAlert), name: NSNotification.Name.AlertNotif, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(ProductChoiceViewController.doTableViewReload), name: NSNotification.Name.TableViewReloadNotif, object: nil)
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
    
    @objc func showAlert(_ notification: Notification) {
        
        guard let alertText = notification.object as? [String:String] else {
            let object = notification.object as Any
            assertionFailure("Invalid object: \(object)")
            return
        }
        // inform user that the network-fetch was not successful
        let alertController = UIAlertController(title: alertText["title"], message: alertText["message"], preferredStyle: UIAlertControllerStyle.alert)
        alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default,handler: nil))
        self.present(alertController, animated: true, completion: nil)
    }
            
    @objc func doTableViewReload() {
        self.currencyChoiceBtnOutlet.setTitle((self.prodVM.basket?.basketCurrency.rawValue ?? "") + " >", for: .normal)
        // reload tableView with new conversion-factor
        DispatchQueue.main.async {
            self.productTableView.reloadData()
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
            basketVC.basketVM.basket = self.prodVM.basket
            basketVC.basketVM.conversionFactor = self.prodVM.conversionFactor
            basketVC.basketVM.basketProducts = [Product]()
            // inject what you have from the basket into the new VC's products
            if let itemTypes = self.prodVM.basket?.itemsTypes {
                for (idx, item) in itemTypes.enumerated() {
                    if let anyProd = GenericProduct.createProduct(productName: item) {
                        
                        var anyProduct = anyProd
                        basketVC.basketVM.basketProducts?.append(anyProduct)
                        if let productName = self.prodVM.basket?.itemsTypes?[idx],
                            let unitPrice = ProductUnitPriceInUSD.getUnitPriceInUSD(productName: productName) {
                            let nrOfProducts = (self.prodVM.basket?.productAmounts?[productName])!
                            anyProduct.productPrice = Float(nrOfProducts) * unitPrice
                            anyProduct.nrOfProducts = nrOfProducts
                            basketVC.basketVM.basketProducts?[idx] = anyProduct
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
        return self.prodVM.products?.count ?? 0
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
        productCell.product = self.prodVM.products![indexPath.row]
        // 2nd: calculateConversion (order matters!)
        productCell.calculateConversion(conversionFactor: self.prodVM.conversionFactor)
        
        // completion-handler when AddBasket-Button of a cell is pressed
        productCell.addToBasketBtnCompletion = { tag in
            self.prodVM.updateAmountsAndNumberOfItems(tag: tag, productName: ProductName(rawValue: productCell.productName.text ?? "")!, amount: Int(productCell.nrOfProductsTextField.text ?? "") ?? 0)
            self.nrOfItemsLblOutlet.text = "\(self.prodVM.basket?.itemsTypes?.count ?? 0)"
        }
        
        productCell.deleteItemBtnCompletion = { tag in
            // update products
            self.prodVM.products![indexPath.row].nrOfProducts = 0
        }
        
        if let items = self.prodVM.basket?.itemsTypes {
            if items.contains(productCell.product.productName) {
                productCell.greenIsInBasketView.isHidden = false
            } else {
                productCell.greenIsInBasketView.isHidden = true
                productCell.nrOfProductsTextField.text = "0"
            }
        }

        return productCell
    }
    
    // MARK: Target-Actions
    
    @IBAction func currencyChoiceBtnPressed(_ sender: Any) {
        self.performSegue(withIdentifier: SegueNames.GoToCurrencyChoice.rawValue, sender: nil)
    }
    
    // MARK: Delegate callbacks
    
    func setBackDataNow(currency: Currency) {
        self.prodVM.basket?.basketCurrency = currency
        self.currencyChoiceBtnOutlet.setTitle(currency.rawValue + " >", for: .normal)
        self.prodVM.setCurrencyForAllProducts()
        self.prodVM.getNewestConversionFactor()
    }
    
    func signalProductUpdate() {
        
        self.prodVM.signalProductUpdate()
        self.currencyChoiceBtnOutlet.setTitle((self.prodVM.basket?.basketCurrency.rawValue ?? "") + " >", for: .normal)
        self.nrOfItemsLblOutlet.text = "\(self.prodVM.basket?.itemsTypes?.count ?? 0)"
    }
}
