//
//  UserManagerDelegate.swift
//  Flash Chat
//
//  Created by Nadia Seleem on 11/02/1442 AH.
//  Copyright © 1442 Nadia Seleem. All rights reserved.
//

import Foundation
protocol UserManagerDelegate {
    func userManager(_ userManager:UserManager,didFailWithError error:Error )
    func userManager(_ userManager:UserManager,successWithMessagePrompt message:String )
    func userManager(_ userManager:UserManager,successWithUsers users:[User])
    
}

extension UserManagerDelegate{
    func userManager(_ userManager: UserManager, successWithUsers users: [User]) {
        return
    }
    func userManager(_ userManager:UserManager,successWithMessagePrompt message:String ){
        return
    }
    
}
