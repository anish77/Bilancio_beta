//
//  DataStore.swift
//  Bilancio_beta
//
//  Created by Ana Cvasniuc on 17/07/24.
//

import Foundation
import MarkCodable

class DataStore: ObservableObject  {
    @Published var cards: [Card] = []
    @Published var entity: Entity?
  //  @Published var operation: Operation?
    
    // this is initialized into ContentView
    init() {
        loadCards()
    }
    
    func addMoviment(_ title: String, spesa: String, for card: Card) {
        
        if let index = cards.firstIndex(where: { $0.id == card.id }) {
            
            guard let spesa_ = Double( spesa.replacingOccurrences(of: ",", with: ".")) else { return }
            
           // cards[index].transaction.append(title)
           // cards[index].transaction.append(String( spesa_))
            var movimento = title + String( spesa_)
           
            cards[index].transaction.append(movimento)
            
           // guard let rimasto_ = Double( cards[index].rimasto .replacingOccurrences(of: ",", with: ".") ) else { return }
          //  let total = rimasto_ - spesa_
          //  cards[index].rimasto =  String( total )
            save()
        }
    }
    
    func addNewCard(card: Card) {
        cards.append(card)
        save()
    }
    
    func deleteCard(card: Card) {
        if let index = cards.firstIndex(where: { $0.id == card.id }) {
            cards.remove(at: index)
            save()
        }
    }
    
    func deleteMoviment(title: String, for card: Card) {
        if let index = cards.firstIndex(where: { $0.id == card.id }) {
            if let cardIndex = cards[index].transaction.firstIndex(where: { $0 == title}) {
                
                cards[index].transaction.remove(at: cardIndex)
                
                save()
                updateInfo(for: card)
            }
        }
    }
    
    func updateInfo(for card: Card){
        print(card)
        //card.rimasto =
    }
    
    func save(){
        //JSON
        do {
            let jsonUrl = URL.documentsDirectory.appending(path: "movimenti.json")
            let contabilitaData = try JSONEncoder().encode(cards)
            try contabilitaData.write(to: jsonUrl)
            
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func loadCards() {
        //JSON
        let jsonUrl = URL.documentsDirectory.appending(path: "movimenti.json")
        // if file exists
        if FileManager().fileExists(atPath: jsonUrl.path) {
            do {
                let jsonData = try Data(contentsOf: jsonUrl)
                cards = try JSONDecoder().decode([Card].self, from: jsonData)
            } catch {
                print(error.localizedDescription)
            }
        }
    }
}

