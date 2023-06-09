//
//  RateListViewModel.swift
//  Currency Converter
//
//  Created by Marius Malyshev on 08.06.2023.
//

import Foundation

protocol RateListViewModelProtocol {
    func updateAmounts(from currency: RateModel)
    func getResponse()
    func getRates(from response: Response)
}

class RateListViewModel: RateListViewModelProtocol, ObservableObject {
    
    private var networkManager = NetworkManager.shared
    
    @Published var currencies: [RateModel] = [
        RateModel(name: "USD", rateToUSD: 1.0),
        RateModel(name: "EUR", rateToUSD: 0.85),
        RateModel(name: "RUB", rateToUSD: 75.0),
        RateModel(name: "CNY", rateToUSD: 6.5)
    ]
    
    func getResponse() {
        networkManager.getRates { rates in
            self.currencies = rates
        }
    }
    
    func getRates(from response: Response) {
        let ratesDict = response.rates
        for rate in ratesDict {
            currencies.append(RateModel(name: rate.key, rateToUSD: rate.value))
        }
    }
    
    func updateAmounts(from currency: RateModel) {
        guard let baseAmount = Double(currency.amount) else { return }
        for index in 0..<currencies.count {
            if currencies[index].id != currency.id {
                let newAmount = (baseAmount / currency.rateToUSD) * currencies[index].rateToUSD
                currencies[index].amount = String(format: "%.2f", newAmount)
            }
        }
    }
}
