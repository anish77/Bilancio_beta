//
//  CardView.swift
//  Bilancio_beta
//
//  Created by Ana Cvasniuc on 19/07/24.
//

import SwiftUI


struct CardView: View{
    
    let currencyCode = "EUR"
    var deleteMoviment: Bool = false
    
    @EnvironmentObject var store: DataStore
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(store.cards) { card in
                    Section(header: HeaderView(card: card )) {
                        HStack {
                            Text("Moviments")
                                .foregroundStyle(Color(red: 0, green: 0.46, blue: 0.89))
                            Spacer()
                            Button {
                                store.entity = .moviment(card)
                            }
                        label: {
                            Image(systemName: "plus.circle.fill")
                        }
                        .foregroundColor(.accentColor)
                            
                        }
                        
                        // ForEach(Array( card.transaction.keys ), id: \.self ) { key in
                        // ForEach(card.transaction.sorted(by: $0.transaction.data < $1.transaction.data), id: \.key ) { key in
                        ForEach(card.transaction, id: \.self ) { key in
                            HStack {
                                Text(key.title)
                                Text(key.data, style: .date)
                                Spacer()
                                Text( String(format: "%.2f", key.amount))
                                    .swipeActions {
                                        
                                        Button(role: .destructive) {
                                            store.deleteMoviment(transaction: TransactionDetails(title: key.title, amount: key.amount, data: key.data), for: card)
                                        } label: {
                                            Image(systemName: "trash")
                                        }
                                    }
                            }
                        }
                    }
                }
            }
            .listStyle(.plain)
            .navigationTitle("Cards")
            .toolbar {
                ToolbarItem {
                    Button {
                        store.entity = .card
                    } label: {
                        Image(systemName: "plus.circle.fill")
                    }
                }
            }
            .sheet(item: $store.entity) { $0.presentationDetents([.medium]) }
        }
        .padding()
    }
}


struct HeaderView: View {
    @EnvironmentObject var store: DataStore
    let card: Card
    let currencyCode = "EUR"
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text("\(card.title)")
                    .font(.title2)
                    .foregroundStyle(colorScheme == .dark ? .white : .black)
                Text(card.amount, format: .currency(code: currencyCode))
                    .font(.title2)
                Spacer()
                Text(card.data, style: .date)
                    .font(.title3)
                    .foregroundStyle(.blue)
            }
            HStack {
                Text("Disponibile: \(card.rimasto, format: .currency(code: currencyCode))").font(.title3)
                Spacer()
                Button(role: .destructive) {
                    store.deleteCard(card: card)
                } label: {
                    Image(systemName: "trash.circle.fill")
                }
            }
        }
    }
}
/*
 struct CardView_Previews: PreviewProvider {
 static var previews: some View {
 CardView()
 .environmentObject(DataStore())
 }
 }
 
 */
