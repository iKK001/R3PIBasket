//
//  iKKFunctions.swift
//  R3PIBasket
//
//  Created by Stephan Korner on 22.03.17.
//  Copyright © 2017 Stephan Korner. All rights reserved.
//

import UIKit
import Foundation

class iKKHelperClass {
    
    /**
    This function is called to create a UIColor from a RGB-value
    
    Usage:
    UIColorFromRGB(0xFFFFFF)
    
    - parameter rgbValue: rgbValue: (rgb value in HEX)
    
    - returns: UIColor
    */
    static func UIColorFromRGB(_ rgbValue: UInt) -> UIColor {
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
    
    static func attributedText(withString string: String, boldString: String, font: UIFont) -> NSAttributedString {
        let attributedString = NSMutableAttributedString(string: string,
                                                         attributes: [NSAttributedStringKey.font: font])
        let boldFontAttribute: [NSAttributedStringKey: Any] = [NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: font.pointSize)]
        let range = (string as NSString).range(of: boldString)
        attributedString.addAttributes(boldFontAttribute, range: range)
        return attributedString
    }

	static func checkWiFi() -> Bool {
		
		let networkStatus = Reachability().connectionStatus()
		switch networkStatus {
		case .Unknown, .Offline:
			return false
		case .Online(.WWAN):
			// print("Connected via WWAN")
			return true
		case .Online(.WiFi):
			// print("Connected via WiFi")
			return true
		}
	}
    
    static func pad(string : String, toSize: Int) -> String {
        var padded = string
        for _ in 0..<(toSize - string.count) {
            padded = "0" + padded
        }
        return padded
    }
}
