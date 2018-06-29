//
//  CurrencyModelResult.swift
//  R3PIBasket
//
//  Created by Stephan Korner on 29.06.18.
//  Copyright © 2018 Ideen Kaffee Korner. All rights reserved.
//

import Foundation

struct CurrencyModelResult : Codable {
    
	let success : Bool?
	let terms : String?
	let privacy : String?
	let timestamp : Int?
	let source : String?
	let quotes : Quotes?

	enum CodingKeys: String, CodingKey {

		case success = "success"
		case terms = "terms"
		case privacy = "privacy"
		case timestamp = "timestamp"
		case source = "source"
		case quotes = "quotes"
	}
}
