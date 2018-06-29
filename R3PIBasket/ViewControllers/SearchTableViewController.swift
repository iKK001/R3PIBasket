//
//  FirstViewController.swift
//  Chunder
//
//  Created by Stephan Korner on 18.11.17.
//  Copyright © 2017 Ideen Kaffee Korner. All rights reserved.
//

import UIKit

enum SearchBackType {
    case normalSearch
    case addButtonSearch(Int)
}

protocol BackDataDelegate: class {
    func setBackDataNow(sentBackData: (Int, String), searchType: SearchBackType)
}

class SearchTableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate {
    
    @IBOutlet weak var stationTableView: UITableView!

    @IBOutlet weak var suggestionInfoView: UIView!
    @IBOutlet weak var suggestionTitleLabel: UILabel!
    @IBOutlet weak var suggestionExplanation1Label: UILabel!
    @IBOutlet weak var suggestionExplanation2Label: UILabel!
    @IBOutlet weak var suggestionExplanation3Label: UILabel!
    
    weak var delegate: BackDataDelegate?
    
    private var resItems: [StationItem]?
    
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
        self.suggestionInfoView.backgroundColor = iKKHelperClass.UIColorFromRGB(AppConstants.COLORS.COLOR_SUGGESTION_BACKGROUND)
        self.suggestionTitleLabel.text = ""
        self.suggestionTitleLabel.attributedText = iKKHelperClass.attributedText(withString: "No location suggestions available !", boldString: "No location suggestions available !", font: self.suggestionTitleLabel.font)
        self.suggestionExplanation1Label.text = "If you want suggestions to appear, then you have two options :"
        self.suggestionExplanation2Label.text = ""
        self.suggestionExplanation2Label.attributedText = iKKHelperClass.attributedText(withString: "a) go online", boldString: "go online", font: self.suggestionExplanation2Label.font)
        self.suggestionExplanation3Label.text = ""
        self.suggestionExplanation3Label.attributedText = iKKHelperClass.attributedText(withString: "b) download the newest database-file for offline usage \r\n(..this can be done under the App's settings tab)", boldString: "download the newest database-file for offline usage", font: self.suggestionExplanation3Label.font)
        
        self.resItems?.removeAll()
        
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
        let sqliteQueries = SQLiteQueries()
        
        // if sbb.db-file available - check singleton version
        if sqliteQueries.checkIfValidStopIDSQLIsThere() {
            
            // if singleton is outdated, update with sql_db_version
            if let sql_db_version = sqliteQueries.readStopIDDBVersion() {
                let db_versionInstance = DBVersionSingleton.shared
                let singletonVersion = db_versionInstance.db_version
                switch singletonVersion {
                case .StopID_SQL_DB(let singleton_version):
                    if (singleton_version != sql_db_version) {
                        db_versionInstance.db_version = .StopID_SQL_DB(sql_db_version)
                    }
                default:
                    break
                }
            }
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
        searchBar?.tintColor = iKKHelperClass.UIColorFromRGB(AppConstants.COLORS.COLOR_TEXT)
        searchBar?.backgroundColor = iKKHelperClass.UIColorFromRGB(AppConstants.COLORS.COLOR_BACKGROUND)
        searchBar?.barTintColor = iKKHelperClass.UIColorFromRGB(AppConstants.COLORS.COLOR_BACKGROUND)
        // searchBar?.scopeButtonTitles = ["Switzerland", "World"]
        searchBar?.text = searchText
        let searchTextField = searchBar?.value(forKey: "_searchField") as? UITextField
        searchTextField?.backgroundColor = iKKHelperClass.UIColorFromRGB(AppConstants.COLORS.COLOR_CELL)
        searchTextField?.layer.cornerRadius = 10
        searchTextField?.layer.masksToBounds = true
        searchTextField?.clipsToBounds = true
        searchTextField?.font = UIFont.systemFont(ofSize: 20, weight: UIFont.Weight.regular)
        
        self.stationTableView.tableHeaderView = searchBar
        
        self.searchBar?.becomeFirstResponder()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        self.searchText = searchText
        if searchText != "" {
            self.fetchStationsData()
        } else {
            self.resItems?.removeAll()
            // relaod-TableView
            OperationQueue.main.addOperation {
                self.stationTableView.reloadSections(IndexSet(integer: 0), with: .automatic)
            }
        }
    }
    
