//
//  ViewController.swift
//  IDK
//
//  Created by be RUPU on 30/4/21.
//

import UIKit
import Firebase

class ViewController: UIViewController {

    private let cellID = "cellID"
    
    //MARK: - Properties
    
    private let tableView = UITableView()
    
    private let plusButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .black
        button.addTarget(self, action: #selector(addFriendButton), for: .touchUpInside)
        return button
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        checkLogIn()
        
        setupTableView()
        tableView.allowsSelection = true
//        navigationItem.title = Auth.auth().currentUser?.uid
        
        
        setupLogoutButton()
        addFriendButton()
        
        configurePlussButton()
        
        
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
        navigationItem.rightBarButtonItem?.tintColor = .black
    }
    
    //MARK: - Selector
    
    @objc func addFriendButton(){
        let image = UIImage(systemName: "plus")
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: image, style: .plain, target: self, action: #selector(handleFrindList))
        navigationItem.leftBarButtonItem?.tintColor = .black
    }
    
    @objc func handleFrindList(){
        let navController = UINavigationController(rootViewController: FrindListController())
        navController.modalPresentationStyle = .fullScreen
        self.present(navController, animated: true, completion: nil)
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
    
    
    func setupTableView(){
        tableView.backgroundColor = .white
        tableView.register(FriendCell.self, forCellReuseIdentifier: cellID)
        tableView.tableFooterView = UIView()
        tableView.delegate = self
        tableView.dataSource = self
        
        view.addSubview(tableView)
        tableView.frame = view.frame
    }
    
    
    func configurePlussButton(){
        view.addSubview(plusButton)
        view.anchor(top: nil, leading: nil, trailing: view.trailingAnchor, bottom: view.bottomAnchor, centerX: nil, centerY: nil, width: nil, height: nil, topConstant: 0, leadingConstant: 0, trailingConstant: 12, bottomConstant: 30, centerXConstant: 0, centerYConstant: 0, widthConstant: 0, heightConstant: 0)
    }
    
}


    //MARK: - TableView

    extension ViewController:  UITableViewDelegate, UITableViewDataSource {
        
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
           return 12
       }
       
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
           let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath)
           
            cell.textLabel?.text = "cell \(indexPath.row)"
           
           return cell
       }

        func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
           return 100
       }
       
       //swipe delete
        func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
           
       }
        
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            print("Tapped")
        }
    }

