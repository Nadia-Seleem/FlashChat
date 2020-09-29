//
//  MessageManagerDelegate.swift
//  Flash Chat
//
//  Created by Nadia Seleem on 11/02/1442 AH.
//  Copyright © 1442 Nadia Seleem. All rights reserved.
//

import Foundation
import Firebase

protocol MessageManagerDelegate {
    func messageManager(_ messageManager: MessageManager, didFailWithError error: Error)
//    func messageManager(_ messageManager: MessageManager, successWithMessagePrompt message: String)
    func messageManager(_ messageManager: MessageManager, successWithMessages messages: [Message],listener: ListenerRegistration)
}
