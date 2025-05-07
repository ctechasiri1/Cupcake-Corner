//
//  ContentView.swift
//  Cupcake Corner
//
//  Created by Chiraphat Techasiri on 1/25/25.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject private var viewModel = CupcakeCornerViewModel()
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    Picker("Select your cake type", selection: $viewModel.order.type) {
                        ForEach(Order.types.indices, id: \.self) {
                            Text(Order.types[$0])
                        }
                    }
                    Stepper("Number of cakes: \(viewModel.order.quantity)", value: $viewModel.order.quantity, in: 3...20)
                }
                
                Section {
                    Toggle("Any special requests?", isOn: $viewModel.order.specialRequestEnabled.animation())
                    
                    if viewModel.order.specialRequestEnabled {
                        Toggle("Add extra frosting", isOn: $viewModel.order.extraFrosting)
                        Toggle("Add extra sprinkles", isOn: $viewModel.order.addSprinkles)
                    }
                }
                
                Section {
                    NavigationLink("Delivery Details") {
                        AddressView(viewModel: viewModel)
                    }
                }
            }
            .navigationTitle("Cupcake Corner")
        }
    }
}

#Preview {
    ContentView()
}
