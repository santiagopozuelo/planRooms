//
//  Login.swift
//  planRooms
//
//  Created by Santiago Pozuelo on 2/10/21.
//

import Foundation
import SwiftUI


//overlay if user not auathenticated
struct Login: View {
    @State var email = ""
    @State var password = ""
    
    @ObservedObject var sessionSession = SessionStore()
    var body: some View {
        NavigationView {
            VStack{
                TextField("email", text: $email)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                SecureField("password", text: $password).textFieldStyle(RoundedBorderTextFieldStyle())
                
                Button(action: {
                    sessionSession.signIn(email: email, password: password)
                }, label: {
                    Text("login")
                })
                
                Button(action: {
                    sessionSession.signUp(email: email, password: password)
                }, label: {
                    Text("sign up")
                })
                
            }.navigationBarTitle("Welcome")
        }
        
        
    }
}

struct Login_Previews: PreviewProvider {
    static var previews: some View {
        Login()
    }
}
