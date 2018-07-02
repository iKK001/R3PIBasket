//
//  CurrenyChoiceTableViewController.swift
//  R3PIBasket
//
//  Created by Stephan Korner on 29.06.18.
//  Copyright © 2017 Ideen Kaffee Korner. All rights reserved.
//

import UIKit

protocol CurrencyDelegate: class {
    func setBackDataNow(currency: Currency)
}

class CurrenyChoiceTableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    weak var delegate: CurrencyDelegate?
    
    private var currencies: [Currency]? = [Currency]()
    private var searchBar: UISearchBar?
    private var searchText: String?
    var currentTag: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // define delegates
        self.tableView.dataSource = self
        self.tableView.delegate = self

        // define look and feel of tableView
        self.tableView.backgroundColor = iKKHelperClass.UIColorFromRGB(AppConstants.COLORS.COLOR_BACKGROUND)
        self.tableView.separatorColor = .white
        self.tableView.allowsSelection = true
        
        // create searchBar
        if let searchT = self.searchText {
            self.createSearchBar(searchText: searchT)
        } else {
            self.createSearchBar(searchText: "")
        }
    }
    
    override var prefersStatusBarHidden: Bool {
        return false
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override var supportedInterfaceOrientations : UIInterfaceOrientationMask {
        return UIInterfaceOrientationMask.portrait
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func createSearchBar(searchText: String) {
        
        self.searchBar = UISearchBar(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 50))
        searchBar?.delegate = self
        searchBar?.showsScopeBar = true
        searchBar?.showsCancelButton = false
        // searchBar?.scopeButtonTitles = ["CurrencyPlayer", "Other"]
        searchBar?.text = searchText
        let searchTextField = searchBar?.value(forKey: "_searchField") as? UITextField
        searchTextField?.layer.cornerRadius = 10
        searchTextField?.layer.masksToBounds = true
        searchTextField?.clipsToBounds = true
        searchTextField?.font = UIFont.systemFont(ofSize: 20, weight: UIFont.Weight.regular)
        self.tableView.tableHeaderView = searchBar
        
        self.searchBar?.becomeFirstResponder()
        // fill all currencies at
        self.fetchCurrencies()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        self.searchText = searchText.uppercased()
        self.searchBar?.text = searchText.uppercased()
        self.fetchCurrencies()
    }
    
    // MARK: SearchBar delegate methods
    
    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        self.currencies?.removeAll()
        self.fetchCurrencies()
    }
    
    func fetchCurrencies() {
        
        switch (self.searchBar!.selectedScopeButtonIndex) {
        case 0:
            fallthrough // we only deal with one tab right now...
        default:
            // fill all currencies that fit the user-entry into memory
            var allCurrenciesStrArray = [Currency]()
            for all in Currency.allValues {
                if self.searchText != nil {
                    if all.rawValue.contains((self.searchText ?? "").uppercased()) {
                        allCurrenciesStrArray.append(all)
                    } else if self.searchText == "" {
                        allCurrenciesStrArray.append(all)
                    }
                } else {
                    allCurrenciesStrArray.append(all)
                }
            }
            self.currencies?.removeAll()
            self.currencies = allCurrenciesStrArray
            
            // relaod-TableView
            OperationQueue.main.addOperation {
                self.tableView.reloadSections(IndexSet(integer: 0), with: .automatic)
            }
        }
    }
    
    // MARK: TableView delegate methods
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        guard let currencies = self.currencies else {
            return 0
        }
        return currencies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "CurrencyCell") as? CurrencyCustomTableViewCell

        // change look and feel....
        cell?.backgroundColor = .clear
        cell?.selectionStyle = .none
        
        if let item = self.currencies?[indexPath.row] {
            cell?.currencyItem = item
        }
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if let currencyChoice = currencies?[indexPath.row] {
            self.searchBar?.text = currencyChoice.rawValue + "\t\t(" + currencyChoice.countryName + ")"
            self.delegate?.setBackDataNow(currency: currencyChoice)
        } else {
            self.delegate?.setBackDataNow(currency: Currency.USD)
        }
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func cancelBtnPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}
