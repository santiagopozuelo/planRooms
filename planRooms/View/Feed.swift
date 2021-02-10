//
//  Feed.swift
//  planRooms
//
//  Created by Santiago Pozuelo on 2/10/21.
//

import SwiftUI

struct Feed: View {
    @ObservedObject var viewModel = FeedViewModel()
    @State var joinModal = false
    
    init() {
        viewModel.fetchData()
    }
    
    var body: some View {
        NavigationView {
            List(viewModel.plans) { plan in
                NavigationLink(destination: Messages(plan: plan)){
                    HStack(alignment: .top) {
                        Text(plan.title)
                        Spacer()
                    }
                }
                
                
                .navigationBarTitle("Chatrooms")
                .navigationBarItems(trailing: Button(action:{
                    self.joinModal = true
                }, label: {
                    Image(systemName: "plus.circle")
                }))
                .sheet(isPresented: $joinModal, content: {
                    Join(isOpen: $joinModal)
                })
                
            }
        }
    }
}

struct ChatList_Previews: PreviewProvider {
    static var previews: some View {
        Feed()
    }
}
