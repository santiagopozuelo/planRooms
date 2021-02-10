//
//  SessionStore.swift
//  planRooms
//
//  Created by Santiago Pozuelo on 2/10/21.
//


import Foundation

import FirebaseAuth

struct User {
    var uid: String
    var email: String
}

class SessionStore: ObservableObject {
    @Published var session: User?
    //true if not logged in
    @Published var isAnon: Bool = false
    
    var handle: AuthStateDidChangeListenerHandle?
    let authRef = Auth.auth()
    
    //listen to changes in authenticataion in firebase
    func listen() {
        handle = authRef.addStateDidChangeListener({ (auth, user) in
            if let user = user {
                self.isAnon = false
                self.session = User(uid: user.uid, email: user.email!)
            } else {
                self.isAnon = true
                self.session = nil
            }
        })
    }
    
    func signIn(email: String, password:String) {
        authRef.signIn(withEmail: email, password: password)
    }
    
    func signUp(email: String, password:String) {
        authRef.createUser(withEmail: email, password: password)
    }
    
    
    func signOut ()-> Bool {
        do {
            try authRef.signOut()
            self.session = nil
            self.isAnon = true
            return true
        } catch {
            return false
        }
    }
    
    //remove listener from background when user not in page
    func unbind () {
        if let handle = handle {
            authRef.removeStateDidChangeListener(handle)
        }
    }
    
}
