//
//  NetworkManager.swift
//  Currency Converter
//
//  Created by Marius Malyshev on 09.06.2023.
//

import Foundation

class NetworkManager {
    static let shared = NetworkManager()
    
    private init() {}
        
    func getRates(completion: @escaping (_ rates: [RateModel]) -> Void) {
        guard let url = URL(string: Constants.baseUSD.rawValue) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, _, error) in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            
            guard let data = data else { return }
                        
            do {
                let decoder = JSONDecoder()
                let response = try decoder.decode(Response.self, from: data)
                let rates = self.getSortedRates(from: response)
                DispatchQueue.main.async {
                    completion(rates)
                }
            } catch let error {
                print("Error serialisation json", error.localizedDescription)
            }
        }.resume()
    }
    
    private func getSortedRates(from response: Response) -> [RateModel] {
        let rates: [RateModel]
        
        rates = response.rates.map({ (name, rateToUSD) in
            RateModel(name: name, rateToUSD: rateToUSD)
        })
        
        return rates.sorted { lhs, rhs in
            lhs.name < rhs.name
        }
    }
}
