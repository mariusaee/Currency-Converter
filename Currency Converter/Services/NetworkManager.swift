//
//  NetworkManager.swift
//  Currency Converter
//
//  Created by Marius Malyshev on 09.06.2023.
//

import Foundation

final class NetworkManager {
    static let shared = NetworkManager()
    
    private init() {}
        
    // func getRates(completion: @escaping (_ response: Response, _ rates: [Rate]) -> Void) {
    func getRates(completion: @escaping (_ rates: [String : Double]) -> Void) {

        guard let url = URL(string: Constants.Links.baseUSD) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, _, error) in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            
            guard let data = data else { return }

            do {
                let response = try JSONDecoder().decode(Response.self, from: data)
                guard response.success,
                      !response.rates.isEmpty
                else {
                    print("Bad response")
                    return
                }
                DispatchQueue.main.async {
                    completion(response.rates)
                }
            } catch let error {
                print("Error serialisation json", error.localizedDescription)
            }
        }.resume()
    }
}
