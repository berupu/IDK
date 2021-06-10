//
//  Service.swift
//  IDK
//
//  Created by be RUPU on 25/5/21.
//

import Firebase


struct Service {
    
    static func fetchUsers(completion: @escaping(User) -> Void){
        Database.database().reference().child("Users").observeSingleEvent(of: .value) { (snapshot) in
            
            guard let dictionary = snapshot.value as? [String : Any] else {return}
            
            dictionary.forEach { (key, value) in
                
                guard let userDictionary = value as? [String: Any] else {return}
                
                let user = User(dictionary: userDictionary)
                
                completion(user)

            }
        }withCancel: { (err) in
            print("failed to fetch users")
        }
    }
}
