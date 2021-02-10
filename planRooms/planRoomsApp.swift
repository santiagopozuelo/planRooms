//
//  planRoomsApp.swift
//  planRooms
//
//  Created by Santiago Pozuelo on 2/10/21.
//

import SwiftUI
import Firebase

@main
struct planRoomsApp: App {
    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
