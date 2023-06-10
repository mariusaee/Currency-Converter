//
//  Rate.swift
//  Currency Converter
//
//  Created by Marius Malyshev on 06.06.2023.
//

import Foundation

struct Response: Codable {
    var success: Bool
    var base: String
    var date: String
    var rates = [String: Double]()
}

struct Rate: Identifiable {
    let id = UUID()
    let name: String
    let rateToUSD: Double
    var amount: String = ""
}
