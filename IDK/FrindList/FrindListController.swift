//
//  FrindListController.swift
//  IDK
//
//  Created by be RUPU on 24/5/21.
//

import UIKit

class FrindListController: UIViewController {
    
    
    //MARK: - Properties
    private let reuseIdentifier = "Cell"
    
    private let tableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()
        
        view.backgroundColor = .purple
    }
    
    func setupTableView(){
        tableView.backgroundColor = .white
        tableView.rowHeight = 80
        tableView.register(FriendCell.self, forCellReuseIdentifier: reuseIdentifier)
        tableView.tableFooterView = UIView()
        tableView.delegate = self
        tableView.dataSource = self
        
        view.addSubview(tableView)
        tableView.frame = view.frame
        
        let image = UIImage(systemName: "cross")
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: image, style: .plain, target: self, action: #selector(handleDismiss))
        navigationItem.rightBarButtonItem?.tintColor = .black
    }
    
    
    //MARK: - Selector
    
    @objc func handleDismiss(){
        dismiss(animated: true, completion: nil)
    }

  
}

    //MARK: - TableView


    extension FrindListController: UITableViewDelegate, UITableViewDataSource{

        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return 10
        }

        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath)
            cell.textLabel?.text = "hello"
            
            return cell
        }

    
    }
