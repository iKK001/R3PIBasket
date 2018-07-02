//
//  Quotes.swift
//  R3PIBasket
//
//  Created by Stephan Korner on 29.06.18.
//  Copyright © 2018 Ideen Kaffee Korner. All rights reserved.
//

import Foundation

struct Quotes : Codable {
    
    let USDAED: Float?   // United Arab Emirates Dirham
    let USDAFN: Float?   // Afghan Afghani
    let USDALL: Float?   // Albanian Lek
    let USDAMD: Float?   // Armenian Dram
    let USDANG: Float?   // Netherlands Antillean Guilder
    let USDAOA: Float?   // Angolan Kwanza
    let USDARS: Float?   // Argentine Peso
    let USDAUD: Float?   // Australian Dollar
    let USDAWG: Float?   // Aruban Florin
    let USDAZN: Float?   // Azerbaijani Manat
    let USDBAM: Float?   // Bosnia-Herzegovina Convertible Mark
    let USDBBD: Float?   // Barbadian Dollar
    let USDBDT: Float?   // Bangladeshi Taka
    let USDBGN: Float?   // Bulgarian Lev
    let USDBHD: Float?   // Bahraini Dinar
    let USDBIF: Float?   // Burundian Franc
    let USDBMD: Float?   // Bermudan Dollar
    let USDBND: Float?   // Brunei Dollar
    let USDBOB: Float?   // Bolivian Boliviano
    let USDBRL: Float?   // Brazilian Real
    let USDBSD: Float?   // Bahamian Dollar
    let USDBTC: Float?   // Bitcoin
    let USDBTN: Float?   // Bhutanese Ngultrum
    let USDBWP: Float?   // Botswanan Pula
    let USDBYN: Float?   // Belarusian Ruble
    let USDBYR: Float?   // Belarusian Ruble
    let USDBZD: Float?   // Belize Dollar
    let USDCAD: Float?   // Canadian Dollar
    let USDCDF: Float?   // Congolese Franc
    let USDCHF: Float?   // Swiss Franc
    let USDCLF: Float?   // Chilean Unit of Account (UF)
    let USDCLP: Float?   // Chilean Peso
    let USDCNY: Float?   // Chinese Yuan
    let USDCOP: Float?   // Colombian Peso
    let USDCRC: Float?   // Costa Rican Colón
    let USDCUC: Float?   // Cuba Convertible Peso
    let USDCUP: Float?   // Cuban Peso
    let USDCVE: Float?   // Cape Verdean Escudo
    let USDCZK: Float?   // Czech Republic Koruna
    let USDDJF: Float?   // Djiboutian Franc
    let USDDKK: Float?   // Danish Krone
    let USDDOP: Float?   // Dominican Peso
    let USDDZD: Float?   // Algerian Dinar
    let USDEEK: Float?   // Estonian Kroon
    let USDEGP: Float?   // Egyptian Pound
    let USDERN: Float?   // Eritrean Nakfa
    let USDETB: Float?   // Ethiopian Birr
    let USDEUR: Float?   // Euro
    let USDFJD: Float?   // Fijian Dollar
    let USDFKP: Float?   // Falkland Islands Pound
    let USDGBP: Float?   // British Pound Sterling
    let USDGEL: Float?   // Georgian Lari
    let USDGGP: Float?   // Guernsey Pound
    let USDGHS: Float?   // Ghanaian Cedi
    let USDGIP: Float?   // Gibraltar Pound
    let USDGMD: Float?   // Gambian Dalasi
    let USDGNF: Float?   // Guinean Franc
    let USDGTQ: Float?   // Guatemalan Quetzal
    let USDGYD: Float?   // Guyanaese Dollar
    let USDHKD: Float?   // Hong Kong Dollar
    let USDHNL: Float?   // Honduran Lempira
    let USDHRK: Float?   // Croatian Kuna
    let USDHTG: Float?   // Haitian Gourde
    let USDHUF: Float?   // Hungarian Forint
    let USDIDR: Float?   // Indonesian Rupiah
    let USDILS: Float?   // Israeli New Sheqel
    let USDIMP: Float?   // Manx pound
    let USDINR: Float?   // Indian Rupee
    let USDIQD: Float?   // Iraqi Dinar
    let USDIRR: Float?   // Iranian Rial
    let USDISK: Float?   // Icelandic Króna
    let USDJEP: Float?   // Jersey Pound
    let USDJMD: Float?   // Jamaican Dollar
    let USDJOD: Float?   // Jordanian Dinar
    let USDJPY: Float?   // Japanese Yen
    let USDKES: Float?   // Kenyan Shilling
    let USDKGS: Float?   // Kyrgystani Som
    let USDKHR: Float?   // Cambodian Riel
    let USDKMF: Float?   // Comorian Franc
    let USDKPW: Float?   // North Korean Won
    let USDKRW: Float?   // South Korean Won
    let USDKWD: Float?   // Kuwaiti Dinar
    let USDKYD: Float?   // Cayman Islands Dollar
    let USDKZT: Float?   // Kazakhstani Tenge
    let USDLAK: Float?   // Laotian Kip
    let USDLBP: Float?   // Lebanese Pound
    let USDLKR: Float?   // Sri Lankan Rupee
    let USDLRD: Float?   // Liberian Dollar
    let USDLSL: Float?   // Lesotho Loti
    let USDLTL: Float?   // Lithuanian Litas
    let USDLVL: Float?   // Latvian Lats
    let USDLYD: Float?   // Libyan Dinar
    let USDMAD: Float?   // Moroccan Dirham
    let USDMDL: Float?   // Moldovan Leu
    let USDMGA: Float?   // Malagasy Ariary
    let USDMKD: Float?   // Macedonian Denar
    let USDMMK: Float?   // Myanma Kyat
    let USDMNT: Float?   // Mongolian Tugrik
    let USDMOP: Float?   // Macanese Pataca
    let USDMRO: Float?   // Mauritanian Ouguiya
    let USDMUR: Float?   // Mauritian Rupee
    let USDMVR: Float?   // Maldivian Rufiyaa
    let USDMWK: Float?   // Malawian Kwacha
    let USDMXN: Float?   // Mexican Peso
    let USDMYR: Float?   // Malaysian Ringgit
    let USDMZN: Float?   // Mozambican Metical
    let USDNAD: Float?   // Namibian Dollar
    let USDNGN: Float?   // Nigerian Naira
    let USDNIO: Float?   // Nicaraguan Córdoba
    let USDNOK: Float?   // Norwegian Krone
    let USDNPR: Float?   // Nepalese Rupee
    let USDNZD: Float?   // New Zealand Dollar
    let USDOMR: Float?   // Omani Rial
    let USDPAB: Float?   // Panamanian Balboa
    let USDPEN: Float?   // Peruvian Nuevo Sol
    let USDPGK: Float?   // Papua New Guinean Kina
    let USDPHP: Float?   // Philippine Peso
    let USDPKR: Float?   // Pakistani Rupee
    let USDPLN: Float?   // Polish Zloty
    let USDPYG: Float?   // Paraguayan Guarani
    let USDQAR: Float?   // Qatari Rial
    let USDRON: Float?   // Romanian Leu
    let USDRSD: Float?   // Serbian Dinar
    let USDRUB: Float?   // Russian Ruble
    let USDRWF: Float?   // Rwandan Franc
    let USDSAR: Float?   // Saudi Riyal
    let USDSBD: Float?   // Solomon Islands Dollar
    let USDSCR: Float?   // Seychellois Rupee
    let USDSDG: Float?   // Sudanese Pound
    let USDSEK: Float?   // Swedish Krona
    let USDSGD: Float?   // Singapore Dollar
    let USDSHP: Float?   // Saint Helena Pound
    let USDSLL: Float?   // Sierra Leonean Leone
    let USDSOS: Float?   // Somali Shilling
    let USDSRD: Float?   // Surinamese Dollar
    let USDSTD: Float?   // São Tomé and Príncipe Dobra
    let USDSVC: Float?   // Salvadoran Colón
    let USDSYP: Float?   // Syrian Pound
    let USDSZL: Float?   // Swazi Lilangeni
    let USDTHB: Float?   // Thai Baht
    let USDTJS: Float?   // Tajikistani Somoni
    let USDTMT: Float?   // Turkmenistani Manat
    let USDTND: Float?   // Tunisian Dinar
    let USDTOP: Float?   // Tongan Pa?anga
    let USDTRY: Float?   // Turkish Lira
    let USDTTD: Float?   // Trinidad and Tobago Dollar
    let USDTWD: Float?   // New Taiwan Dollar
    let USDTZS: Float?   // Tanzanian Shilling
    let USDUAH: Float?   // Ukrainian Hryvnia
    let USDUGX: Float?   // Ugandan Shilling
    let USDUSD: Float?   // United States Dollar
    let USDUYU: Float?   // Uruguayan Peso
    let USDUZS: Float?   // Uzbekistan Som
    let USDVEF: Float?   // Venezuelan Bolívar
    let USDVND: Float?   // Vietnamese Dong
    let USDVUV: Float?   // Vanuatu Vatu
    let USDWST: Float?   // Samoan Tala
    let USDXAF: Float?   // CFA Franc BEAC
    let USDXAG: Float?   // Silver (troy ounce)
    let USDXAU: Float?   // Gold (troy ounce)
    let USDXCD: Float?   // East Caribbean Dollar
    let USDXDR: Float?   // Special Drawing Rights
    let USDXOF: Float?   // CFA Franc BCEAO
    let USDXPF: Float?   // CFP Franc
    let USDYER: Float?   // Yemeni Rial
    let USDZAR: Float?   // South African Rand
    let USDZMK: Float?   // Zambian Kwacha (pre-2013)
    let USDZMW: Float?   // Zambian Kwacha
    let USDZWL: Float?   // Zimbabwean Dollar
    
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
    
