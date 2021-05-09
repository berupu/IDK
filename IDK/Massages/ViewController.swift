//
//  ViewController.swift
//  IDK
//
//  Created by be RUPU on 30/4/21.
//

import UIKit
import Firebase

class ViewController: UITableViewController {

     let cellID = "cellID"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        checkLogIn()
//        navigationItem.title = Auth.auth().currentUser?.uid
        view.backgroundColor = .black
        
        tableView.register(MassageCell.self, forCellReuseIdentifier: cellID)
        
        setupLogoutButton()
        
    }
    
    fileprivate func checkLogIn(){
        
        let currenctUser = Auth.auth().currentUser
        
        if currenctUser == nil {
            DispatchQueue.main.async {
                let loginController = LogInController()
                let navController = UINavigationController(rootViewController: loginController)
                navController.modalPresentationStyle = .fullScreen
                self.present(navController, animated: true, completion: nil)
            }
            return
        }
        
    }
    
    func setupLogoutButton(){
        let image = UIImage(systemName: "lock.open.fill")
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: image, style: .plain, target: self, action: #selector(handleLogout))
    }
    
    @objc func handleLogout(){
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        alertController.addAction(UIAlertAction(title: "LogOut", style: .destructive, handler: { (_) in
            
            do{
                try Auth.auth().signOut()
                
                let loginController = LogInController()
                let navController = UINavigationController(rootViewController: loginController)
                navController.modalPresentationStyle = .fullScreen
                self.present(navController, animated: true, completion: nil)
                
            } catch {
                print("Failed to LogOut")
            }
            
        }))
        
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        present(alertController, animated: true, completion: nil)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath)
        
        
        
        return cell
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    //swipe delete
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
    }

}

