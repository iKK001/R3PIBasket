//
//  Currencies.swift
//  R3PIBasket
//
//  Created by Stephan Korner on 29.06.18.
//  Copyright © 2018 Ideen Kaffee Korner. All rights reserved.
//

import Foundation

enum Currency: String, EnumCollection {
    
    case AED = "AED"   // United Arab Emirates Dirham
    case AFN = "AFN"   // Afghan Afghani
    case ALL = "ALL"   // Albanian Lek
    case AMD = "AMD"   // Armenian Dram
    case ANG = "ANG"   // Netherlands Antillean Guilder
    case AOA = "AOA"   // Angolan Kwanza
    case ARS = "ARS"   // Argentine Peso
    case AUD = "AUD"   // Australian Dollar
    case AWG = "AWG"   // Aruban Florin
    case AZN = "AZN"   // Azerbaijani Manat
    case BAM = "BAM"   // Bosnia-Herzegovina Convertible Mark
    case BBD = "BBD"   // Barbadian Dollar
    case BDT = "BDT"   // Bangladeshi Taka
    case BGN = "BGN"   // Bulgarian Lev
    case BHD = "BHD"   // Bahraini Dinar
    case BIF = "BIF"   // Burundian Franc
    case BMD = "BMD"   // Bermudan Dollar
    case BND = "BND"   // Brunei Dollar
    case BOB = "BOB"   // Bolivian Boliviano
    case BRL = "BRL"   // Brazilian Real
    case BSD = "BSD"   // Bahamian Dollar
    case BTC = "BTC"   // Bitcoin
    case BTN = "BTN"   // Bhutanese Ngultrum
    case BWP = "BWP"   // Botswanan Pula
    case BYN = "BYN"   // Belarusian Ruble
    case BYR = "BYR"   // Belarusian Ruble
    case BZD = "BZD"   // Belize Dollar
    case CAD = "CAD"   // Canadian Dollar
    case CDF = "CDF"   // Congolese Franc
    case CHF = "CHF"   // Swiss Franc
    case CLF = "CLF"   // Chilean Unit of Account (UF)
    case CLP = "CLP"   // Chilean Peso
    case CNY = "CNY"   // Chinese Yuan
    case COP = "COP"   // Colombian Peso
    case CRC = "CRC"   // Costa Rican Colón
    case CUC = "CUC"   // Cuba Convertible Peso
    case CUP = "CUP"   // Cuban Peso
    case CVE = "CVE"   // Cape Verdean Escudo
    case CZK = "CZK"   // Czech Republic Koruna
    case DJF = "DJF"   // Djiboutian Franc
    case DKK = "DKK"   // Danish Krone
    case DOP = "DOP"   // Dominican Peso
    case DZD = "DZD"   // Algerian Dinar
    case EEK = "EEK"   // Estonian Kroon
    case EGP = "EGP"   // Egyptian Pound
    case ERN = "ERN"   // Eritrean Nakfa
    case ETB = "ETB"   // Ethiopian Birr
    case EUR = "EUR"   // Euro
    case FJD = "FJD"   // Fijian Dollar
    case FKP = "FKP"   // Falkland Islands Pound
    case GBP = "GBP"   // British Pound Sterling
    case GEL = "GEL"   // Georgian Lari
    case GGP = "GGP"   // Guernsey Pound
    case GHS = "GHS"   // Ghanaian Cedi
    case GIP = "GIP"   // Gibraltar Pound
    case GMD = "GMD"   // Gambian Dalasi
    case GNF = "GNF"   // Guinean Franc
    case GTQ = "GTQ"   // Guatemalan Quetzal
    case GYD = "GYD"   // Guyanaese Dollar
    case HKD = "HKD"   // Hong Kong Dollar
    case HNL = "HNL"   // Honduran Lempira
    case HRK = "HRK"   // Croatian Kuna
    case HTG = "HTG"   // Haitian Gourde
    case HUF = "HUF"   // Hungarian Forint
    case IDR = "IDR"   // Indonesian Rupiah
    case ILS = "ILS"   // Israeli New Sheqel
    case IMP = "IMP"   // Manx pound
    case INR = "INR"   // Indian Rupee
    case IQD = "IQD"   // Iraqi Dinar
    case IRR = "IRR"   // Iranian Rial
    case ISK = "ISK"   // Icelandic Króna
    case JEP = "JEP"   // Jersey Pound
    case JMD = "JMD"   // Jamaican Dollar
    case JOD = "JOD"   // Jordanian Dinar
    case JPY = "JPY"   // Japanese Yen
    case KES = "KES"   // Kenyan Shilling
    case KGS = "KGS"   // Kyrgystani Som
    case KHR = "KHR"   // Cambodian Riel
    case KMF = "KMF"   // Comorian Franc
    case KPW = "KPW"   // North Korean Won
    case KRW = "KRW"   // South Korean Won
    case KWD = "KWD"   // Kuwaiti Dinar
    case KYD = "KYD"   // Cayman Islands Dollar
    case KZT = "KZT"   // Kazakhstani Tenge
    case LAK = "LAK"   // Laotian Kip
    case LBP = "LBP"   // Lebanese Pound
    case LKR = "LKR"   // Sri Lankan Rupee
    case LRD = "LRD"   // Liberian Dollar
    case LSL = "LSL"   // Lesotho Loti
    case LTL = "LTL"   // Lithuanian Litas
    case LVL = "LVL"   // Latvian Lats
    case LYD = "LYD"   // Libyan Dinar
    case MAD = "MAD"   // Moroccan Dirham
    case MDL = "MDL"   // Moldovan Leu
    case MGA = "MGA"   // Malagasy Ariary
    case MKD = "MKD"   // Macedonian Denar
    case MMK = "MMK"   // Myanma Kyat
    case MNT = "MNT"   // Mongolian Tugrik
    case MOP = "MOP"   // Macanese Pataca
    case MRO = "MRO"   // Mauritanian Ouguiya
    case MUR = "MUR"   // Mauritian Rupee
    case MVR = "MVR"   // Maldivian Rufiyaa
    case MWK = "MWK"   // Malawian Kwacha
    case MXN = "MXN"   // Mexican Peso
    case MYR = "MYR"   // Malaysian Ringgit
    case MZN = "MZN"   // Mozambican Metical
    case NAD = "NAD"   // Namibian Dollar
    case NGN = "NGN"   // Nigerian Naira
    case NIO = "NIO"   // Nicaraguan Córdoba
    case NOK = "NOK"   // Norwegian Krone
    case NPR = "NPR"   // Nepalese Rupee
    case NZD = "NZD"   // New Zealand Dollar
    case OMR = "OMR"   // Omani Rial
    case PAB = "PAB"   // Panamanian Balboa
    case PEN = "PEN"   // Peruvian Nuevo Sol
    case PGK = "PGK"   // Papua New Guinean Kina
    case PHP = "PHP"   // Philippine Peso
    case PKR = "PKR"   // Pakistani Rupee
    case PLN = "PLN"   // Polish Zloty
    case PYG = "PYG"   // Paraguayan Guarani
    case QAR = "QAR"   // Qatari Rial
    case RON = "RON"   // Romanian Leu
    case RSD = "RSD"   // Serbian Dinar
    case RUB = "RUB"   // Russian Ruble
    case RWF = "RWF"   // Rwandan Franc
    case SAR = "SAR"   // Saudi Riyal
    case SBD = "SBD"   // Solomon Islands Dollar
    case SCR = "SCR"   // Seychellois Rupee
    case SDG = "SDG"   // Sudanese Pound
    case SEK = "SEK"   // Swedish Krona
    case SGD = "SGD"   // Singapore Dollar
    case SHP = "SHP"   // Saint Helena Pound
    case SLL = "SLL"   // Sierra Leonean Leone
    case SOS = "SOS"   // Somali Shilling
    case SRD = "SRD"   // Surinamese Dollar
    case STD = "STD"   // São Tomé and Príncipe Dobra
    case SVC = "SVC"   // Salvadoran Colón
    case SYP = "SYP"   // Syrian Pound
    case SZL = "SZL"   // Swazi Lilangeni
    case THB = "THB"   // Thai Baht
    case TJS = "TJS"   // Tajikistani Somoni
    case TMT = "TMT"   // Turkmenistani Manat
    case TND = "TND"   // Tunisian Dinar
    case TOP = "TOP"   // Tongan Pa?anga
    case TRY = "TRY"   // Turkish Lira
    case TTD = "TTD"   // Trinidad and Tobago Dollar
    case TWD = "TWD"   // New Taiwan Dollar
    case TZS = "TZS"   // Tanzanian Shilling
    case UAH = "UAH"   // Ukrainian Hryvnia
    case UGX = "UGX"   // Ugandan Shilling
    case USD = "USD"   // United States Dollar
    case UYU = "UYU"   // Uruguayan Peso
    case UZS = "UZS"   // Uzbekistan Som
    case VEF = "VEF"   // Venezuelan Bolívar
    case VND = "VND"   // Vietnamese Dong
    case VUV = "VUV"   // Vanuatu Vatu
    case WST = "WST"   // Samoan Tala
    case XAF = "XAF"   // CFA Franc BEAC
    case XAG = "XAG"   // Silver (troy ounce)
    case XAU = "XAU"   // Gold (troy ounce)
    case XCD = "XCD"   // East Caribbean Dollar
    case XDR = "XDR"   // Special Drawing Rights
    case XOF = "XOF"   // CFA Franc BCEAO
    case XPF = "XPF"   // CFP Franc
    case YER = "YER"   // Yemeni Rial
    case ZAR = "ZAR"   // South African Rand
    case ZMK = "ZMK"   // Zambian Kwacha (pre-2013)
    case ZMW = "ZMW"   // Zambian Kwacha
    case ZWL = "ZWL"   // Zimbabwean Dollar
}

