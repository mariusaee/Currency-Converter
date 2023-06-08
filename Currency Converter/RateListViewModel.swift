//
//  RateListViewModel.swift
//  Currency Converter
//
//  Created by Marius Malyshev on 08.06.2023.
//

import Combine

class RateListViewModel: ObservableObject {
    @Published var currencies: [CurrencyModel] = [
        CurrencyModel(name: "USD", rateToUSD: 1.0),
        CurrencyModel(name: "EUR", rateToUSD: 0.85),
        CurrencyModel(name: "RUB", rateToUSD: 75.0),
        CurrencyModel(name: "CNY", rateToUSD: 6.5)
    ]
    
    func updateAmounts(from currency: CurrencyModel) {
        guard let baseAmount = Double(currency.amount) else { return }
        for index in 0..<currencies.count {
            if currencies[index].id != currency.id {
                let newAmount = (baseAmount / currency.rateToUSD) * currencies[index].rateToUSD
                currencies[index].amount = String(format: "%.2f", newAmount)
            }
        }
    }
}