    func fetchStationsData() {
        
        switch (self.searchBar!.selectedScopeButtonIndex) {
        case 0:
            let sqliteQueries = SQLiteQueries()
            
            // if sbb.db-file available - us it for stop_name search
            if sqliteQueries.checkIfValidStopIDSQLIsThere() {
                
                self.suggestionInfoView.isHidden = true
                // do the actual stop_name query
                sqliteQueries.getStationFromLocationsResult(searchTerm: self.searchText!, completionHandler: { (resItems, error) in
                    
                    guard error == nil else {
                        print(error?.localizedDescription ?? "")
                        return
                    }
                    // OpenData Locations station-results available: fill our array
                    self.resItems = resItems
                    // relaod-TableView
                    OperationQueue.main.addOperation {
                        self.stationTableView.reloadSections(IndexSet(integer: 0), with: .automatic)
                    }
                })
            } else {  // if no SQL-DB there, then try online...
                
                // if online: search OpenData-API
                if (iKKHelperClass.checkWiFi()) {
                    
                    self.suggestionInfoView.isHidden = true
                    
                    let openDataAPI = OPENDATAAPI()
                    
                    openDataAPI.getStationFromLocationsResult(searchTerm: self.searchText!, completionHandler: { (resItems, error) in
                        
                        guard error == nil else {
                            print(error?.localizedDescription ?? "")
                            return
                        }
                        
                        // OpenData Locations station-results available: fill our array
                        self.resItems = resItems
                        // relaod-TableView
                        OperationQueue.main.addOperation {
                            self.stationTableView.reloadSections(IndexSet(integer: 0), with: .automatic)
                        }
                    })
                } else { // if offline and now SQL-DB availabl: show suggestions
                    self.suggestionInfoView.isHidden = false
                }
            }
            // only one scopeButton active for now....
            // (problem: Google-API works but its result-struct is not compatible with the SBB one....)s
//        case 1:
//            // if online: search OpenData-API
//            if (iKKHelperClass.checkWiFi()) {
//
//                self.suggestionInfoView.isHidden = true
//
//                let googleAPI = GOOGLEAPI()
//
//                googleAPI.getStationFromTextSearchStationsResult(searchTerm: self.searchText!, completionHandler: { (resItems, error) in
//
//                    guard error == nil else {
//                        print(error?.localizedDescription ?? "")
//                        return
//                    }
//
//                    // Google TextSearch station-results available: fill our array
//                    self.resItems = resItems
//                    // relaod-TableView
//                    OperationQueue.main.addOperation {
//                        self.stationTableView.reloadSections(IndexSet(integer: 0), with: .automatic)
//                    }
//                })
//            } else {
//                // if offline and user still wants Worldwide: show suggestions
//                self.suggestionInfoView.isHidden = false
//            }
        default:
            let googleAPI = GOOGLEAPI()
            
            googleAPI.getStationFromTextSearchStationsResult(searchTerm: self.searchText!, completionHandler: { (resItems, error) in
                
                guard error == nil else {
                    print(error?.localizedDescription ?? "")
                    return
                }
                
                // Google TextSearch station-results available: fill our array
                self.resItems = resItems
                // relaod-TableView
                OperationQueue.main.addOperation {
                    self.stationTableView.reloadSections(IndexSet(integer: 0), with: .automatic)
                }
            })
        }
    }
    
    // MARK: SearchBar delegate methods
    
    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        self.resItems?.removeAll()
        self.fetchStationsData()
    }
    
    // MARK: TableView delegate methods
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        guard let resItems = resItems else {
            return 0
        }
        return resItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
        let cell = self.stationTableView.dequeueReusableCell(withIdentifier: "TextSearchCell") as? StationCustomTableViewCell

        // change look and feel....
        cell?.tintColor = iKKHelperClass.UIColorFromRGB(AppConstants.COLORS.COLOR_TEXT)
        cell?.backgroundColor = .clear
        cell?.selectionStyle = .none
        
        if let resItem = self.resItems?[indexPath.row] {
            cell?.stationItem = resItem
        }
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let cell = tableView.cellForRow(at: indexPath) as? StationCustomTableViewCell
        self.searchBar?.text = cell?.stationName.text
        self.delegate?.setBackDataNow(sentBackData: (self.currentTag, (cell?.stationName.text)!), searchType: self.backType!)
        self.didSelectCell = true
        self.navigationController?.popViewController(animated: true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        
        super.viewWillDisappear(animated)
        
        if self.isMovingFromParentViewController {
            if !self.didSelectCell {
                self.delegate?.setBackDataNow(sentBackData: (self.currentTag, self.searchText!), searchType: self.backType!)
            }
        }
    }
}
