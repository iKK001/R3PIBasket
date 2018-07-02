//
//  Quotes.swift
//  R3PIBasket
//
//  Created by Stephan Korner on 29.06.18.
//  Copyright © 2018 Ideen Kaffee Korner. All rights reserved.
//

import Foundation

struct Quotes : Codable {
    
    let USDAED: Double?   // United Arab Emirates Dirham
    let USDAFN: Double?   // Afghan Afghani
    let USDALL: Double?   // Albanian Lek
    let USDAMD: Double?   // Armenian Dram
    let USDANG: Double?   // Netherlands Antillean Guilder
    let USDAOA: Double?   // Angolan Kwanza
    let USDARS: Double?   // Argentine Peso
    let USDAUD: Double?   // Australian Dollar
    let USDAWG: Double?   // Aruban Florin
    let USDAZN: Double?   // Azerbaijani Manat
    let USDBAM: Double?   // Bosnia-Herzegovina Convertible Mark
    let USDBBD: Double?   // Barbadian Dollar
    let USDBDT: Double?   // Bangladeshi Taka
    let USDBGN: Double?   // Bulgarian Lev
    let USDBHD: Double?   // Bahraini Dinar
    let USDBIF: Double?   // Burundian Franc
    let USDBMD: Double?   // Bermudan Dollar
    let USDBND: Double?   // Brunei Dollar
    let USDBOB: Double?   // Bolivian Boliviano
    let USDBRL: Double?   // Brazilian Real
    let USDBSD: Double?   // Bahamian Dollar
    let USDBTC: Double?   // Bitcoin
    let USDBTN: Double?   // Bhutanese Ngultrum
    let USDBWP: Double?   // Botswanan Pula
    let USDBYN: Double?   // Belarusian Ruble
    let USDBYR: Double?   // Belarusian Ruble
    let USDBZD: Double?   // Belize Dollar
    let USDCAD: Double?   // Canadian Dollar
    let USDCDF: Double?   // Congolese Franc
    let USDCHF: Double?   // Swiss Franc
    let USDCLF: Double?   // Chilean Unit of Account (UF)
    let USDCLP: Double?   // Chilean Peso
    let USDCNY: Double?   // Chinese Yuan
    let USDCOP: Double?   // Colombian Peso
    let USDCRC: Double?   // Costa Rican Colón
    let USDCUC: Double?   // Cuba Convertible Peso
    let USDCUP: Double?   // Cuban Peso
    let USDCVE: Double?   // Cape Verdean Escudo
    let USDCZK: Double?   // Czech Republic Koruna
    let USDDJF: Double?   // Djiboutian Franc
    let USDDKK: Double?   // Danish Krone
    let USDDOP: Double?   // Dominican Peso
    let USDDZD: Double?   // Algerian Dinar
    let USDEEK: Double?   // Estonian Kroon
    let USDEGP: Double?   // Egyptian Pound
    let USDERN: Double?   // Eritrean Nakfa
    let USDETB: Double?   // Ethiopian Birr
    let USDEUR: Double?   // Euro
    let USDFJD: Double?   // Fijian Dollar
    let USDFKP: Double?   // Falkland Islands Pound
    let USDGBP: Double?   // British Pound Sterling
    let USDGEL: Double?   // Georgian Lari
    let USDGGP: Double?   // Guernsey Pound
    let USDGHS: Double?   // Ghanaian Cedi
    let USDGIP: Double?   // Gibraltar Pound
    let USDGMD: Double?   // Gambian Dalasi
    let USDGNF: Double?   // Guinean Franc
    let USDGTQ: Double?   // Guatemalan Quetzal
    let USDGYD: Double?   // Guyanaese Dollar
    let USDHKD: Double?   // Hong Kong Dollar
    let USDHNL: Double?   // Honduran Lempira
    let USDHRK: Double?   // Croatian Kuna
    let USDHTG: Double?   // Haitian Gourde
    let USDHUF: Double?   // Hungarian Forint
    let USDIDR: Double?   // Indonesian Rupiah
    let USDILS: Double?   // Israeli New Sheqel
    let USDIMP: Double?   // Manx pound
    let USDINR: Double?   // Indian Rupee
    let USDIQD: Double?   // Iraqi Dinar
    let USDIRR: Double?   // Iranian Rial
    let USDISK: Double?   // Icelandic Króna
    let USDJEP: Double?   // Jersey Pound
    let USDJMD: Double?   // Jamaican Dollar
    let USDJOD: Double?   // Jordanian Dinar
    let USDJPY: Double?   // Japanese Yen
    let USDKES: Double?   // Kenyan Shilling
    let USDKGS: Double?   // Kyrgystani Som
    let USDKHR: Double?   // Cambodian Riel
    let USDKMF: Double?   // Comorian Franc
    let USDKPW: Double?   // North Korean Won
    let USDKRW: Double?   // South Korean Won
    let USDKWD: Double?   // Kuwaiti Dinar
    let USDKYD: Double?   // Cayman Islands Dollar
    let USDKZT: Double?   // Kazakhstani Tenge
    let USDLAK: Double?   // Laotian Kip
    let USDLBP: Double?   // Lebanese Pound
    let USDLKR: Double?   // Sri Lankan Rupee
    let USDLRD: Double?   // Liberian Dollar
    let USDLSL: Double?   // Lesotho Loti
    let USDLTL: Double?   // Lithuanian Litas
    let USDLVL: Double?   // Latvian Lats
    let USDLYD: Double?   // Libyan Dinar
    let USDMAD: Double?   // Moroccan Dirham
    let USDMDL: Double?   // Moldovan Leu
    let USDMGA: Double?   // Malagasy Ariary
    let USDMKD: Double?   // Macedonian Denar
    let USDMMK: Double?   // Myanma Kyat
    let USDMNT: Double?   // Mongolian Tugrik
    let USDMOP: Double?   // Macanese Pataca
    let USDMRO: Double?   // Mauritanian Ouguiya
    let USDMUR: Double?   // Mauritian Rupee
    let USDMVR: Double?   // Maldivian Rufiyaa
    let USDMWK: Double?   // Malawian Kwacha
    let USDMXN: Double?   // Mexican Peso
    let USDMYR: Double?   // Malaysian Ringgit
    let USDMZN: Double?   // Mozambican Metical
    let USDNAD: Double?   // Namibian Dollar
    let USDNGN: Double?   // Nigerian Naira
    let USDNIO: Double?   // Nicaraguan Córdoba
    let USDNOK: Double?   // Norwegian Krone
    let USDNPR: Double?   // Nepalese Rupee
    let USDNZD: Double?   // New Zealand Dollar
    let USDOMR: Double?   // Omani Rial
    let USDPAB: Double?   // Panamanian Balboa
    let USDPEN: Double?   // Peruvian Nuevo Sol
    let USDPGK: Double?   // Papua New Guinean Kina
    let USDPHP: Double?   // Philippine Peso
    let USDPKR: Double?   // Pakistani Rupee
    let USDPLN: Double?   // Polish Zloty
    let USDPYG: Double?   // Paraguayan Guarani
    let USDQAR: Double?   // Qatari Rial
    let USDRON: Double?   // Romanian Leu
    let USDRSD: Double?   // Serbian Dinar
    let USDRUB: Double?   // Russian Ruble
    let USDRWF: Double?   // Rwandan Franc
    let USDSAR: Double?   // Saudi Riyal
    let USDSBD: Double?   // Solomon Islands Dollar
    let USDSCR: Double?   // Seychellois Rupee
    let USDSDG: Double?   // Sudanese Pound
    let USDSEK: Double?   // Swedish Krona
    let USDSGD: Double?   // Singapore Dollar
    let USDSHP: Double?   // Saint Helena Pound
    let USDSLL: Double?   // Sierra Leonean Leone
    let USDSOS: Double?   // Somali Shilling
    let USDSRD: Double?   // Surinamese Dollar
    let USDSTD: Double?   // São Tomé and Príncipe Dobra
    let USDSVC: Double?   // Salvadoran Colón
    let USDSYP: Double?   // Syrian Pound
    let USDSZL: Double?   // Swazi Lilangeni
    let USDTHB: Double?   // Thai Baht
    let USDTJS: Double?   // Tajikistani Somoni
    let USDTMT: Double?   // Turkmenistani Manat
    let USDTND: Double?   // Tunisian Dinar
    let USDTOP: Double?   // Tongan Pa?anga
    let USDTRY: Double?   // Turkish Lira
    let USDTTD: Double?   // Trinidad and Tobago Dollar
    let USDTWD: Double?   // New Taiwan Dollar
    let USDTZS: Double?   // Tanzanian Shilling
    let USDUAH: Double?   // Ukrainian Hryvnia
    let USDUGX: Double?   // Ugandan Shilling
    let USDUSD: Double?   // United States Dollar
    let USDUYU: Double?   // Uruguayan Peso
    let USDUZS: Double?   // Uzbekistan Som
    let USDVEF: Double?   // Venezuelan Bolívar
    let USDVND: Double?   // Vietnamese Dong
    let USDVUV: Double?   // Vanuatu Vatu
    let USDWST: Double?   // Samoan Tala
    let USDXAF: Double?   // CFA Franc BEAC
    let USDXAG: Double?   // Silver (troy ounce)
    let USDXAU: Double?   // Gold (troy ounce)
    let USDXCD: Double?   // East Caribbean Dollar
    let USDXDR: Double?   // Special Drawing Rights
    let USDXOF: Double?   // CFA Franc BCEAO
    let USDXPF: Double?   // CFP Franc
    let USDYER: Double?   // Yemeni Rial
    let USDZAR: Double?   // South African Rand
    let USDZMK: Double?   // Zambian Kwacha (pre-2013)
    let USDZMW: Double?   // Zambian Kwacha
    let USDZWL: Double?   // Zimbabwean Dollar
    
