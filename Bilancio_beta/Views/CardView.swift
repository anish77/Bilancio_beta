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
    var errorMessage = "Sei sicuro ?"
    
    @EnvironmentObject var store: DataStore
    
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(store.cards) { card in
                    Section(header: HeaderView(card: card )) {
                        HStack {
                            Text("Moviments")
                            Spacer()
                            Button {
                                store.entity = .moviment(card)
                            }
                        label: {
                            Image(systemName: "plus.circle.fill")
                        }
                        .foregroundColor(.accentColor)
                            
                        }
                        
                        ForEach(Array( card.transaction.keys ), id: \.self ) { key in
                            //  ForEach( card.transaction.sorted(by: >), id: \.key ) { key, _ in
                            HStack {
                                Text(key)
                                Spacer()
                                Text( String(format: "%.2f", card.transaction[key] ?? 0 ))
                                
                                    .swipeActions {
                                        
                                        Button(role: .destructive) {
                                            
                                            
                                            store.deleteMoviment(title: key, spesa: card.transaction[key] ?? 0.0, for: card)
                                        } label: {
                                            Image(systemName: "trash")
                                        }
                                    }
                            }
                        }
                    }
                }
            }
            //Alert
          /*  .alert(errorMessage, isPresented: deleteMoviment) {
                Button("Yes") {}
            }*/
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
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text("\(card.title)").font(.title)
                Text(card.amount, format: .currency(code: currencyCode)).font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                Spacer()
                Button(role: .destructive) {
                    store.deleteCard(card: card)
                } label: {
                    Image(systemName: "trash.circle.fill")
                }
            }
            Text("Disponibile: \(card.rimasto, format: .currency(code: currencyCode))").font(.title3)
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
