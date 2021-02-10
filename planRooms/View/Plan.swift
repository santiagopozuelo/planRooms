//
//  Plan.swift
//  planRooms
//
//  Created by Santiago Pozuelo on 2/10/21.
//

import Foundation
import SwiftUI

struct Messages: View {
    
    let plan: Plan
    @ObservedObject var viewModel = PlanViewModel()
    @State var messageField = ""
    
    init(plan: Plan) {
        self.plan = plan
        viewModel.fetchData(docId: plan.id)
    }
    
    var body: some View {
        VStack{
            List(viewModel.messages) { message in
                HStack{
                    //Text(message.name)
                    Text(message.content)
                    Spacer()
                }
            }
            HStack {
                TextField("enter messaage...", text: $messageField).textFieldStyle(RoundedBorderTextFieldStyle())
                Button(action: {
                    viewModel.sendMessage(messageContent: messageField, docId: plan.id)
                }, label: {
                    Text("send")
                    
                })
            }
        }

            .navigationBarTitle(plan.title)
    }
}

struct Messages_Previews: PreviewProvider {
    static var previews: some View {
        Messages(plan: Plan(id: "10101",title: "Hello", joinCode: 10))
    }
}
