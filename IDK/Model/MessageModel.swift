//
//  MessageModel.swift
//  IDK
//
//  Created by be RUPU on 29/5/21.
//

import Firebase

struct MessageModel {
    
    let text : String
    let fromID: String
    let toID: String
    
    var isFromCurrentUser: Bool
    
    var messageBackgroundColor: UIColor? {
        return isFromCurrentUser ? .white : .blue
    }
    
    var messageTextColor: UIColor? {
        return isFromCurrentUser ? .black : .white
    }
    
    init(dictionary: [String: Any]) {
        self.text = dictionary["text"] as? String ?? ""
        self.fromID = dictionary["fromID"] as? String ?? ""
        self.toID = dictionary["toID"] as? String ?? ""
        self.isFromCurrentUser = fromID == Auth.auth().currentUser?.uid
    }
}
