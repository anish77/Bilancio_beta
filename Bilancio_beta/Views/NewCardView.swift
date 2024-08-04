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
    
    @State private var cardTitle = ""
    @State private var amount = ""
    @State private var spesa = ""
    @State private var showError: Bool = false
    @State private var errorMessage = "La spesa è maggiore del importo disponibile!"
    @FocusState private var isFocused: Bool
    
    let currencyCode = "EUR"
    
    var isEnabled: Bool {
        
        if newCard {
            let amount_ = converterAmount(text: amount )
            return  cardTitle != "" && amount_  > 0.0
        } else {
            let spesa_ = converterSpesa(text: spesa)
            return cardTitle != "" && spesa_ > 0.0
        }
    }
    
    func converterAmount(text: String) -> Double {
        let textDouble = Double(amount.replacingOccurrences(of: ",", with: ".")) ?? 0
        return textDouble
    }
    
    func converterSpesa(text: String) -> Double {
        let textDouble = Double(spesa.replacingOccurrences(of: ",", with: ".")) ?? 0
        return textDouble
    }
    
    var body: some View {
        NavigationStack {
            Form {
                TextField("\(newCard ? "Card Title" : "Description")", text: $cardTitle)
                    .focused($isFocused)
                
                TextField("\(newCard ? "Amount" : "Spesa")", text: newCard ? $amount : $spesa )
                    .keyboardType(.decimalPad)
                    
                HStack {
                    Spacer()
                    Button("Add") {
                        isFocused = true
                        if newCard {
                            store.addNewCard(card: Card(title: cardTitle, amount: converterAmount(text: amount), rimasto: converterAmount(text: amount) ))
                        } else {
                            
                            if let card {
                                if converterSpesa(text: spesa) < card.rimasto {
                                    store.addMoviment(cardTitle, spesa: converterSpesa(text: spesa), for: card)
                                    dismiss()
                                }
                                else {
                                    showError.toggle()
                                }
                            }
                        }
                    }
                    .onAppear{
                        DispatchQueue.main.asyncAfter(deadline: .now()) {
                            isFocused.toggle()
                        }
                    }
                    .disabled(!isEnabled)
                    .buttonStyle(.borderedProminent)
                   
                }
                //Alert
                .alert(errorMessage, isPresented: $showError) {
                    Button("OK") {}
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

/*
 struct NewCardView_Previews: PreviewProvider {
 static var previews: some View {
 NewCardView()
 }
 }
 */
