//
//  UsersViewController.swift
//  Flash Chat
//
//  Created by Nadia Seleem on 11/02/1442 AH.
//  Copyright © 1442 Nadia Seleem. All rights reserved.
//

import UIKit

class UsersViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {

    @IBOutlet var tableView: UITableView!
    
    var userManager = UserManager()
    var users = [User]()
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        userManager.delegate = self
        tableView.register(UINib(nibName: K.userCellNibName, bundle: nil), forCellReuseIdentifier: K.userCellIdentifier)
        userManager.getUsers()
        navigationItem.hidesBackButton = true

    }
    
    @IBAction func LogOutBtnPressed(_ sender: UIBarButtonItem) {
        userManager.logout()
        navigationController?.popToRootViewController(animated: true)
    }

    
    func presentUIAlert(title:String,message:String){
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: K.userCellIdentifier, for: indexPath) as! UserTableViewCell
        cell.usernameLabel.text = users[indexPath.row].username
        cell.emailLabel.text = users[indexPath.row].email
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        performSegue(withIdentifier: K.useresSegue, sender: users[indexPath.row])

    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == K.useresSegue {
            let chatVC = segue.destination as? ChatViewController
            chatVC?.RecepiantUser = sender as? User
        }
    }
    


}

extension UsersViewController:UserManagerDelegate{

    func userManager(_ userManager: UserManager, didFailWithError error: Error) {
        presentUIAlert(title: "Error", message: error.localizedDescription)

    }
    func userManager(_ userManager: UserManager, successWithUsers users: [User]) {
        
        self.users = users
        
        tableView.reloadData()
        
    }
    
}
