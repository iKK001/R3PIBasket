//
//  iKKErrors.swift
//  R3PIBasket
//
//  Created by Stephan Korner on 19.06.18.
//  Copyright © 2017 Stephan Korner. All rights reserved.
//

import Foundation

enum JSONFetchError: Error {
    case urlError(reason: String)
    case objectSerialization(reason: String)
}

enum CurrencyConversionError: Error {
    case conversionError(reason: String)
    case objectSerialization(reason: String)
}


