//
//  Transactions.swift
//  Bilancio_beta
//
//  Created by Ana Cvasniuc on 31/07/24.
//

import SwiftUI

import SwiftUI

struct ContentView: View {
    
    @State
    var balance: Decimal = 1500.00
    let currencyCode = "EUR"
    
    
    var body: some View {
        Form {
            overviewSection
        }
    }
    
    var overviewSection: some View {
        Section {
            HStack {
                Text("Balance")
                Spacer()
                Text(balance, format: .currency(code: currencyCode))
                
                
            }
            Button("meno - 50") {
                balance = balance - 50
            }
            
            
        } header: {
            Text("Overview")
        }
    }
    
    
    
    
}

#Preview {
    ContentView()
}
