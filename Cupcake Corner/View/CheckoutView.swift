//
//  CheckoutView.swift
//  Cupcake Corner
//
//  Created by Chiraphat Techasiri on 1/27/25.
//

import SwiftUI

struct CheckoutView: View {
    @ObservedObject var viewModel: CupcakeCornerViewModel
    
    var body: some View {
        ScrollView {
            VStack {
                AsyncImage(url: URL(string: "https://hws.dev/img/cupcakes@3x.jpg"), scale: 3) { image in
                    image
                        .resizable()
                        .scaledToFit()
                } placeholder: {
                    ProgressView()
                }
                .frame(height: 233)
                
                Text("Your total cost is \(viewModel.order.cost, format: .currency(code: "USD"))")
                    .font(.title)
                
                Button("Place Order") {
                    Task {
                        await viewModel.placeOrder()
                    }
                }
                .alert("Order unsuccessful", isPresented: $viewModel.showingError) {
                    Button("OK", role: .cancel) {}
                } message: {
                    Text("Check out failed resource exceeds maximum size.")
                }
            }
        }
        .navigationTitle("Check out")
        .navigationBarTitleDisplayMode(.inline)
        .scrollBounceBehavior(.basedOnSize)
        .alert("Thank you!", isPresented: $viewModel.showingConfirmation) {
            Button("OK") { }
        } message: {
            Text(viewModel.confirmationMessage)
        }
    }
}

#Preview {
    CheckoutView(viewModel: CupcakeCornerViewModel())
}
