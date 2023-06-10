//
//  RateListViewModel.swift
//  Currency Converter
//
//  Created by Marius Malyshev on 08.06.2023.
//

import Foundation

protocol RateListViewModelProtocol {
    func updateAmounts(from currency: Rate)
    func getRates()
}

final class RateListViewModel: RateListViewModelProtocol, ObservableObject {
    
    private var dataSource = RatesDataSource.shared
    
    @Published var rates: [Rate] = []
    
    func getRates() {
        dataSource.getRates { rates in
            self.rates = rates
        }
    }
        
    func updateAmounts(from currency: Rate) {
        guard let baseAmount = Double(currency.amount) else { return }
        for index in 0..<rates.count {
            if rates[index].id != currency.id {
                let newAmount = (baseAmount / currency.rateToUSD) * rates[index].rateToUSD
                rates[index].amount = String(format: "%.2f", newAmount)
            }
        }
    }
}