    enum CodingKeys: String, CodingKey {
        case USDAED = "USDAED"   // United Arab Emirates Dirham
        case USDAFN = "USDAFN"   // Afghan Afghani
        case USDALL = "USDALL"   // Albanian Lek
        case USDAMD = "USDAMD"   // Armenian Dram
        case USDANG = "USDANG"   // Netherlands Antillean Guilder
        case USDAOA = "USDAOA"   // Angolan Kwanza
        case USDARS = "USDARS"   // Argentine Peso
        case USDAUD = "USDAUD"   // Australian Dollar
        case USDAWG = "USDAWG"   // Aruban Florin
        case USDAZN = "USDAZN"   // Azerbaijani Manat
        case USDBAM = "USDBAM"   // Bosnia-Herzegovina Convertible Mark
        case USDBBD = "USDBBD"   // Barbadian Dollar
        case USDBDT = "USDBDT"   // Bangladeshi Taka
        case USDBGN = "USDBGN"   // Bulgarian Lev
        case USDBHD = "USDBHD"   // Bahraini Dinar
        case USDBIF = "USDBIF"   // Burundian Franc
        case USDBMD = "USDBMD"   // Bermudan Dollar
        case USDBND = "USDBND"   // Brunei Dollar
        case USDBOB = "USDBOB"   // Bolivian Boliviano
        case USDBRL = "USDBRL"   // Brazilian Real
        case USDBSD = "USDBSD"   // Bahamian Dollar
        case USDBTC = "USDBTC"   // Bitcoin
        case USDBTN = "USDBTN"   // Bhutanese Ngultrum
        case USDBWP = "USDBWP"   // Botswanan Pula
        case USDBYN = "USDBYN"   // Belarusian Ruble
        case USDBYR = "USDBYR"   // Belarusian Ruble
        case USDBZD = "USDBZD"   // Belize Dollar
        case USDCAD = "USDCAD"   // Canadian Dollar
        case USDCDF = "USDCDF"   // Congolese Franc
        case USDCHF = "USDCHF"   // Swiss Franc
        case USDCLF = "USDCLF"   // Chilean Unit of Account (UF)
        case USDCLP = "USDCLP"   // Chilean Peso
        case USDCNY = "USDCNY"   // Chinese Yuan
        case USDCOP = "USDCOP"   // Colombian Peso
        case USDCRC = "USDCRC"   // Costa Rican Colón
        case USDCUC = "USDCUC"   // Cuba Convertible Peso
        case USDCUP = "USDCUP"   // Cuban Peso
        case USDCVE = "USDCVE"   // Cape Verdean Escudo
        case USDCZK = "USDCZK"   // Czech Republic Koruna
        case USDDJF = "USDDJF"   // Djiboutian Franc
        case USDDKK = "USDDKK"   // Danish Krone
        case USDDOP = "USDDOP"   // Dominican Peso
        case USDDZD = "USDDZD"   // Algerian Dinar
        case USDEEK = "USDEEK"   // Estonian Kroon
        case USDEGP = "USDEGP"   // Egyptian Pound
        case USDERN = "USDERN"   // Eritrean Nakfa
        case USDETB = "USDETB"   // Ethiopian Birr
        case USDEUR = "USDEUR"   // Euro
        case USDFJD = "USDFJD"   // Fijian Dollar
        case USDFKP = "USDFKP"   // Falkland Islands Pound
        case USDGBP = "USDGBP"   // British Pound Sterling
        case USDGEL = "USDGEL"   // Georgian Lari
        case USDGGP = "USDGGP"   // Guernsey Pound
        case USDGHS = "USDGHS"   // Ghanaian Cedi
        case USDGIP = "USDGIP"   // Gibraltar Pound
        case USDGMD = "USDGMD"   // Gambian Dalasi
        case USDGNF = "USDGNF"   // Guinean Franc
        case USDGTQ = "USDGTQ"   // Guatemalan Quetzal
        case USDGYD = "USDGYD"   // Guyanaese Dollar
        case USDHKD = "USDHKD"   // Hong Kong Dollar
        case USDHNL = "USDHNL"   // Honduran Lempira
        case USDHRK = "USDHRK"   // Croatian Kuna
        case USDHTG = "USDHTG"   // Haitian Gourde
        case USDHUF = "USDHUF"   // Hungarian Forint
        case USDIDR = "USDIDR"   // Indonesian Rupiah
        case USDILS = "USDILS"   // Israeli New Sheqel
        case USDIMP = "USDIMP"   // Manx pound
        case USDINR = "USDINR"   // Indian Rupee
        case USDIQD = "USDIQD"   // Iraqi Dinar
        case USDIRR = "USDIRR"   // Iranian Rial
        case USDISK = "USDISK"   // Icelandic Króna
        case USDJEP = "USDJEP"   // Jersey Pound
        case USDJMD = "USDJMD"   // Jamaican Dollar
        case USDJOD = "USDJOD"   // Jordanian Dinar
        case USDJPY = "USDJPY"   // Japanese Yen
        case USDKES = "USDKES"   // Kenyan Shilling
        case USDKGS = "USDKGS"   // Kyrgystani Som
        case USDKHR = "USDKHR"   // Cambodian Riel
        case USDKMF = "USDKMF"   // Comorian Franc
        case USDKPW = "USDKPW"   // North Korean Won
        case USDKRW = "USDKRW"   // South Korean Won
        case USDKWD = "USDKWD"   // Kuwaiti Dinar
        case USDKYD = "USDKYD"   // Cayman Islands Dollar
        case USDKZT = "USDKZT"   // Kazakhstani Tenge
        case USDLAK = "USDLAK"   // Laotian Kip
        case USDLBP = "USDLBP"   // Lebanese Pound
        case USDLKR = "USDLKR"   // Sri Lankan Rupee
        case USDLRD = "USDLRD"   // Liberian Dollar
        case USDLSL = "USDLSL"   // Lesotho Loti
        case USDLTL = "USDLTL"   // Lithuanian Litas
        case USDLVL = "USDLVL"   // Latvian Lats
        case USDLYD = "USDLYD"   // Libyan Dinar
        case USDMAD = "USDMAD"   // Moroccan Dirham
        case USDMDL = "USDMDL"   // Moldovan Leu
        case USDMGA = "USDMGA"   // Malagasy Ariary
        case USDMKD = "USDMKD"   // Macedonian Denar
        case USDMMK = "USDMMK"   // Myanma Kyat
        case USDMNT = "USDMNT"   // Mongolian Tugrik
        case USDMOP = "USDMOP"   // Macanese Pataca
        case USDMRO = "USDMRO"   // Mauritanian Ouguiya
        case USDMUR = "USDMUR"   // Mauritian Rupee
        case USDMVR = "USDMVR"   // Maldivian Rufiyaa
        case USDMWK = "USDMWK"   // Malawian Kwacha
        case USDMXN = "USDMXN"   // Mexican Peso
        case USDMYR = "USDMYR"   // Malaysian Ringgit
        case USDMZN = "USDMZN"   // Mozambican Metical
        case USDNAD = "USDNAD"   // Namibian Dollar
        case USDNGN = "USDNGN"   // Nigerian Naira
        case USDNIO = "USDNIO"   // Nicaraguan Córdoba
        case USDNOK = "USDNOK"   // Norwegian Krone
        case USDNPR = "USDNPR"   // Nepalese Rupee
        case USDNZD = "USDNZD"   // New Zealand Dollar
        case USDOMR = "USDOMR"   // Omani Rial
        case USDPAB = "USDPAB"   // Panamanian Balboa
        case USDPEN = "USDPEN"   // Peruvian Nuevo Sol
        case USDPGK = "USDPGK"   // Papua New Guinean Kina
        case USDPHP = "USDPHP"   // Philippine Peso
        case USDPKR = "USDPKR"   // Pakistani Rupee
        case USDPLN = "USDPLN"   // Polish Zloty
        case USDPYG = "USDPYG"   // Paraguayan Guarani
        case USDQAR = "USDQAR"   // Qatari Rial
        case USDRON = "USDRON"   // Romanian Leu
        case USDRSD = "USDRSD"   // Serbian Dinar
        case USDRUB = "USDRUB"   // Russian Ruble
        case USDRWF = "USDRWF"   // Rwandan Franc
        case USDSAR = "USDSAR"   // Saudi Riyal
        case USDSBD = "USDSBD"   // Solomon Islands Dollar
        case USDSCR = "USDSCR"   // Seychellois Rupee
        case USDSDG = "USDSDG"   // Sudanese Pound
        case USDSEK = "USDSEK"   // Swedish Krona
        case USDSGD = "USDSGD"   // Singapore Dollar
        case USDSHP = "USDSHP"   // Saint Helena Pound
        case USDSLL = "USDSLL"   // Sierra Leonean Leone
        case USDSOS = "USDSOS"   // Somali Shilling
        case USDSRD = "USDSRD"   // Surinamese Dollar
        case USDSTD = "USDSTD"   // São Tomé and Príncipe Dobra
        case USDSVC = "USDSVC"   // Salvadoran Colón
        case USDSYP = "USDSYP"   // Syrian Pound
        case USDSZL = "USDSZL"   // Swazi Lilangeni
        case USDTHB = "USDTHB"   // Thai Baht
        case USDTJS = "USDTJS"   // Tajikistani Somoni
        case USDTMT = "USDTMT"   // Turkmenistani Manat
        case USDTND = "USDTND"   // Tunisian Dinar
        case USDTOP = "USDTOP"   // Tongan Pa?anga
        case USDTRY = "USDTRY"   // Turkish Lira
        case USDTTD = "USDTTD"   // Trinidad and Tobago Dollar
        case USDTWD = "USDTWD"   // New Taiwan Dollar
        case USDTZS = "USDTZS"   // Tanzanian Shilling
        case USDUAH = "USDUAH"   // Ukrainian Hryvnia
        case USDUGX = "USDUGX"   // Ugandan Shilling
        case USDUSD = "USDUSD"   // United States Dollar
        case USDUYU = "USDUYU"   // Uruguayan Peso
        case USDUZS = "USDUZS"   // Uzbekistan Som
        case USDVEF = "USDVEF"   // Venezuelan Bolívar
        case USDVND = "USDVND"   // Vietnamese Dong
        case USDVUV = "USDVUV"   // Vanuatu Vatu
        case USDWST = "USDWST"   // Samoan Tala
        case USDXAF = "USDXAF"   // CFA Franc BEAC
        case USDXAG = "USDXAG"   // Silver (troy ounce)
        case USDXAU = "USDXAU"   // Gold (troy ounce)
        case USDXCD = "USDXCD"   // East Caribbean Dollar
        case USDXDR = "USDXDR"   // Special Drawing Rights
        case USDXOF = "USDXOF"   // CFA Franc BCEAO
        case USDXPF = "USDXPF"   // CFP Franc
        case USDYER = "USDYER"   // Yemeni Rial
        case USDZAR = "USDZAR"   // South African Rand
        case USDZMK = "USDZMK"   // Zambian Kwacha (pre-2013)
        case USDZMW = "USDZMW"   // Zambian Kwacha
        case USDZWL = "USDZWL"   // Zimbabwean Dollar
    }
}


