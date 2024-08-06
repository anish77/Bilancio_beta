//
//  Card.swift
//  Bilancio_beta
//
//  Created by Ana Cvasniuc on 17/07/24.
//

import SwiftUI

struct Card: Identifiable, Codable {
    var id = UUID().uuidString
    var title: String
    var amount: Double
    var rimasto: Double
    var transaction: [TransactionDetails] = []
    var data: Date
   
}

struct TransactionDetails: Codable, Hashable {
    var title: String
    var amount: Double
    var data: Date
}

