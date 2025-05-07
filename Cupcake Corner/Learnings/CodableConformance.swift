//
//  CodableConformance.swift
//  Cupcake Corner
//
//  Created by Chiraphat Techasiri on 1/25/25.
//

import SwiftUI

@Observable
class User: Codable {
    enum CodingKeys: String, CodingKey {
        case _name = "name"
    }
    
    var name = "Taylor"
}

struct CodableConformance: View {
    var body: some View {
        Button("Encode Taylor", action: encodeTaylor)
    }
    
    func encodeTaylor() {
        let data = try! JSONEncoder().encode(User())
        let str = String(decoding: data, as: UTF8.self)
    }
}

#Preview {
    CodableConformance()
}
