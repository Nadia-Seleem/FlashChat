//
//  ChatViewController.swift
//  Flash Chat
//
//  Created by Nadia Seleem on 11/02/1442 AH.
//  Copyright © 1442 Nadia Seleem. All rights reserved.
//

import UIKit
import Firebase

class ChatViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var messageTextField: UITextField!
    
    var RecepiantUser:User?
    var messageManager = MessageManager()
    var userManager = UserManager()
    var messages = [Message]()
    var listener: ListenerRegistration?

    override func viewDidLoad() {
        super.viewDidLoad()
        messageTextField.delegate = self
        messageManager.delegate = self
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: K.messageCellNibName, bundle: nil), forCellReuseIdentifier: K.messageCellIdentifier)
        navigationItem.title = RecepiantUser?.username
       if let currentUserEmail = Auth.auth().currentUser?.email,
         let receiverEmail = RecepiantUser?.email{
        messageManager.getMessages(sender: currentUserEmail, receiver: receiverEmail)
        }
    }
    
    @IBAction func sendBtnPressed(_ sender: UIButton) {
        guard let message = messageTextField.text else{
            return
        }
        guard let receiverEmail = RecepiantUser?.email else{
            return
        }
        if messageTextField.text == "" {
            return
        }
        messageManager.sendMessage(message, to: receiverEmail)
        messageTextField.text = ""
    }
    
    @IBAction func logOutBtnPressed(_ sender: UIButton) {
        
        userManager.logout()
        navigationController?.popToRootViewController(animated: true)
        
    }
    func presentUIAlert(title:String,message:String){
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
     
        super.viewWillDisappear(animated)
                listener?.remove()
    
    }
    
}

extension ChatViewController:UITableViewDataSource,UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: K.messageCellIdentifier, for: indexPath) as! MessageTableViewCell
        cell.messageLabel.text = messages[indexPath.row].body
        cell.messageLabel.layer.cornerRadius = (cell.messageLabel.frame.size.height/5)

        let sender = messages[indexPath.row].sender
        if sender == Auth.auth().currentUser?.email{
            cell.messageBubble.backgroundColor = UIColor(named: K.BrandColors.purple)
            cell.messageLabel.textColor = UIColor(named: K.BrandColors.lightPurple)
            cell.rightImageView.isHidden = false
            cell.leftImageView.isHidden = true
        }else if sender == RecepiantUser?.email{
            cell.messageBubble.backgroundColor = UIColor(named: K.BrandColors.lightPurple )
            cell.messageLabel.textColor = UIColor(named:K.BrandColors.purple )
            cell.rightImageView.isHidden = true
            cell.leftImageView.isHidden = false
        }
        return cell
    }
    
    
}

extension ChatViewController:MessageManagerDelegate{
    func messageManager(_ messageManager: MessageManager, didFailWithError error: Error) {
        presentUIAlert(title: "Error", message: error.localizedDescription)

    }
    
    func messageManager(_ messageManager: MessageManager, successWithMessages messages: [Message],listener: ListenerRegistration) {
        self.messages = messages
        DispatchQueue.main.async {
            self.tableView.reloadData()
            
            if messages.count - 1 > 0{
            let indexpath = IndexPath(row: messages.count - 1, section: 0)
            self.tableView.scrollToRow(at: indexpath, at: .top, animated: false)
            }
            self.listener =  listener
            
        }

    }
    
    
}

extension ChatViewController:UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.endEditing(true)
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let message = messageTextField.text else{
            return
        }
        guard let receiverEmail = RecepiantUser?.email else{
            return
        }
        if messageTextField.text == "" {
            return
        }
        messageManager.sendMessage(message, to: receiverEmail)
        messageTextField.text = ""
    }
    
}
