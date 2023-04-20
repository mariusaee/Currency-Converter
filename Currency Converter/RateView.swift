//
//  RateView.swift
//  Currency Converter
//
//  Created by Marius Malyshev on 20.04.2023.
//

import SwiftUI

struct RateView: View {
    var rate: String
    
    var body: some View {
        HStack {
            Image(systemName: "flag")
                .resizable()
                .frame(width: 32, height: 32)
            VStack(alignment: .leading) {
                Text(rate)
                    .font(.title2)
                Text("$1.00")
                    .font(.caption)
            }
            Spacer()
            Text("$1.00")
                .font(.title2)
                .bold()
        }
    }
}

struct RateView_Previews: PreviewProvider {
    static var previews: some View {
        RateView(rate: "USD")
    }
}
