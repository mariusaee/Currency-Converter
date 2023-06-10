//
//  Constants.swift
//  Currency Converter
//
//  Created by Marius Malyshev on 09.06.2023.
//

struct Constants {
    struct Links {
        static let baseUSD = "https://api.exchangerate.host/latest?base=USD"
    }
    
    struct UserDefaultsKeys {
        static let lastUpdate = "lastUpdate"
        static let ratesDict = "ratesDict"
    }
}