    func getFirstNonNilValue() -> Float? {
        if self.USDAED != nil { return self.USDAED }
        if self.USDAFN != nil { return self.USDAFN }
        if self.USDALL != nil { return self.USDALL }
        if self.USDAMD != nil { return self.USDAMD }
        if self.USDANG != nil { return self.USDANG }
        if self.USDAOA != nil { return self.USDAOA }
        if self.USDARS != nil { return self.USDARS }
        if self.USDAUD != nil { return self.USDAUD }
        if self.USDAWG != nil { return self.USDAWG }
        if self.USDAZN != nil { return self.USDAZN }
        if self.USDBAM != nil { return self.USDBAM }
        if self.USDBBD != nil { return self.USDBBD }
        if self.USDBDT != nil { return self.USDBDT }
        if self.USDBGN != nil { return self.USDBGN }
        if self.USDBHD != nil { return self.USDBHD }
        if self.USDBIF != nil { return self.USDBIF }
        if self.USDBMD != nil { return self.USDBMD }
        if self.USDBND != nil { return self.USDBND }
        if self.USDBOB != nil { return self.USDBOB }
        if self.USDBRL != nil { return self.USDBRL }
        if self.USDBSD != nil { return self.USDBSD }
        if self.USDBTC != nil { return self.USDBTC }
        if self.USDBTN != nil { return self.USDBTN }
        if self.USDBWP != nil { return self.USDBWP }
        if self.USDBYN != nil { return self.USDBYN }
        if self.USDBYR != nil { return self.USDBYR }
        if self.USDBZD != nil { return self.USDBZD }
        if self.USDCAD != nil { return self.USDCAD }
        if self.USDCDF != nil { return self.USDCDF }
        if self.USDCHF != nil { return self.USDCHF }
        if self.USDCLF != nil { return self.USDCLF }
        if self.USDCLP != nil { return self.USDCLP }
        if self.USDCNY != nil { return self.USDCNY }
        if self.USDCOP != nil { return self.USDCOP }
        if self.USDCRC != nil { return self.USDCRC }
        if self.USDCUC != nil { return self.USDCUC }
        if self.USDCUP != nil { return self.USDCUP }
        if self.USDCVE != nil { return self.USDCVE }
        if self.USDCZK != nil { return self.USDCZK }
        if self.USDDJF != nil { return self.USDDJF }
        if self.USDDKK != nil { return self.USDDKK }
        if self.USDDOP != nil { return self.USDDOP }
        if self.USDDZD != nil { return self.USDDZD }
        if self.USDEEK != nil { return self.USDEEK }
        if self.USDEGP != nil { return self.USDEGP }
        if self.USDERN != nil { return self.USDERN }
        if self.USDETB != nil { return self.USDETB }
        if self.USDEUR != nil { return self.USDEUR }
        if self.USDFJD != nil { return self.USDFJD }
        if self.USDFKP != nil { return self.USDFKP }
        if self.USDGBP != nil { return self.USDGBP }
        if self.USDGEL != nil { return self.USDGEL }
        if self.USDGGP != nil { return self.USDGGP }
        if self.USDGHS != nil { return self.USDGHS }
        if self.USDGIP != nil { return self.USDGIP }
        if self.USDGMD != nil { return self.USDGMD }
        if self.USDGNF != nil { return self.USDGNF }
        if self.USDGTQ != nil { return self.USDGTQ }
        if self.USDGYD != nil { return self.USDGYD }
        if self.USDHKD != nil { return self.USDHKD }
        if self.USDHNL != nil { return self.USDHNL }
        if self.USDHRK != nil { return self.USDHRK }
        if self.USDHTG != nil { return self.USDHTG }
        if self.USDHUF != nil { return self.USDHUF }
        if self.USDIDR != nil { return self.USDIDR }
        if self.USDILS != nil { return self.USDILS }
        if self.USDIMP != nil { return self.USDIMP }
        if self.USDINR != nil { return self.USDINR }
        if self.USDIQD != nil { return self.USDIQD }
        if self.USDIRR != nil { return self.USDIRR }
        if self.USDISK != nil { return self.USDISK }
        if self.USDJEP != nil { return self.USDJEP }
        if self.USDJMD != nil { return self.USDJMD }
        if self.USDJOD != nil { return self.USDJOD }
        if self.USDJPY != nil { return self.USDJPY }
        if self.USDKES != nil { return self.USDKES }
        if self.USDKGS != nil { return self.USDKGS }
        if self.USDKHR != nil { return self.USDKHR }
        if self.USDKMF != nil { return self.USDKMF }
        if self.USDKPW != nil { return self.USDKPW }
        if self.USDKRW != nil { return self.USDKRW }
        if self.USDKWD != nil { return self.USDKWD }
        if self.USDKYD != nil { return self.USDKYD }
        if self.USDKZT != nil { return self.USDKZT }
        if self.USDLAK != nil { return self.USDLAK }
        if self.USDLBP != nil { return self.USDLBP }
        if self.USDLKR != nil { return self.USDLKR }
        if self.USDLRD != nil { return self.USDLRD }
        if self.USDLSL != nil { return self.USDLSL }
        if self.USDLTL != nil { return self.USDLTL }
        if self.USDLVL != nil { return self.USDLVL }
        if self.USDLYD != nil { return self.USDLYD }
        if self.USDMAD != nil { return self.USDMAD }
        if self.USDMDL != nil { return self.USDMDL }
        if self.USDMGA != nil { return self.USDMGA }
        if self.USDMKD != nil { return self.USDMKD }
        if self.USDMMK != nil { return self.USDMMK }
        if self.USDMNT != nil { return self.USDMNT }
        if self.USDMOP != nil { return self.USDMOP }
        if self.USDMRO != nil { return self.USDMRO }
        if self.USDMUR != nil { return self.USDMUR }
        if self.USDMVR != nil { return self.USDMVR }
        if self.USDMWK != nil { return self.USDMWK }
        if self.USDMXN != nil { return self.USDMXN }
        if self.USDMYR != nil { return self.USDMYR }
        if self.USDMZN != nil { return self.USDMZN }
        if self.USDNAD != nil { return self.USDNAD }
        if self.USDNGN != nil { return self.USDNGN }
        if self.USDNIO != nil { return self.USDNIO }
        if self.USDNOK != nil { return self.USDNOK }
        if self.USDNPR != nil { return self.USDNPR }
        if self.USDNZD != nil { return self.USDNZD }
        if self.USDOMR != nil { return self.USDOMR }
        if self.USDPAB != nil { return self.USDPAB }
        if self.USDPEN != nil { return self.USDPEN }
        if self.USDPGK != nil { return self.USDPGK }
        if self.USDPHP != nil { return self.USDPHP }
        if self.USDPKR != nil { return self.USDPKR }
        if self.USDPLN != nil { return self.USDPLN }
        if self.USDPYG != nil { return self.USDPYG }
        if self.USDQAR != nil { return self.USDQAR }
        if self.USDRON != nil { return self.USDRON }
        if self.USDRSD != nil { return self.USDRSD }
        if self.USDRUB != nil { return self.USDRUB }
        if self.USDRWF != nil { return self.USDRWF }
        if self.USDSAR != nil { return self.USDSAR }
        if self.USDSBD != nil { return self.USDSBD }
        if self.USDSCR != nil { return self.USDSCR }
        if self.USDSDG != nil { return self.USDSDG }
        if self.USDSEK != nil { return self.USDSEK }
        if self.USDSGD != nil { return self.USDSGD }
        if self.USDSHP != nil { return self.USDSHP }
        if self.USDSLL != nil { return self.USDSLL }
        if self.USDSOS != nil { return self.USDSOS }
        if self.USDSRD != nil { return self.USDSRD }
        if self.USDSTD != nil { return self.USDSTD }
        if self.USDSVC != nil { return self.USDSVC }
        if self.USDSYP != nil { return self.USDSYP }
        if self.USDSZL != nil { return self.USDSZL }
        if self.USDTHB != nil { return self.USDTHB }
        if self.USDTJS != nil { return self.USDTJS }
        if self.USDTMT != nil { return self.USDTMT }
        if self.USDTND != nil { return self.USDTND }
        if self.USDTOP != nil { return self.USDTOP }
        if self.USDTRY != nil { return self.USDTRY }
        if self.USDTTD != nil { return self.USDTTD }
        if self.USDTWD != nil { return self.USDTWD }
        if self.USDTZS != nil { return self.USDTZS }
        if self.USDUAH != nil { return self.USDUAH }
        if self.USDUGX != nil { return self.USDUGX }
        if self.USDUSD != nil { return self.USDUSD }
        if self.USDUYU != nil { return self.USDUYU }
        if self.USDUZS != nil { return self.USDUZS }
        if self.USDVEF != nil { return self.USDVEF }
        if self.USDVND != nil { return self.USDVND }
        if self.USDVUV != nil { return self.USDVUV }
        if self.USDWST != nil { return self.USDWST }
        if self.USDXAF != nil { return self.USDXAF }
        if self.USDXAG != nil { return self.USDXAG }
        if self.USDXAU != nil { return self.USDXAU }
        if self.USDXCD != nil { return self.USDXCD }
        if self.USDXDR != nil { return self.USDXDR }
        if self.USDXOF != nil { return self.USDXOF }
        if self.USDXPF != nil { return self.USDXPF }
        if self.USDYER != nil { return self.USDYER }
        if self.USDZAR != nil { return self.USDZAR }
        if self.USDZMK != nil { return self.USDZMK }
        if self.USDZMW != nil { return self.USDZMW }
        if self.USDZWL != nil { return self.USDZWL }
        return nil
    }
}


