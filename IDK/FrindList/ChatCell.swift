//
//  ChatCell.swift
//  IDK
//
//  Created by be RUPU on 26/5/21.
//

import UIKit

class ChatCell: UICollectionViewCell {
    
    var message: MessageModel? {
        didSet{
            configMessageView()
        }
    }
    
    var user: User? {
        didSet{
            guard let profileLink = user?.profileImageURL else {return}
            User.loadProfileImage(profileLink) { [self] (downloadedImage) in
//                profileImageView.image = downloadedImage
                profileImageView.image = MassageCell.storedImage
            }
        }
    }
    
    var profileImageView: UIImageView = {
       let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        return iv
    }()
    
    let textViewContainer : UIView = {
       let tvc = UIView()
        tvc.backgroundColor = .blue
        tvc.layer.masksToBounds = true
        return tvc
    }()
    
    let messageView : UITextView = {
       let tv = UITextView()
        tv.backgroundColor = .clear
        tv.font = .systemFont(ofSize: 16)
        tv.textAlignment = .left
        tv.textColor = .white
        tv.isEditable = false
        tv.isScrollEnabled = false
        return tv
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
//        backgroundColor = .gray
        
        addSubview(profileImageView)
        profileImageView.anchor(leading: leadingAnchor,bottom: bottomAnchor,leadingConstant: 12, bottomConstant: -4, widthConstant: 32,heightConstant: 32)
        profileImageView.layer.cornerRadius = 32/2
        
        addSubview(textViewContainer)
        textViewContainer.layer.cornerRadius = 12
        textViewContainer.anchor(top: topAnchor,leading: profileImageView.trailingAnchor,trailing: trailingAnchor, bottom: bottomAnchor, leadingConstant: 12,trailingConstant: 12)
        
        
        textViewContainer.widthAnchor.constraint(lessThanOrEqualToConstant: 250).isActive = true
        
        textViewContainer.addSubview(messageView)
        messageView.anchor(top: textViewContainer.topAnchor,leading: textViewContainer.leadingAnchor,trailing: textViewContainer.trailingAnchor,bottom: textViewContainer.bottomAnchor,topConstant: 4,leadingConstant: 12,trailingConstant: 12,bottomConstant: 4)
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func configMessageView(){
        
        guard let message = message else {return}
        profileImageView.isHidden = message.isFromCurrentUser
        
        messageView.textAlignment = message.isFromCurrentUser ? .right : .left
        
        textViewContainer.backgroundColor = message.messageBackgroundColor
        messageView.textColor = message.messageTextColor
        
        messageView.text = message.text
        
    }

    
    
}
