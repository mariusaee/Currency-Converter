//
//  RateListView.swift
//  Currency Converter
//
//  Created by Marius Malyshev on 20.04.2023.
//

import SwiftUI

struct RateListView: View {
    @ObservedObject var rateViewModel = RateListViewModel()

    var body: some View {
        VStack() {
            List {
                ForEach(rateViewModel.currencies.indices, id: \.self) { index in
                    RateView(rateViewModel: rateViewModel, index: index)
                }
            }
        }
    }
}

struct RateListView_Previews: PreviewProvider {
    static var previews: some View {
        RateListView()
    }
}
