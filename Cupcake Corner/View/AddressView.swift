//
//  AddressView.swift
//  Cupcake Corner
//
//  Created by Chiraphat Techasiri on 1/25/25.
//

import SwiftUI

struct AddressView: View {
    // @State property wrapper makes two-way bindings for us
    // @Bindable allows us to create a binding and not create a new Order object, with an @Observable object
//    @Bindable var order: Order
    @ObservedObject var viewModel: CupcakeCornerViewModel
    
    var body: some View {
        Form {
            Section {
                TextField("Name", text: $viewModel.order.name)
                TextField("Street Address", text: $viewModel.order.streetAddress)
                TextField("City", text: $viewModel.order.city)
                TextField("Postal Code", text: $viewModel.order.zip)
            }
            
            Section {
                NavigationLink("Check Out") {
                    CheckoutView(viewModel: viewModel)
                }
            }
            .disabled(viewModel.order.hasValidAddress == false || viewModel.order.hasValidAddressLength == false)
        }
        .navigationTitle("Delivery details")
        .navigationBarTitleDisplayMode(.inline)
    }
    
    
}

#Preview {
    AddressView(viewModel: CupcakeCornerViewModel())
}
