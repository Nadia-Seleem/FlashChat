//
//  UserManager.swift
//  Flash Chat
//
//  Created by Nadia Seleem on 11/02/1442 AH.
//  Copyright © 1442 Nadia Seleem. All rights reserved.
//

import Foundation
import Firebase



struct UserManager{
    
    let db = Firestore.firestore()
    var delegate:UserManagerDelegate?
    
    func addNewUser(_ username:String,_ email:String,_ password:String){
        
        createUser(username, email, password) { (username, email) in
            
            self.db.collection(K.FStore.UsersCollection.collectionName).addDocument(data: [
                K.FStore.UsersCollection.usernameField: username,
                K.FStore.UsersCollection.emailField: email ]) { error in
                    if let error = error {
                        self.delegate?.userManager(self, didFailWithError: error)
                        return
                    }
                    self.delegate?.userManager(self, successWithMessagePrompt:"the user is added to the database." )

            }
            
        }

        
        

        
        
    }
    
    func createUser(_ username:String,_ email:String,_ password:String,completion:@escaping (String,String)->()){
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            if let error = error{
                self.delegate?.userManager(self, didFailWithError: error)
                return
            }
            completion(username,email)
        }
    }
    
    func loginUser(by email:String,and password:String){
        Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
            if let error = error{
                self.delegate?.userManager(self, didFailWithError: error)
                print(error.localizedDescription)
                return
            }

            self.delegate?.userManager(self, successWithMessagePrompt: "user signed in successfully!")
        }

        
    }
    
    func logout(){
        
        do {
          try Auth.auth().signOut()
            print("signed out successfully")
        } catch let signOutError as NSError {
            delegate?.userManager(self, didFailWithError: signOutError)
        }
          
    }
    
    func getUsers(){
        
        db.collection(K.FStore.UsersCollection.collectionName).getDocuments() { (querySnapshot, err) in
            if let err = err {
                self.delegate?.userManager(self, didFailWithError: err)
                return
            }
            if let snapshot = querySnapshot{
                var users = [User]()
                for document in snapshot.documents {
                    if let username = document.data()[K.FStore.UsersCollection.usernameField] as? String,
                        let email = document.data()[K.FStore.UsersCollection.emailField] as? String{
                        let currentUserEmail = Auth.auth().currentUser?.email
                        if email != currentUserEmail{
                        users.append(User(username: username, email: email))
                        }
                    }
                    
                }
                self.delegate?.userManager(self, successWithUsers: users)
            }
            
        }
        
    }
    
    
    
}
