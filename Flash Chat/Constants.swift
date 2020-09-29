//
//  Constants.swift
//  Flash Chat
//
//  Created by Nadia Seleem on 11/02/1442 AH.
//  Copyright © 1442 Nadia Seleem. All rights reserved.
//

import Foundation


 struct K {
    static let appName = "⚡️FlashChat"
    static let messageCellIdentifier = "messageReusableCell"
    static let userCellIdentifier = "userReusableCell"

    static let userCellNibName = "UserTableViewCell"
    static let messageCellNibName = "MessageTableViewCell" 
    static let registerSegue = "RegisterToUsers"
    static let loginSegue = "LoginToUsers"
    static let useresSegue = "UsersToChat"

    
    struct BrandColors {
        static let purple = "BrandPurple"
        static let lightPurple = "BrandLightPurple"
        static let blue = "BrandBlue"
        static let lighBlue = "BrandLightBlue"
    }
    
    struct FStore {
        
        struct MessagesCollection {
            static let collectionName = "messages"
            static let senderField = "sender"
            static let receiverField = "receiver"
            static let bodyField = "body"
            static let dateField = "date"
            static let betweenField = "between"

        }
        struct UsersCollection{
            static let collectionName = "users"
            static let usernameField = "username"
            static let emailField = "email"
        }
        
    }
    
    

}
