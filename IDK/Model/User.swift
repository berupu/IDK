//
//  User.swift
//  IDK
//
//  Created by be RUPU on 25/5/21.
//

import UIKit

struct User {
    
    let username: String?
    let uid: String?
    let profileImageURL: String?
    
    init(dictionary: [String: Any]) {
        self.username = dictionary["userName"] as? String ?? ""
        self.uid = dictionary["Uid"] as? String ?? ""
        self.profileImageURL = dictionary["profileImgaeURL"] as? String ?? ""
    }
    
    static func loadProfileImage(_ url: String, completion: @escaping(UIImage) -> Void){
        
        guard let profilelink = URL(string: url) else {return}
        
            let request = NSMutableURLRequest(url: profilelink)

            let task = URLSession.shared.dataTask(with: request as URLRequest) { (data, response, error) in

                    if error != nil {
                        print(error!)
                    }else {

                    if let data = data {
                        if let downloadImage = UIImage(data: data){
                            DispatchQueue.main.async {
                                completion(downloadImage)
                            }
                            //print("Downloaded")
                        }
                    }
                }
            }
            task.resume()
        }
    
}

