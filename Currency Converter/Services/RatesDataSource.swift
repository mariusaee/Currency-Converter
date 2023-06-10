//
//  RatesDataSource.swift
//  Currency Converter
//
//  Created by Marius Malyshev on 10.06.2023.
//

import Foundation

final class RatesDataSource {
    static let shared = RatesDataSource()
    
    private init() {}
    
    private let networkManager = NetworkManager.shared
    private let userDefaults = UserDefaults.standard
        
    func getRates(completion: @escaping (_ rates: [Rate]) -> Void) {
        isRatesOutdated()
        ? updateRatesFromNetwork(completion: { rates in
            completion(rates)
        })
        : getRatesFromStorage(completion: { rates in
            completion(rates)
        })
    }
    
    private func updateRatesFromNetwork(completion: @escaping (_ rates: [Rate]) -> Void) {
        networkManager.getRates { rates in
            self.saveRatesToStorage(rates: rates)
            let sortedRates = self.getSortedRates(from: rates)
            completion(sortedRates)
            print("Rates updated from network")
        }
    }
    
    private func saveRatesToStorage(rates: [String : Double]) {
        userDefaults.set(Date().formatted(date: .complete, time: .omitted), forKey: Constants.UserDefaultsKeys.lastUpdate)
        userDefaults.set(rates, forKey: Constants.UserDefaultsKeys.ratesDict)
    }
    
    private func getRatesFromStorage(completion: @escaping (_ rates: [Rate]) -> Void) {
        let ratesDict = userDefaults.object(forKey: Constants.UserDefaultsKeys.ratesDict) as? [String : Double] ?? [:]
        let sortedRates = getSortedRates(from: ratesDict)
        completion(sortedRates)
        print("Rates got from storage")
    }
    
    private func isRatesOutdated() -> Bool {
        guard let lastUpdate = userDefaults.string(forKey: Constants.UserDefaultsKeys.lastUpdate) else { return true }
        let today = Date().formatted(date: .complete, time: .omitted)
        return today > lastUpdate
    }
    
    // TODO: - !DRY
    private func getSortedRates(from ratesDict: [String : Double]) -> [Rate] {
        let rates: [Rate]
        
        rates = ratesDict.map({ name, rateToUSD in
            Rate(name: name, rateToUSD: rateToUSD)
        })
        
        return rates.sorted { lhs, rhs in
            lhs.name < rhs.name
        }
    }
}
