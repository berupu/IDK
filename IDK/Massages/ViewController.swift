//
//  ViewController.swift
//  IDK
//
//  Created by be RUPU on 30/4/21.
//

import UIKit

class ViewController: UITableViewController {

     let cellID = "cellID"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        
        tableView.register(MassageCell.self, forCellReuseIdentifier: cellID)
//        tableView.separatorStyle = .none
        
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

