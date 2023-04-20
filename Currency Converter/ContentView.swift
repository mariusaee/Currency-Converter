//
//  ContentView.swift
//  Currency Converter
//
//  Created by Marius Malyshev on 20.04.2023.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        List() {
            RateView(rate: "USD")
            RateView(rate: "EUR")
            RateView(rate: "RUB")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
