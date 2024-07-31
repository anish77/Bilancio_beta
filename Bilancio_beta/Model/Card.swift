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
    var amount: String
    var rimasto: String
    var transaction: [String] = []
   

}
/*
struct Info: Codable {
    var title: String
    var payment: Double
}
*/


