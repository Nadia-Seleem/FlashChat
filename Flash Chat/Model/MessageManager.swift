//
//  MessageManager.swift
//  Flash Chat
//
//  Created by Nadia Seleem on 11/02/1442 AH.
//  Copyright © 1442 Nadia Seleem. All rights reserved.
//

import Foundation
import Firebase

class MessageManager{
    
    var delegate: MessageManagerDelegate?
    let db = Firestore.firestore()
    var listener: ListenerRegistration?
    func sendMessage(_ message: String, to reciever:String){
        guard let currentUserEmail = Auth.auth().currentUser?.email else{
            return
        }
        db.collection(K.FStore.MessagesCollection.collectionName).addDocument(data: [
            K.FStore.MessagesCollection.senderField:currentUserEmail,
            K.FStore.MessagesCollection.receiverField: reciever,
            K.FStore.MessagesCollection.bodyField: message,
            K.FStore.MessagesCollection.dateField:Date().timeIntervalSince1970,
            K.FStore.MessagesCollection.betweenField:"between \(currentUserEmail), \(reciever)"
        ]) { error in
            if let error = error {
                self.delegate?.messageManager(self, didFailWithError: error)
                return
            }
            print("the message is added to the database.")
            
        }
    }
    
     func getMessages(sender:String, receiver:String){
        
      listener = db.collection("messages")
        .whereField(K.FStore.MessagesCollection.betweenField,in: ["between \(sender), \(receiver)", "between \(receiver), \(sender)"])
        .order(by: K.FStore.MessagesCollection.dateField)
        .addSnapshotListener { documentSnapshot, error in
            if let error = error{
                self.delegate?.messageManager(self, didFailWithError: error)
                return
            }
            if let snapshot = documentSnapshot{
                var messages = [Message]()
                for document in snapshot.documents{
                    if let sender = document.data()[K.FStore.MessagesCollection.senderField] as? String,
                    let receiver = document.data()[K.FStore.MessagesCollection.receiverField] as? String,
                        let messageBody = document.data()[K.FStore.MessagesCollection.bodyField] as? String{
                        let message = Message(sender: sender, receiver: receiver, body: messageBody)
                        messages.append(message)
                        self.delegate?.messageManager(self, successWithMessages: messages, listener: self.listener!)
                    }
                }
                
            }
          
        }
        
        

    }
}
