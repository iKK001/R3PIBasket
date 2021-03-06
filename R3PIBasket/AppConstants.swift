//
//  AppConstants.swift
//  R3PIBasket
//
//  Created by Stephan Korner on 29.06.18.
//  Copyright © 2018 Ideen Kaffee Korner. All rights reserved.
//

import Foundation
import UIKit

// Notification Names
extension Notification.Name {
    static var AlertNotif: Notification.Name {
        return .init(rawValue: "AlertNotification")
    }
    static var TableViewReloadNotif: Notification.Name {
        return .init(rawValue: "TableViewReload")
    }
}

// Storyboard String definitions
enum SegueNames: String {
    case GoToCurrencyChoice = "goToCurrencyChoice"
    case GoToProductsChoice = "goToProductsChoice"
    case GoToBasket = "goToBasket"
    case GoToSummary = "goToSummary"
}

enum CellNames: String {
    case ProductChoiceCell = "ProductChoiceCell"
    case BasketCell = "BasketCell"
    case SummaryCell = "SummaryCell"
}

// Constants Definitions
struct AppConstants {
    
    struct DefaultValues {
        static let USD_Currency = "USD"
    }
    
    // feature flags
    struct FEATUREFLAG {
        
        static let DEVICE_MODEL_NAME = { () -> Devices in
            switch UIDevice.current.modelName {
            case Devices.Simulator:
                // set featureFlag for different form-factors to be simulated...
                return UIDevice.current.simulatorModelName
            default:
                // set featureFlag for different form-factors on actual device...
                return UIDevice.current.modelName
            }
        }()
    }
    
    // API keys definition
    struct APIKeys {
        static let CURRENCY_PLAYER_API_KEY = "03473b3bd92c474ec03b79d967bc7f99"
    }
    
    // color definitions
    struct COLORS {
        static let COLOR_BACKGROUND = UInt(0xdac8a3)
    }
    
    struct USERDEFAULTS {
        static let USER_DEFAULT_SUITE_NAME = "ch.ideenkaffee.UserDefaults"
        static let USER_DEFAULT_CURRENCY_CHOICE = "CurrencyChoice"
        static let USER_DEFAULT_NR_OF_ITMEMS_IN_BASKET = "NrOfItemsInBasket"
        static let USER_DEFAULT_BASKET_ITEM_TYPES = "BasketItemTypes"
        static let USER_DEFAULT_BASKET_PRODUCT_AMOUNT_KEY = "BasketProductAmountKey"
    }
}
