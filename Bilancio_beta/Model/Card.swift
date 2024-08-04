//
//  Card.swift
//  Bilancio_beta
//
//  Created by Ana Cvasniuc on 17/07/24.
//

import SwiftUI

struct Card: Identifiable, Codable, Hashable {
    
    var id = UUID().uuidString
    var title: String
    var amount: Double//Decimal
    var rimasto: Double//Decimal
    var transaction = [String: Double]()
   
}



