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
    
    private var chatedWithUser = [User]()
    
    private var myProfile: User?
    
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        checkLogIn()
        
    
        tableView.register(MassageCell.self, forCellReuseIdentifier: cellID)
        tableView.separatorStyle = .none
        navigationItem.backButtonTitle = ""
        //navigationItem.titleView = ProfileView()
        
        
        setupLogoutButton()
        
        fetchUsers()
    
        configureNavigationBar()
        
        addFriendButton()
        
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
    
    func addFriendButton(){
        let image = UIImage(systemName: "plus")
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: image, style: .plain, target: self, action: #selector(handleFrindList))
        navigationItem.leftBarButtonItem?.tintColor = .black
    }
    
    func setupLogoutButton(){
        
        let image = UIImage(systemName: "lock.open.fill")
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: image, style: .plain, target: self, action: #selector(handleLogout))
        navigationItem.rightBarButtonItem?.tintColor = .black
    }
    
    //MARK: - Selector
    
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
    
    
    //MARK: - Custom NavigationBar
    
    func configureNavigationBar() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        appearance.backgroundColor = #colorLiteral(red: 1, green: 0.6039215686, blue: 0.462745098, alpha: 1)
        
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.compactAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "Messages"
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.isTranslucent = true
        
        navigationController?.navigationBar.overrideUserInterfaceStyle = .dark
    }
    
    
    
    
    //MARK: - TableView
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return chatedWithUser.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as! MassageCell
        
        cell.user = chatedWithUser[indexPath.row]
        
        return cell
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    //swipe delete
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let chatController = ChatController(user: chatedWithUser[indexPath.row])
        navigationController?.pushViewController(chatController, animated: true)

    }
    
}

//MARK: - fetching chated with user

extension ViewController {
    
    private func fetchUsers(){
        
        guard let currentUser = Auth.auth().currentUser?.uid else {return}
        
        Database.database().reference().child("Recent Messages").child(currentUser).observeSingleEvent(of: .value) { (snapshot) in
            
            guard let values = snapshot.value as? [String : AnyObject] else {return}
            
            let chatedWithUserID = values.keys
            
            Database.database().reference().child("Users").observeSingleEvent(of: .value) { [self] (snapshot) in
                
                guard let dictionary = snapshot.value as? [String : Any] else {return}
                
                dictionary.forEach { (key, value) in
                    
                    guard let userDictionary = value as? [String: Any] else {return}
                    
                    let user = User(dictionary: userDictionary)
                    
                    chatedWithUserID.forEach { (userID) in
                        if user.uid == userID {
                            self.chatedWithUser.append(user)
                        }
                    }
                
                }
                self.tableView.reloadData()
                //print("Final user: count \(self.chatedWithUser.count) \(self.chatedWithUser)")
            }
            
            
        } withCancel: { (err) in
            print("failed to fetch user for ViewController: \(err)")
        }
    }
    
   
}

