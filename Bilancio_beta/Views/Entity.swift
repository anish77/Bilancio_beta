//
//  Entity.swift
//  Bilancio_beta
//
//  Created by Ana Cvasniuc on 19/07/24.
//

import SwiftUI

enum Entity: Identifiable, View {
    case card
    case moviment(Card)
    var id: String {
        switch self {
        case .card:
            return "card"
        case .moviment:
            return "moviment"
        }
    }
    var body: some View {
        switch self {
        case .card:
            return NewCardView()
        case .moviment(let card):
            return NewCardView(card: card)
        }
    }
}
