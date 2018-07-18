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

class BasketViewController: UIViewController, CurrencyDelegate, BasketDelegate, UITableViewDelegate, UITableViewDataSource {
    
    fileprivate let defaults = UserDefaults(suiteName: AppConstants.USERDEFAULTS.USER_DEFAULT_SUITE_NAME)!
    
    weak var productDelegate: ProductsDelegate?
    
    @IBOutlet weak var basketTableView: UITableView!
    @IBOutlet weak var currencyChoiceBtnOutlet: UIButton!
    @IBOutlet weak var continueShoppingBtnOutlet: UIButton!
    @IBOutlet weak var goToPaymentBtnOutlet: UIButton!
    
    var basketVM = BasketViewModel()
    
    override func viewDidLoad() {
        
        // set delegates
        self.basketTableView.delegate = self
        self.basketTableView.dataSource = self
        
        // allow user to tap next to keyboard and make it dissappear
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.hideKeyboardByTappingOutside))
        self.view.addGestureRecognizer(tap)
        
        // set properties
    self.currencyChoiceBtnOutlet.setTitle((self.basketVM.basket?.basketCurrency.rawValue ?? AppConstants.DefaultValues.USD_Currency) + " >", for: .normal)
        
        self.basketVM.setCurrencyForAllProducts()
        self.setLookAndFeel()

        // move view out of the way-observers when keyboard shows
        NotificationCenter.default.addObserver(self, selector: #selector(ProductChoiceViewController.keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(ProductChoiceViewController.keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        
        // observer for productChoice-ViewModel callbacks
        NotificationCenter.default.addObserver(self, selector: #selector(ProductChoiceViewController.showAlert), name: NSNotification.Name.AlertNotif, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(ProductChoiceViewController.doTableViewReload), name: NSNotification.Name.TableViewReloadNotif, object: nil)
    }
    
    @objc func keyboardWillShow(_ notification:Notification) {
        
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            self.basketTableView.contentInset = UIEdgeInsetsMake(0, 0, keyboardSize.height + 25, 0)
        }
    }
    
    @objc func keyboardWillHide(_ notification:Notification)
    {
        if let _ = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            self.basketTableView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0)
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
        self.currencyChoiceBtnOutlet.setTitle((self.basketVM.basket?.basketCurrency.rawValue ?? AppConstants.DefaultValues.USD_Currency) + " >", for: .normal)
        // reload tableView with new conversion-factor
        DispatchQueue.main.async {
            self.basketTableView.reloadData()
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
    
    func setLookAndFeel() {
        switch AppConstants.FEATUREFLAG.DEVICE_MODEL_NAME {
        case Devices.IPhone5, Devices.IPhone5S, Devices.IPhone5C:
            self.goToPaymentBtnOutlet.setTitle("  Payment >", for: .normal)
            self.continueShoppingBtnOutlet.setTitle("< Continue  ", for: .normal)
        case Devices.IPhone6, Devices.IPhone6S, Devices.IPhone7, Devices.IPhone8:
            self.goToPaymentBtnOutlet.setTitle("  Go to Payment >", for: .normal)
            self.continueShoppingBtnOutlet.setTitle("< Continue Shopping  ", for: .normal)
        case Devices.IPhone6Plus, Devices.IPhone6SPlus, Devices.IPhone7Plus, Devices.IPhone8Plus:
            self.goToPaymentBtnOutlet.setTitle("  Go to Payment >", for: .normal)
            self.continueShoppingBtnOutlet.setTitle("< Continue Shopping  ", for: .normal)
        case Devices.IPhoneX:
            self.goToPaymentBtnOutlet.setTitle("  Go to Payment >", for: .normal)
            self.continueShoppingBtnOutlet.setTitle("< Continue Shopping  ", for: .normal)
        default:
            self.goToPaymentBtnOutlet.setTitle("  Go to Payment >", for: .normal)
            self.continueShoppingBtnOutlet.setTitle("< Continue Shopping  ", for: .normal)
        }
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
            summaryVC.basketDelegate = self
            // since summary might go back directly to continue shopping - we need to assign this delegate as well..
            summaryVC.productDelegate = self.presentingViewController as? ProductsDelegate
            summaryVC.summaryVM.basket = self.basketVM.basket
            summaryVC.summaryVM.conversionFactor = self.basketVM.conversionFactor
            summaryVC.summaryVM.basketProducts = [Product]()
            // inject what you have from the basket into the new VC's products
            let productHelper = ProductHelper()
            summaryVC.summaryVM.basketProducts = productHelper.generateProductsFromBasketInUSD(basket: self.basketVM.basket)
            (self.basketVM.basketProducts, self.basketVM.basket) = summaryVC.summaryVM.cleanZeros()
        default:
            break
        }
    }
    
    // MARK: TableView Delegate methods
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 134
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.basketVM.basket?.itemsTypes?.count ?? 0
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
            
            let products = ProductNames()
            for prod in products.products {
                if prod == self.basketVM.basketProducts![indexPath.row].productName {
                    self.basketVM.basket?.productAmounts?[prod] = newAmount
                    break
                }
            }
        }
        
        basketCell.deleteItemCompletion = { newAmount in
            
            let products = ProductNames()
            for prod in products.products {
                if prod == self.basketVM.basketProducts![indexPath.row].productName {
                    self.basketVM.basket?.productAmounts?[prod] = newAmount
                    break
                }
            }
        }
        
        basketCell.removeFromBasketBtnCompletion = { productN in
            
            self.basketVM.basketProducts?.remove(at: indexPath.row)
            if let productN = productN {
                self.basketVM.basket?.removeBasketItem(withName: productN)
                // self.basket?.removeAmountItem(withName: productN)
            }
            self.basketTableView.reloadData()
        }
        
        // 1st: create temporary-product
        let tempProduct = self.basketVM.basketProducts![indexPath.row]
        // 2nd: assign the product
        basketCell.product = tempProduct
        let nrOfProducts = tempProduct.nrOfProducts
        basketCell.nrOfProductsTextField.text = "\(nrOfProducts)"
        //43rd: calculateConversion (order matters!)
        basketCell.calculateConversion(conversionFactor: self.basketVM.conversionFactor)
        return basketCell
    }
    
    // MARK: Delegate callback methods
    
    func signalBasketUpdate() {
        // update currency
    self.currencyChoiceBtnOutlet.setTitle((self.basketVM.basket?.basketCurrency.rawValue ?? AppConstants.DefaultValues.USD_Currency) + " >", for: .normal)
        self.basketVM.setCurrencyForAllProducts()
        self.basketVM.getNewestConversionFactor()
        // update the productsTableView
        self.basketTableView.reloadData()
    }
    
    // MARK: Target-Actions
    
    @IBAction func currencyChoiceBtnPressed(_ sender: Any) {
        self.performSegue(withIdentifier: SegueNames.GoToCurrencyChoice.rawValue, sender: nil)
    }
    
    @IBAction func continueShoppingBtnPressed(_ sender: Any) {
        
        self.productDelegate?.signalProductUpdate()
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func goToPaymentBtnPressed(_ sender: Any) {
        self.performSegue(withIdentifier: SegueNames.GoToSummary.rawValue, sender: nil)
    }
    
    // MARK: Delegate callbacks
    
    func setBackDataNow(currency: Currency) {
        self.basketVM.basket?.basketCurrency = currency
        self.currencyChoiceBtnOutlet.setTitle(currency.rawValue + " >", for: .normal)
        self.basketVM.setCurrencyForAllProducts()
        self.basketVM.getNewestConversionFactor()
    }
}
