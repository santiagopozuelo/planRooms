//
//  PlanViewModel.swift
//  planRooms
//
//  Created by Santiago Pozuelo on 2/10/21.
//

import Foundation

import Firebase

struct Message: Codable, Identifiable {
    var id: String?
    var content: String
    var name: String
}


class PlanViewModel: ObservableObject {
    
    @Published var messages = [Message]()
    private let db = Firestore.firestore()
    private let user = Auth.auth().currentUser
    
    
    func sendMessage(messageContent: String, docId: String) {
        if (user != nil) {
            db.collection("plans").document(docId).collection("messages").addDocument(data: [
                                                                                            "sentAt": Date(),
                                                                                            "content":messageContent,
                                                                                            "sender": user!.uid])
        }
    }
    
    func fetchData(docId: String) {
        if (user != nil) {
            db.collection("plans").document(docId).collection("messages").order(by: "sentAt", descending: false).addSnapshotListener({(snapshot, error) in
                guard let documents = snapshot?.documents else {
                    print("no documents")
                    return
                }
                
                self.messages = documents.map { docSnapshot -> Message in
                    let data = docSnapshot.data()
                    let docId = docSnapshot.documentID
                    let content = data["content"] as? String ?? ""
                    let displayName = data["sender"] as? String ?? ""
                    return Message(id: docId, content: content, name: displayName)
                    
                }
            })
        }
    }
}
