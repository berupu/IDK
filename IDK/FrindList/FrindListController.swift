//
//  FrindListController.swift
//  IDK
//
//  Created by be RUPU on 24/5/21.
//

import UIKit
import Firebase


class FrindListController: UITableViewController {

    
    //MARK: - Properties
    private let reuseIdentifier = "Cell"
    
    var users =  [User]()
    var filteredUser = [User]()
        
    
    private let searchController = UISearchController(searchResultsController: nil)
    
    private var isSearchMode: Bool {
        return searchController.isActive && !searchController.searchBar.text!.isEmpty
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchUsers()
        setupTableView()
        
        configureSeachController()
        
    }
    
    func setupTableView(){
        tableView.backgroundColor = .white
        tableView.rowHeight = 100
        tableView.register(MassageCell.self, forCellReuseIdentifier: reuseIdentifier)
        tableView.tableFooterView = UIView()
//        tableView.delegate = self
//        tableView.dataSource = self
//
//        view.addSubview(tableView)
//        tableView.frame = view.frame
        
        let image = UIImage(systemName: "x.circle")
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: image, style: .plain, target: self, action: #selector(handleDismiss))
        navigationItem.rightBarButtonItem?.tintColor = .gray
    }
    
    
    //MARK: - Selector
    
    @objc func handleDismiss(){
        dismiss(animated: true, completion: nil)
    }
    
    
    func configureSeachController(){
        navigationItem.searchController = searchController
        searchController.searchBar.placeholder = "Search"
        searchController.searchBar.searchTextField.backgroundColor = .white
        searchController.searchResultsUpdater = self
    }
    
    
    func fetchUsers(){
        Database.database().reference().child("Users").observe(.value) { [self] (snapshot) in
            
            guard let dictionary = snapshot.value as? [String : Any] else {return}
            
            dictionary.forEach { (key, value) in
                
                guard let userDictionary = value as? [String: Any] else {return}
                
                let user = User(dictionary: userDictionary)
                
                if user.uid != Auth.auth().currentUser?.uid{
                    self.users.append(user)
                }
            
            }
            
            filteredUser = users
            self.tableView.reloadData()
            
        } withCancel: { (err) in
            print("failed to fetch users")
        }

    }

}

    //MARK: - TableView


    extension FrindListController {

        override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return isSearchMode ? filteredUser.count : users.count
        }

        override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! MassageCell
            
            cell.user = users[indexPath.row]
            
            return cell
        }
        
        override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            
            let chatController = ChatController(user: users[indexPath.row])
            navigationController?.pushViewController(chatController, animated: true)
   
        }

    
    }

        //MARK: - SearchResultsUpdating

extension FrindListController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        
        guard let text = searchController.searchBar.text?.lowercased() else {return}

        filteredUser = users.filter({ (user) -> Bool in
            return (user.username?.lowercased().contains(text))!
        })
        //users = filteredUser
        self.tableView.reloadData()
       
    }

}
