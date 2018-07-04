//
//  R3PIBasketTests.swift
//  R3PIBasketTests
//
//  Created by Stephan Korner on 29.06.18.
//  Copyright © 2018 Ideen Kaffee Korner. All rights reserved.
//

import XCTest
@testable import R3PIBasket

class R3PIBasketTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    // R3PIBasket Tests
    
    func testCurrencyConversionAPI() {
        
        let currencyFetcher = CurrencyPlayerFetcher()
        if iKKHelperClass.checkWiFi() {
            let access_key = AppConstants.APIKeys.CURRENCY_PLAYER_API_KEY
            let source = "USD"
            let currencies = "CHF"
            let format = "1"
            let inputTerms: [String:String] = [
                CurrenyPlayerAPIAttributes.access_key.rawValue:access_key,
                CurrenyPlayerAPIAttributes.source.rawValue:source,
                CurrenyPlayerAPIAttributes.currencies.rawValue:currencies,
                CurrenyPlayerAPIAttributes.format.rawValue:format
            ]
            var myResult: CurrencyModelResult? = nil
            var myError: Error? = nil
            let expectation1 = expectation(description: "Completed")
            currencyFetcher.fetchCurrency(inputTerms: inputTerms) { (myCurrencyResult, error) in
                
                // check for error
                guard error == nil else {
                    myError = error
                    expectation1.fulfill()
                    return
                }
                
                if let currencyRes = myCurrencyResult {
                    myResult = currencyRes
                    expectation1.fulfill()
                } else {
                    myError = JSONFetchError.objectSerialization(reason: "no results from server")
                    expectation1.fulfill()
                }
            }
            waitForExpectations(timeout: 2.0, handler: nil)
            XCTAssertNil(myError)
            XCTAssertNotNil(myResult)
            // since we are asking for CHF in this test-example
            XCTAssertNotNil(myResult?.quotes?.USDCHF)
            // since we are not asking for AED in this text-example
            XCTAssertNil(myResult?.quotes?.USDAED)
        }
    }
    
    func testCurrencyConversionFactorReception() {
        let currencyAPI = CurrencyPlayerAPI()
        if iKKHelperClass.checkWiFi() {
            var myError: Error? = nil
            var myResult: Float = 0.0
            
            var myCurrency: Currency = .USD
            let expectation1 = expectation(description: "Completed")
            currencyAPI.getConversionFactor(currency: myCurrency) { (conversionFactor, error) in
                guard error == nil else {
                    myError = error
                    expectation1.fulfill()
                    return
                }
                myResult = conversionFactor ?? 0.0
                expectation1.fulfill()
            }
            waitForExpectations(timeout: 2.0, handler: nil)
            XCTAssertNil(myError)
            XCTAssert(myResult == 1.0)
            
            myCurrency = .CHF
            let expectation2 = expectation(description: "Completed")
            currencyAPI.getConversionFactor(currency: myCurrency) { (conversionFactor, error) in
                
                guard error == nil else {
                    myError = error
                    expectation2.fulfill()
                    return
                }
                myResult = conversionFactor ?? 0.0
                expectation2.fulfill()
            }
            waitForExpectations(timeout: 2.0, handler: nil)
            XCTAssertNil(myError)
            XCTAssert(myResult != 1.0)
        }
    }
    
    func testPurchaseSummaryCalculation() {

        var total: Float = 0.0
        let myConversionFactor: Float = 1.23456789
        
        // define your test basket
        var myBasket: Basket = Basket()
        var myItems: [ProductName] = [ProductName]()
        var myProductAmounts: [ProductName: Int] = [ProductName: Int]()
        let myCurrency: Currency = .CHF
        myBasket.basketCurrency = myCurrency
        myItems.removeAll()
        myItems.append(.Peas)
        myItems.append(.Eggs)
        myItems.append(.Milk)
        myItems.append(.Beans)
        myBasket.itemsTypes = myItems
        myProductAmounts.removeAll()
        myProductAmounts[.Peas] = 12
        myProductAmounts[.Eggs] = 13
        myProductAmounts[.Milk] = 15
        myProductAmounts[.Beans] = 17
        myBasket.productAmounts = myProductAmounts
        
        // define ViewModel under test
        let summaryVM = SummaryViewModel()
        summaryVM.conversionFactor = myConversionFactor
        summaryVM.basket = myBasket
        let productHelper = ProductHelper()
        
        // define your test products
        summaryVM.basketProducts = productHelper.generateProductsFromBasketInUSD(basket: myBasket)
        
        // make the ViewModel's calculation
        total = summaryVM.calculatePurchaseSummary()
        
        // make your own calculation by hand
        let peasPrice = Float(myProductAmounts[.Peas]!) * Float(0.95)   // definition
        let eggsPrice = Float(myProductAmounts[.Eggs]!) * Float(2.10)   // definition
        let milkPrice = Float(myProductAmounts[.Milk]!) * Float(1.30)   // definition
        let beansPrice = Float(myProductAmounts[.Beans]!) * Float(0.73) // definition
        let calculationByHand: Float = Float((peasPrice + eggsPrice + milkPrice + beansPrice) * myConversionFactor)
        
        // make sure the two are equal
        XCTAssertEqual(calculationByHand, total, accuracy: 0.0000001)
    }
}
