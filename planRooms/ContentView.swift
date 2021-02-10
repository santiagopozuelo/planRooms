//
//  ContentView.swift
//  planRooms
//
//  Created by Santiago Pozuelo on 2/10/21.
//

import SwiftUI

import SwiftUI

struct ContentView: View {
    
    @ObservedObject var sessionStore = SessionStore()
    
    init() {
        sessionStore.listen()
    }
    
    var body: some View {
        ChatList()
            .fullScreenCover(isPresented: $sessionStore.isAnon, content: {
                Login()
            })
            .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
