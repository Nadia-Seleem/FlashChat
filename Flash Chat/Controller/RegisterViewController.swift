//
//  RegisterViewController.swift
//  Flash Chat
//
//  Created by Nadia Seleem on 11/02/1442 AH.
//  Copyright © 1442 Nadia Seleem. All rights reserved.
//

import UIKit
import Firebase

class RegisterViewController: UIViewController {
    
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    var userManager = UserManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        usernameTextField.delegate = self
        emailTextField.delegate = self
        passwordTextField.delegate = self
        userManager.delegate = self
    }
    
    @IBAction func registerBtnPressed(_ sender: Any) {
        
        guard let username = usernameTextField.text else{
            return
        }
        guard let email = emailTextField.text else{
            return
        }
        guard let password = passwordTextField.text else{
            return
        }
        if username == "" || email == "" || password == "" {
            return
        }
        userManager.addNewUser(username,email,password)
        
    }
    
    func presentUIAlert(title:String,message:String){
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
        
    }
    
    
}

extension RegisterViewController:UITextFieldDelegate{
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.endEditing(true)
        return true
    }
    
    
}

extension RegisterViewController:UserManagerDelegate{

    
    func userManager(_ userManager: UserManager, successWithMessagePrompt message: String) {
        DispatchQueue.main.async {
            self.performSegue(withIdentifier: K.registerSegue, sender: self)
            print(message)

        }

    }
    
    func userManager(_ userManager: UserManager, didFailWithError error: Error) {
        DispatchQueue.main.async {
            self.presentUIAlert(title: "Error", message: error.localizedDescription)
        }
        
    }
    
    
    
    
    
}
