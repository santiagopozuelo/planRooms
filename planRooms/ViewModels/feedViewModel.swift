//
//  feedViewModel.swift
//  planRooms
//
//  Created by Santiago Pozuelo on 2/10/21.
//
import Foundation

import Firebase

struct Plan: Codable, Identifiable {
    var id: String
    var title: String
    var joinCode: Int
    
}

class FeedViewModel: ObservableObject {
    
    @Published var plans = [Plan]()
    private let db = Firestore.firestore()
    private let user = Auth.auth().currentUser
    
    //fetch data
    
    func fetchData() {
        if (user != nil) {
            //user logged inn
            db.collection("plans").whereField("users", arrayContains: user!.uid).addSnapshotListener({(snapshot, error) in
                
                guard let documents = snapshot?.documents else {
                    print("no docs returned ")
                    return
                }
                
                self.plans = documents.map({docSnapshot -> Plan in
                    let data = docSnapshot.data()
                    let docId = docSnapshot.documentID
                    let title = data["title"] as? String ?? ""
                    let joinCode = data["joinCode"] as? Int ?? -1
                    
                    return Plan(id: docId, title: title, joinCode: joinCode)
                    
                    
                })
                
            })
        }
    }
    
    func createPlan(title: String, handler: @escaping() -> Void) {
        if (user != nil) {
            db.collection("plans").addDocument(data: [
                                                    "title": title,
                                                    "joinCode" : Int.random(in: 10000..<99999),
                                                    "users": [user!.uid]]) { err in
                if let err = err {
                    print("error adding document \(err)")
                } else {
                    handler()
                }
                
            }
        }
    }
    
    func joinPlan(code: String, handler: @escaping()-> Void) {
        if (user != nil) {
            db.collection("plans").whereField("joinCode", isEqualTo: Int(code)).getDocuments() {
                (snapshot, error) in
                if let error = error {
                    print("error getting docs \(error)")
                    
                } else {
                    for document in snapshot!.documents {
                        self.db.collection("plans").document(document.documentID).updateData([
                            "users": FieldValue.arrayUnion([self.user!.uid])])
                        handler()
                    }
                }
            }
        }
    }
}


