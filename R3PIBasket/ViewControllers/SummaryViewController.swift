//
//  SummaryViewController.swift
//  R3PIBasket
//
//  Created by Stephan Korner on 01.07.18.
//  Copyright © 2018 Ideen Kaffee Korner. All rights reserved.
//

import Foundation
import UIKit

class SummaryViewController: UIViewController, CurrencyDelegate, UITableViewDelegate, UITableViewDataSource {
    
    fileprivate let defaults = UserDefaults(suiteName: AppConstants.USERDEFAULTS.USER_DEFAULT_SUITE_NAME)!
    fileprivate let cellHeight: CGFloat = 68.0
    
    weak var delegate: ProductsDelegate?
    
    @IBOutlet weak var summaryTableView: UITableView!
    @IBOutlet weak var currencyChoiceBtnOutlet: UIButton!
    @IBOutlet weak var tableViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var totalSummaryPrice: UILabel!
    @IBOutlet weak var totalSummaryCurrency: UILabel!
    @IBOutlet weak var currencyLiteralLabel: UILabel!
    
    var conversionFactor: Float?
    var basketProducts: [Product]?
    var basket: Basket?
    
    override func viewDidLoad() {
        
        // set delegates
        self.summaryTableView.delegate = self
        self.summaryTableView.dataSource = self
        self.setLookAndFeel()
    self.currencyChoiceBtnOutlet.setTitle((self.basket?.basketCurrency.rawValue ?? "USD") + " >", for: .normal)
        
        self.setCurrencyForAllProducts()
        self.getNewestConversionFactor()
        self.summaryTableView.reloadData()
        
        // move view out of the way-observers when keyboard shows
        NotificationCenter.default.addObserver(self, selector: #selector(ProductChoiceViewController.keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(ProductChoiceViewController.keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    @objc func keyboardWillShow(_ notification:Notification) {
        
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            self.summaryTableView.contentInset = UIEdgeInsetsMake(0, 0, keyboardSize.height + 25, 0)
        }
    }
    
    @objc func keyboardWillHide(_ notification:Notification)
    {
        if let _ = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            self.summaryTableView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0)
        }
    }
    
    deinit {
        // If your app supports iOS 8 or earlier, you need to manually
        // remove the observer from the center. In later versions
        // this is done automatically.
        NotificationCenter.default.removeObserver(self)
    }
    
    func setLookAndFeel() {
        self.summaryTableView.isScrollEnabled = false
        self.tableViewHeightConstraint.constant = CGFloat(self.basket?.itemsTypes?.count ?? 0) * cellHeight
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
        return cellHeight
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.basket?.itemsTypes?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let defaultCell = UITableViewCell(style: .default, reuseIdentifier: CellNames.BasketCell.rawValue)
        guard let summaryCell = tableView.dequeueReusableCell(withIdentifier: CellNames.SummaryCell.rawValue, for: indexPath) as? SummaryCustomTableViewCell else {
            return defaultCell
        }
        
        // define look and feel
        summaryCell.selectionStyle = .none
        summaryCell.configureCell(tag: indexPath.row)
        
        // 1st: create temporary-product
        var tempProduct = self.basketProducts![indexPath.row]
        // 2nd: assign the product
        summaryCell.product = tempProduct
        let nrOfProducts = tempProduct.nrOfProducts
        summaryCell.nrOfProductsLabel.text = "\(nrOfProducts)"
        //43rd: calculateConversion (order matters!)
        summaryCell.calculateConversion(conversionFactor: self.conversionFactor)
        
        // detect last reload-deque-cycle: do the summary-calculation
        if let lastVisibleIndexPath = tableView.indexPathsForVisibleRows?.last {
            if indexPath == lastVisibleIndexPath {
                self.calculatePurchaseSummary()
            }
        }
        return summaryCell
    }
    
    // MARK: Helper functions
    
    func setCurrencyForAllProducts() {
        // set currency for all products
        if let products = self.basketProducts {
            for (idx, _) in products.enumerated() {
                self.basketProducts?[idx].productCurrency = self.basket?.basketCurrency ?? .USD
            }
        }
        self.totalSummaryCurrency.text = self.basket?.basketCurrency.rawValue ?? "USD"
        self.currencyLiteralLabel.text = (self.basket?.basketCurrency.countryName ?? "United States Dollar") + ")"
    }
    
    func calculatePurchaseSummary() {
        var total: Float = 0.0
        if let products = self.basketProducts {
            for (_, product) in products.enumerated() {
                total = total + product.productPrice *  (self.conversionFactor ?? 1.0)
            }
        }
        self.totalSummaryPrice.text = String(format: "%.2f", total)
    }
    
    // MARK: Network-calls
    
    func getNewestConversionFactor() {
        
        if iKKHelperClass.checkWiFi() {
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
                        self.summaryTableView.reloadData()
                    }
                }
            }
            // then call the new workItem to be carried out in a concurrent BG-thread
            DispatchQueue.global(qos:.userInteractive).async(execute: workItem_BG_CurrencyFetch)
        }  else {
            DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(300)) {
                let alertController = UIAlertController(title: "No inernet !", message: "You must be online in order to get newest product currency information.", preferredStyle: UIAlertControllerStyle.alert)
                alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default,handler: nil))
                self.present(alertController, animated: true, completion: nil)
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
    
    @IBAction func backBtnPressed(_ sender: Any) {
        self.delegate?.signalProductUpdate()
        self.dismiss(animated: true, completion: nil)
    }
}
