//
//  Bilancio_betaApp.swift
//  Bilancio_beta
//
//  Created by Ana Cvasniuc on 10/07/24.
//

import SwiftUI

@main
struct Bilancio_betaApp: App {
    @StateObject var store = DataStore()
    
    var body: some Scene {
        WindowGroup {
            CardView()
                .environmentObject(store)
                .onAppear {
                    print(URL.documentsDirectory.path)
                }
        }
    }
}
