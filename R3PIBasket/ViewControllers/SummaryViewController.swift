//
//  SummaryViewController.swift
//  R3PIBasket
//
//  Created by Stephan Korner on 01.07.18.
//  Copyright © 2018 Ideen Kaffee Korner. All rights reserved.
//

import Foundation
import UIKit

protocol BasketDelegate: class {
    func signalBasketUpdate()
}

class SummaryViewController: UIViewController, CurrencyDelegate, UITableViewDelegate, UITableViewDataSource {
    
    fileprivate let defaults = UserDefaults(suiteName: AppConstants.USERDEFAULTS.USER_DEFAULT_SUITE_NAME)!
    fileprivate let cellHeight: CGFloat = 68.0
    
    weak var productDelegate: ProductsDelegate?
    weak var basketDelegate: BasketDelegate?
    
    @IBOutlet weak var summaryTableView: UITableView!
    @IBOutlet weak var currencyChoiceBtnOutlet: UIButton!
    @IBOutlet weak var tableViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var totalSummaryPrice: UILabel!
    @IBOutlet weak var totalSummaryCurrency: UILabel!
    @IBOutlet weak var currencyLiteralLabel: UILabel!
    @IBOutlet weak var spacerLeftSpaceUpperConstraint: NSLayoutConstraint!
    
    var summaryVM = SummaryViewModel()
    
    override func viewDidLoad() {
        
        // set delegates
        self.summaryTableView.delegate = self
        self.summaryTableView.dataSource = self
        self.setLookAndFeel()
    self.currencyChoiceBtnOutlet.setTitle((self.summaryVM.basket?.basketCurrency.rawValue ?? AppConstants.DefaultValues.USD_Currency) + " >", for: .normal)
        
        self.setCurrencyForAllProducts()
        self.summaryVM.getNewestConversionFactor()
        self.summaryTableView.reloadData()
        
        // observer for productChoice-ViewModel callbacks
        NotificationCenter.default.addObserver(self, selector: #selector(ProductChoiceViewController.showAlert), name: NSNotification.Name.AlertNotif, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(ProductChoiceViewController.doTableViewReload), name: NSNotification.Name.TableViewReloadNotif, object: nil)
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
        self.currencyChoiceBtnOutlet.setTitle((self.summaryVM.basket?.basketCurrency.rawValue ?? AppConstants.DefaultValues.USD_Currency) + " >", for: .normal)
        // reload tableView with new conversion-factor
        DispatchQueue.main.async {
            self.summaryTableView.reloadData()
        }
    }
    
    deinit {
        // If your app supports iOS 8 or earlier, you need to manually
        // remove the observer from the center. In later versions
        // this is done automatically.
        NotificationCenter.default.removeObserver(self)
    }
    
    func setLookAndFeel() {
        switch AppConstants.FEATUREFLAG.DEVICE_MODEL_NAME {
        case Devices.IPhone5, Devices.IPhone5S, Devices.IPhone5C:
            self.spacerLeftSpaceUpperConstraint.constant = 195
        case Devices.IPhone6, Devices.IPhone6S, Devices.IPhone7, Devices.IPhone8:
            self.spacerLeftSpaceUpperConstraint.constant = 200
        case Devices.IPhone6Plus, Devices.IPhone6SPlus, Devices.IPhone7Plus, Devices.IPhone8Plus:
            self.spacerLeftSpaceUpperConstraint.constant = 205
        case Devices.IPhoneX:
            self.spacerLeftSpaceUpperConstraint.constant = 205
        default:
            self.spacerLeftSpaceUpperConstraint.constant = 195
        }
        self.summaryTableView.isScrollEnabled = false
        self.tableViewHeightConstraint.constant = CGFloat(self.summaryVM.basket?.itemsTypes?.count ?? 0) * cellHeight
    }
    
    // MARK: Segue method
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        switch segue.identifier! {
        case SegueNames.GoToCurrencyChoice.rawValue:
            if let currencySearchVC = segue.destination as? CurrenyChoiceTableViewController {
                currencySearchVC.delegate = self
                currencySearchVC.currentTag = 0
                currencySearchVC.title = "Currency Choice"
            } else {
                
            }
        default:
            break
        }
    }
    
    // MARK: TableView Delegate methods
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return cellHeight
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.summaryVM.basketProducts?.count ?? 0
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
        let tempProduct = self.summaryVM.basketProducts![indexPath.row]
        // 2nd: assign the product
        summaryCell.product = tempProduct
        let nrOfProducts = tempProduct.nrOfProducts
        summaryCell.nrOfProductsLabel.text = "\(nrOfProducts)"
        //43rd: calculateConversion (order matters!)
        summaryCell.calculateConversion(conversionFactor: self.summaryVM.conversionFactor)
        
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

        self.summaryVM.setCurrencyForAllProducts()
        self.totalSummaryCurrency.text = self.summaryVM.basket?.basketCurrency.rawValue ?? AppConstants.DefaultValues.USD_Currency
        self.currencyLiteralLabel.text = (self.summaryVM.basket?.basketCurrency.countryName ?? "United States Dollar") + ")"
    }
    
    func calculatePurchaseSummary() {
        let total = self.summaryVM.calculatePurchaseSummary()
        self.totalSummaryPrice.text = iKKHelperClass.setPriceText(price: total)
    }

    // MARK: Target-Actions
    
    @IBAction func currencyChoiceBtnPressed(_ sender: Any) {
        self.performSegue(withIdentifier: SegueNames.GoToCurrencyChoice.rawValue, sender: nil)
    }
    
    // MARK: Delegate callbacks
    
    func setBackDataNow(currency: Currency) {
        self.summaryVM.basket?.basketCurrency = currency
        self.currencyChoiceBtnOutlet.setTitle(currency.rawValue + " >", for: .normal)
        self.setCurrencyForAllProducts()
        self.summaryVM.getNewestConversionFactor()
    }
    
    @IBAction func backBtnPressed(_ sender: Any) {
        self.basketDelegate?.signalBasketUpdate()
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func continueShoppingBtnPressed(_ sender: Any) {
        self.productDelegate?.signalProductUpdate()
    self.presentingViewController?.presentingViewController?.dismiss(animated: true, completion: nil)
    }
}
