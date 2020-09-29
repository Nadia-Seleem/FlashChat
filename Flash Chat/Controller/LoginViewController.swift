//
//  LoginViewController.swift
//  Flash Chat
//
//  Created by Nadia Seleem on 11/02/1442 AH.
//  Copyright © 1442 Nadia Seleem. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    var userManager = UserManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        emailTextField.delegate = self
        passwordTextField.delegate = self
        userManager.delegate = self
    }
    
    @IBAction func loginBtnPressed(_ sender: UIButton) {
        
        guard let email = emailTextField.text, let password = passwordTextField.text else{
            return
        }
        
        userManager.loginUser(by: email,and: password)
        
    }
    
   func presentUIAlert(title:String,message:String){
          
          let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
          alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
          present(alert, animated: true, completion: nil)
          
      }
    
    
}

extension LoginViewController:UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.endEditing(true)
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if textField.text == ""{
            return false
        }
        return true
    }
    
}

extension LoginViewController:UserManagerDelegate{
    func userManager(_ userManager: UserManager, didFailWithError error: Error) {
        presentUIAlert(title: "Error", message: error.localizedDescription)
    }
    
    func userManager(_ userManager: UserManager, successWithMessagePrompt message: String) {
        DispatchQueue.main.async {
            self.performSegue(withIdentifier: K.loginSegue, sender: self)

        }
        print(message)

    }
    

}