extension Currency {
    
    var countryName: String {
        switch self {
        case .AED: return "United Arab Emirates Dirham"
        case .AFN: return "Afghan Afghani"
        case .ALL: return "Albanian Lek"
        case .AMD: return "Armenian Dram"
        case .ANG: return "Netherlands Antillean Guilder"
        case .AOA: return "Angolan Kwanza"
        case .ARS: return "Argentine Peso"
        case .AUD: return "Australian Dollar"
        case .AWG: return "Aruban Florin"
        case .AZN: return "Azerbaijani Manat"
        case .BAM: return "Bosnia-Herzegovina Convertible Mark"
        case .BBD: return "Barbadian Dollar"
        case .BDT: return "Bangladeshi Taka"
        case .BGN: return "Bulgarian Lev"
        case .BHD: return "Bahraini Dinar"
        case .BIF: return "Burundian Franc"
        case .BMD: return "Bermudan Dollar"
        case .BND: return "Brunei Dollar"
        case .BOB: return "Bolivian Boliviano"
        case .BRL: return "Brazilian Real"
        case .BSD: return "Bahamian Dollar"
        case .BTC: return "Bitcoin"
        case .BTN: return "Bhutanese Ngultrum"
        case .BWP: return "Botswanan Pula"
        case .BYN: return "Belarusian Ruble"
        case .BYR: return "Belarusian Ruble"
        case .BZD: return "Belize Dollar"
        case .CAD: return "Canadian Dollar"
        case .CDF: return "Congolese Franc"
        case .CHF: return "Swiss Franc"
        case .CLF: return "Chilean Unit of Account (UF)"
        case .CLP: return "Chilean Peso"
        case .CNY: return "Chinese Yuan"
        case .COP: return "Colombian Peso"
        case .CRC: return "Costa Rican Colón"
        case .CUC: return "Cuba Convertible Peso"
        case .CUP: return "Cuban Peso"
        case .CVE: return "Cape Verdean Escudo"
        case .CZK: return "Czech Republic Koruna"
        case .DJF: return "Djiboutian Franc"
        case .DKK: return "Danish Krone"
        case .DOP: return "Dominican Peso"
        case .DZD: return "Algerian Dinar"
        case .EEK: return "Estonian Kroon"
        case .EGP: return "Egyptian Pound"
        case .ERN: return "Eritrean Nakfa"
        case .ETB: return "Ethiopian Birr"
        case .EUR: return "Euro"
        case .FJD: return "Fijian Dollar"
        case .FKP: return "Falkland Islands Pound"
        case .GBP: return "British Pound Sterling"
        case .GEL: return "Georgian Lari"
        case .GGP: return "Guernsey Pound"
        case .GHS: return "Ghanaian Cedi"
        case .GIP: return "Gibraltar Pound"
        case .GMD: return "Gambian Dalasi"
        case .GNF: return "Guinean Franc"
        case .GTQ: return "Guatemalan Quetzal"
        case .GYD: return "Guyanaese Dollar"
        case .HKD: return "Hong Kong Dollar"
        case .HNL: return "Honduran Lempira"
        case .HRK: return "Croatian Kuna"
        case .HTG: return "Haitian Gourde"
        case .HUF: return "Hungarian Forint"
        case .IDR: return "Indonesian Rupiah"
        case .ILS: return "Israeli New Sheqel"
        case .IMP: return "Manx pound"
        case .INR: return "Indian Rupee"
        case .IQD: return "Iraqi Dinar"
        case .IRR: return "Iranian Rial"
        case .ISK: return "Icelandic Króna"
        case .JEP: return "Jersey Pound"
        case .JMD: return "Jamaican Dollar"
        case .JOD: return "Jordanian Dinar"
        case .JPY: return "Japanese Yen"
        case .KES: return "Kenyan Shilling"
        case .KGS: return "Kyrgystani Som"
        case .KHR: return "Cambodian Riel"
        case .KMF: return "Comorian Franc"
        case .KPW: return "North Korean Won"
        case .KRW: return "South Korean Won"
        case .KWD: return "Kuwaiti Dinar"
        case .KYD: return "Cayman Islands Dollar"
        case .KZT: return "Kazakhstani Tenge"
        case .LAK: return "Laotian Kip"
        case .LBP: return "Lebanese Pound"
        case .LKR: return "Sri Lankan Rupee"
        case .LRD: return "Liberian Dollar"
        case .LSL: return "Lesotho Loti"
        case .LTL: return "Lithuanian Litas"
        case .LVL: return "Latvian Lats"
        case .LYD: return "Libyan Dinar"
        case .MAD: return "Moroccan Dirham"
        case .MDL: return "Moldovan Leu"
        case .MGA: return "Malagasy Ariary"
        case .MKD: return "Macedonian Denar"
        case .MMK: return "Myanma Kyat"
        case .MNT: return "Mongolian Tugrik"
        case .MOP: return "Macanese Pataca"
        case .MRO: return "Mauritanian Ouguiya"
        case .MUR: return "Mauritian Rupee"
        case .MVR: return "Maldivian Rufiyaa"
        case .MWK: return "Malawian Kwacha"
        case .MXN: return "Mexican Peso"
        case .MYR: return "Malaysian Ringgit"
        case .MZN: return "Mozambican Metical"
        case .NAD: return "Namibian Dollar"
        case .NGN: return "Nigerian Naira"
        case .NIO: return "Nicaraguan Córdoba"
        case .NOK: return "Norwegian Krone"
        case .NPR: return "Nepalese Rupee"
        case .NZD: return "New Zealand Dollar"
        case .OMR: return "Omani Rial"
        case .PAB: return "Panamanian Balboa"
        case .PEN: return "Peruvian Nuevo Sol"
        case .PGK: return "Papua New Guinean Kina"
        case .PHP: return "Philippine Peso"
        case .PKR: return "Pakistani Rupee"
        case .PLN: return "Polish Zloty"
        case .PYG: return "Paraguayan Guarani"
        case .QAR: return "Qatari Rial"
        case .RON: return "Romanian Leu"
        case .RSD: return "Serbian Dinar"
        case .RUB: return "Russian Ruble"
        case .RWF: return "Rwandan Franc"
        case .SAR: return "Saudi Riyal"
        case .SBD: return "Solomon Islands Dollar"
        case .SCR: return "Seychellois Rupee"
        case .SDG: return "Sudanese Pound"
        case .SEK: return "Swedish Krona"
        case .SGD: return "Singapore Dollar"
        case .SHP: return "Saint Helena Pound"
        case .SLL: return "Sierra Leonean Leone"
        case .SOS: return "Somali Shilling"
        case .SRD: return "Surinamese Dollar"
        case .STD: return "São Tomé and Príncipe Dobra"
        case .SVC: return "Salvadoran Colón"
        case .SYP: return "Syrian Pound"
        case .SZL: return "Swazi Lilangeni"
        case .THB: return "Thai Baht"
        case .TJS: return "Tajikistani Somoni"
        case .TMT: return "Turkmenistani Manat"
        case .TND: return "Tunisian Dinar"
        case .TOP: return "Tongan Pa?anga"
        case .TRY: return "Turkish Lira"
        case .TTD: return "Trinidad and Tobago Dollar"
        case .TWD: return "New Taiwan Dollar"
        case .TZS: return "Tanzanian Shilling"
        case .UAH: return "Ukrainian Hryvnia"
        case .UGX: return "Ugandan Shilling"
        case .USD: return "United States Dollar"
        case .UYU: return "Uruguayan Peso"
        case .UZS: return "Uzbekistan Som"
        case .VEF: return "Venezuelan Bolívar"
        case .VND: return "Vietnamese Dong"
        case .VUV: return "Vanuatu Vatu"
        case .WST: return "Samoan Tala"
        case .XAF: return "CFA Franc BEAC"
        case .XAG: return "Silver (troy ounce)"
        case .XAU: return "Gold (troy ounce)"
        case .XCD: return "East Caribbean Dollar"
        case .XDR: return "Special Drawing Rights"
        case .XOF: return "CFA Franc BCEAO"
        case .XPF: return "CFP Franc"
        case .YER: return "Yemeni Rial"
        case .ZAR: return "South African Rand"
        case .ZMK: return "Zambian Kwacha (pre-2013)"
        case .ZMW: return "Zambian Kwacha"
        case .ZWL: return "Zimbabwean Dollar"
        // default: return "United States Dollar"
        }
    }
}
