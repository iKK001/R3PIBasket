//
//  CurrenyChoiceTableViewController.swift
//  R3PIBasket
//
//  Created by Stephan Korner on 29.06.18.
//  Copyright © 2017 Ideen Kaffee Korner. All rights reserved.
//

import UIKit

enum SearchBackType {
    case normalSearch
    case addButtonSearch(Int)
}

protocol CurrencyDelegate: class {
    func setBackDataNow(currency: Currency)
}

class CurrenyChoiceTableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate {
    
    @IBOutlet weak var stationTableView: UITableView!

    @IBOutlet weak var suggestionInfoView: UIView!
    @IBOutlet weak var suggestionTitleLabel: UILabel!
    @IBOutlet weak var suggestionExplanation1Label: UILabel!
    
    weak var delegate: CurrencyDelegate?
    
    private var currencies: [String]? = [String]()
    
    var searchBar: UISearchBar?
    var searchText: String?
    var currentTag: Int = 0
    var didSelectCell: Bool = false
    var backType: SearchBackType?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.navigationController?.navigationBar.tintColor = .blue
        
        self.suggestionInfoView.isHidden = true
        self.suggestionInfoView.backgroundColor = .yellow
        self.suggestionTitleLabel.text = ""
        self.suggestionTitleLabel.attributedText = iKKHelperClass.attributedText(withString: "No currency suggestions available !", boldString: "No currency suggestions available !", font: self.suggestionTitleLabel.font)
        
        self.currencies?.removeAll()
        
        // define delegates
        self.stationTableView.dataSource = self
        self.stationTableView.delegate = self

        // define look and feel of tableView
        self.stationTableView.backgroundColor = iKKHelperClass.UIColorFromRGB(AppConstants.COLORS.COLOR_BACKGROUND)
        self.stationTableView.separatorColor = .white
        self.stationTableView.allowsSelection = true
        
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
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.tintColor = .blue
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
        self.stationTableView.tableHeaderView = searchBar
        
        self.searchBar?.becomeFirstResponder()
        // fill all currencies at
        self.fetchCurrencies()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        self.searchText = searchText.uppercased()
        self.searchBar?.text = searchText.uppercased()
        self.fetchCurrencies()
    }
    
    func fetchCurrencies() {
        
        switch (self.searchBar!.selectedScopeButtonIndex) {
        case 0:
            fallthrough // we only deal with one tab right now...
        default:
            // fill all currencies that fit the user-entry into memory
            var allCurrenciesStrArray = [String]()
            for all in Currency.allValues {
                if self.searchText != nil {
                    if all.rawValue.contains((self.searchText ?? "").uppercased()) {
                        allCurrenciesStrArray.append(all.rawValue)
                    } else if self.searchText == "" {
                        allCurrenciesStrArray.append(all.rawValue)
                    }
                } else {
                    allCurrenciesStrArray.append(all.rawValue)
                }
            }
            self.currencies?.removeAll()
            self.currencies = allCurrenciesStrArray
            
            // relaod-TableView
            OperationQueue.main.addOperation {
                self.stationTableView.reloadSections(IndexSet(integer: 0), with: .automatic)
            }
        }
    }
    
    // MARK: SearchBar delegate methods
    
    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        self.currencies?.removeAll()
        self.fetchCurrencies()
    }
    
    // MARK: TableView delegate methods
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        guard let currencies = self.currencies else {
            return 0
        }
        return currencies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
        let cell = self.stationTableView.dequeueReusableCell(withIdentifier: "CurrencyCell") as? CurrencyCustomTableViewCell

        // change look and feel....
        cell?.backgroundColor = .clear
        cell?.selectionStyle = .none
        
        if let item = self.currencies?[indexPath.row] {
            cell?.currencyItem = item
        }
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let cell = tableView.cellForRow(at: indexPath) as? CurrencyCustomTableViewCell
        self.searchBar?.text = cell?.currencyItem
        self.delegate?.setBackDataNow(currency: Currency(rawValue: (cell?.currencyItem)!)!)
        self.didSelectCell = true
        self.dismiss(animated: true, completion: nil)
    }
}
