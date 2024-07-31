//
//  NewCardView.swift
//  Bilancio_beta
//
//  Created by Ana Cvasniuc on 22/07/24.
//

import SwiftUI

struct NewCardView: View {
    @EnvironmentObject var store: DataStore
    @Environment(\.dismiss) var dismiss
    var card: Card?
    var newCard: Bool {
        card == nil
    }
    
    // Form Fields
    @State private var cardTitle = ""
    @State private var amount = ""
    @State private var spesa = ""
    
    var isDisabled: Bool {
        if newCard {
            return [cardTitle, amount]
                .map {!$0.isEmpty}
                .filter {$0 == false}
                .count > 0
            
        } else {
            return [cardTitle, spesa]
                .map {!$0.isEmpty}
                .filter {$0 == false }
                .count > 0
            
        }
    }
    var body: some View {
        NavigationStack {
            Form {
                TextField("\(newCard ? "Card Title" : "Description")", text: $cardTitle)
                
                TextField("\(newCard ? "Amount" : "Spesa")", text: (newCard ? $amount : $spesa ))
                    .keyboardType(.decimalPad)
                
                HStack {
                    Spacer()
                    Button("Add") {
                        if newCard {
                            store.addNewCard(card: Card(title: cardTitle, amount: amount, rimasto: amount))
                            
                        } else {
                            if let card {
                                store.addMoviment(cardTitle, spesa: spesa, for: card)
                            }
                        }
                        dismiss()
                    }
                    .disabled(isDisabled)
                    .buttonStyle(.borderedProminent)
                }
            }
            .textFieldStyle(.roundedBorder)
            .padding()
            .navigationTitle(newCard ? "New Card" : "New Transaction")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") {
                        dismiss()
                    }
                    .buttonStyle(.bordered)
                }
            }
            .onAppear {
                UITextField.appearance().clearButtonMode = .whileEditing
            }
        }
    }
}

struct NewCardView_Previews: PreviewProvider {
    static var previews: some View {
        NewCardView()
    }
}

