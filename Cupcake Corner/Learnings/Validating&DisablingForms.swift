//
//  Validating&DisablingForms.swift
//  Cupcake Corner
//
//  Created by Chiraphat Techasiri on 1/25/25.
//

import SwiftUI

struct Validating_DisablingForms: View {
    
    @State private var username = ""
    @State private var email = ""
    
    var disableForm: Bool {
        username.count < 5 || email.count < 5
    }
    
    var body: some View {
        Form {
            Section {
                TextField("Username", text: $username)
                TextField("Email", text: $email)
            }
            Section {
                Button("Create account") {
                    print("Creating account...")
                }
            }
            .disabled(disableForm)
        }
    }
}

#Preview {
    Validating_DisablingForms()
}
