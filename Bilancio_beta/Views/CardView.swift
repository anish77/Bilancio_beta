//
//  CardView.swift
//  Bilancio_beta
//
//  Created by Ana Cvasniuc on 19/07/24.
//

import SwiftUI


struct CardView: View {
    @EnvironmentObject var store: DataStore
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(store.cards) { card in
                    Section(header: HeaderView(card: card )) {
                        
                        HStack {
                            Text("Moviments")
                            Button {
                                store.entity = .moviment(card)
                            } label: {
                                Image(systemName: "plus.circle.fill")
                            }
                            .foregroundColor(.accentColor)
                        }
                      
                        ForEach(card.transaction, id: \.self) { value in
                            Text(value)
                                .swipeActions {
                                    Button(role: .destructive) {
                                        store.deleteMoviment(title: value, for: card)
                                    } label: {
                                        Image(systemName: "trash")
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
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text("\(card.title), \(card.amount)").font(.title)
                Button(role: .destructive) {
                    store.deleteCard(card: card)
                } label: {
                    Image(systemName: "trash.circle.fill")
                }
            }
            Text("EUR: \(card.rimasto)")
        }
    }
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        CardView()
            .environmentObject(DataStore())
    }
}

