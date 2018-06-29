//
//  CurrencyCustomTableViewCell.swift
//  R3PIBasket
//
//  Created by Stephan Korner on 29.06.18.
//  Copyright © 2017 Stephan Korner. All rights reserved.
//

import UIKit

class CurrencyCustomTableViewCell: UITableViewCell {

    @IBOutlet weak var currencyName: UILabel!
    
    var currencyItem: String! {
        didSet {
            self.currencyName.text = currencyItem
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
}
