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
    @Published var showAlert = false
  
    init() {
        loadCards()
    }
    
    func addMoviment(_ title: String, spesa: Double, for card: Card) {
        if let index = cards.firstIndex(where: { $0.id == card.id }) {
            
            if cards[index].rimasto < spesa {
                showAlert = true
                print("Errore")
            } else {
                showAlert = false
                cards[index].transaction.updateValue(spesa, forKey: title)
                cards[index].rimasto -= spesa
                save()
            }
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
    
    
    func deleteMoviment(title: String, spesa: Double, for card: Card) {
        if let index = cards.firstIndex(where: { $0.id == card.id }) {
            cards[index].transaction.removeValue(forKey: title)
            cards[index].rimasto += spesa
            save()
        }
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

