//
//  CurrencyPlayerFetcher.swift
//  R3PIBasket
//
//  Created by Stephan Korner on 29.06.18.
//  Copyright © 2017 Ideen Kaffee Korner. All rights reserved.
//

import Foundation

enum CurrenyPlayerAPIAttributes: String {
    case access_key = "access_key"
    case source = "source"
    case currencies = "currencies"
    case format = "format"
}

class CurrencyPlayerFetcher {
    
    func fetchCurrency(inputTerms: [String:String], completionHandler: ((CurrencyModelResult?, Error?) -> Void)? ) {
        
        guard let myUrl = self.createURLWithComponents(inputTerms: inputTerms) else {
            print("Error: cannot create URL")
            let error = JSONFetchError.urlError(reason: "Could not construct URL")
            completionHandler?(nil, error)
            return
        }
        var myRequest = URLRequest(url: myUrl)
        myRequest.httpMethod = "GET"
        myRequest.setValue("application/json; charset=UTF-8", forHTTPHeaderField: "Content-Type")
        myRequest.cachePolicy = .reloadIgnoringLocalAndRemoteCacheData
        
        let myConfiguration = URLSessionConfiguration.default
        let session = URLSession(configuration: myConfiguration, delegate: nil, delegateQueue: OperationQueue.main)
        
        // print(myRequest.description)
        let myTask = session.dataTask(with: myRequest) { (data, response, error) in
            
            // check for error
            guard error == nil else {
                completionHandler?(nil, error!)
                return
            }
            
            // make sure we got data in the response
            guard let responseData = data else {
                let error = JSONFetchError.objectSerialization(reason: "No data in response")
                completionHandler?(nil, error)
                return
            }
            // Decode retrived data with JSONDecoder and assing type of Station object
            let decoder = JSONDecoder()
            do {
                let fetchedCurrency = try decoder.decode(CurrencyModelResult.self, from: responseData)
                if fetchedCurrency.quotes != nil {
                    completionHandler?(fetchedCurrency, nil)
                } else {
                    let error = JSONFetchError.objectSerialization(reason: "Could not get Currency Conversion Data")
                    completionHandler?(nil, error)
                }
            } catch {
                completionHandler?(nil, error)
            }
        }
        myTask.resume()
    }
    
    // MARK: Helper URLS Functions
    
    private func createURLWithComponents(inputTerms: [String:String]) -> URL? {
        
        let urlComponents = NSURLComponents()
        urlComponents.scheme = "http";
        urlComponents.host = "apilayer.net";
        urlComponents.path = "/api/live";
        urlComponents.queryItems = [
            URLQueryItem(name: CurrenyPlayerAPIAttributes.access_key.rawValue, value: inputTerms[CurrenyPlayerAPIAttributes.access_key.rawValue]),
            URLQueryItem(name: CurrenyPlayerAPIAttributes.source.rawValue, value: inputTerms[CurrenyPlayerAPIAttributes.source.rawValue]),
            URLQueryItem(name: CurrenyPlayerAPIAttributes.currencies.rawValue, value: inputTerms[CurrenyPlayerAPIAttributes.currencies.rawValue]),
            URLQueryItem(name: CurrenyPlayerAPIAttributes.format.rawValue, value: inputTerms[CurrenyPlayerAPIAttributes.format.rawValue])
        ]
        return urlComponents.url
    }
}

