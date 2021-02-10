//
//  Join.swift
//  planRooms
//
//  Created by Santiago Pozuelo on 2/10/21.
//

import SwiftUI

struct Join: View {
    @Binding var isOpen: Bool
    
    @State var joinCode = ""
    @State var newTitle = ""
    @ObservedObject var viewModel = ChatroomsViewModel()
    
    
    var body: some View {
        NavigationView {
            VStack{
                VStack {
                    Text("join chateroom").font(.title)
                    TextField("eneter join code", text: $joinCode)
                    Button(action: {
                        viewModel.joinChatroom(code: joinCode, handler: {
                            self.isOpen = false
                        })
                    }, label: {
                        Text("join")
                    })
                }.padding(.bottom)
                
                VStack {
                    Text("Create chateroom").font(.title)
                    TextField("eneter a new title", text: $newTitle)
                    Button(action: {
                        viewModel.createChatroom(title: newTitle, handler: {
                            self.isOpen = false
                        })
                    }, label: {
                        Text("create")
                    })
                }
                
            }.navigationBarTitle("joinOrCreate")
        }
        
    }
}

struct Join_Previews: PreviewProvider {
    static var previews: some View {
        Join(isOpen: .constant(true))
    }
}
