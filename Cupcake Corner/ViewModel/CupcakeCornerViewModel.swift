//
//  CheckoutViewModel.swift
//  Cupcake Corner
//
//  Created by Chiraphat Techasiri on 5/1/25.
//

import Foundation

@MainActor
class CupcakeCornerViewModel: ObservableObject {
    @Published var order = Order()
    @Published var showingError = false
    @Published  var confirmationMessage = ""
    @Published var showingConfirmation = false
    
    init() {
        if let loadSavedOrder = loadOrderFromUserDefaults() {
            order = loadSavedOrder
        }
    }
    
    func placeOrder() async {
        // converts order data to JSON
        guard let encoded = try? JSONEncoder().encode(order) else {
            showingError = true
            print("Failed to encode order")
            return
        }
        
        // prepares request to send the JSON data
        let url = URL(string: "https://reqres.in/api/cupcakes")!
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("reqres-free-v1", forHTTPHeaderField: "x-api-key")
        request.httpMethod = "POST"
        
        do {
            // sends JSON data to API endpoint
            let(data, _) = try await URLSession.shared.upload(for: request, from: encoded)
            // decodes JSON data from API endpoint
            let decodedOrder = try JSONDecoder().decode(Order.self, from: data)
            
            confirmationMessage = "\(decodedOrder.quantity)x \(Order.types[decodedOrder.type].lowercased()) cupcakes is on its way!"
            showingConfirmation = true
            saveOrderToUserDefaults(order)
        } catch {
            showingError = true
            print("Checkout failed \(error.localizedDescription)")
        }
    }
    
    func saveOrderToUserDefaults(_ order: Order) {
        if let encoded = try? JSONEncoder().encode(order) {
            UserDefaults.standard.set(encoded, forKey: "savedOrder")
        }
    }
    
    func loadOrderFromUserDefaults() -> Order? {
        if let savedData = UserDefaults.standard.data(forKey: "savedOrder") {
            if let decoded = try? JSONDecoder().decode(Order.self, from: savedData) {
                return decoded
            }
        }
        return nil
    }
}
