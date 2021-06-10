//
//  MassageCell.swift
//  IDK
//
//  Created by be RUPU on 30/4/21.
//

import UIKit

class MassageCell: UITableViewCell {
    
    let massageCellID = "massageCellID"
    
    static var storedImage: UIImage?
    
    var user: User? {
        didSet{
            guard let profileLink = user?.profileImageURL else {return}
            User.loadProfileImage(profileLink) { [self] (downloadedImage) in
                profileImage.image = downloadedImage
                MassageCell.storedImage = downloadedImage
                
                configureUI()
            }
        }
    }
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = UIFont.boldSystemFont(ofSize: 16)
        return label
    }()
    
    let profileImage: UIImageView = {
       let pi = UIImageView()
        pi.backgroundColor = .gray
        pi.contentMode = .scaleAspectFill
        pi.clipsToBounds = true
        return pi
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: massageCellID)
        
        addSubview(profileImage)
        profileImage.anchor(top: topAnchor, leading: leadingAnchor, bottom: bottomAnchor, topConstant: 2, leadingConstant: 4, bottomConstant: 2, widthConstant: 100, heightConstant: 100)
        
        profileImage.layer.cornerRadius = 100/2
        
        addSubview(nameLabel)
        nameLabel.anchor(top: topAnchor,leading: profileImage.trailingAnchor, trailing: trailingAnchor, bottom: bottomAnchor, topConstant: 0, leadingConstant:  12, widthConstant: frame.width, heightConstant: 100)
     
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    func configureUI(){
        nameLabel.text = user?.username
        profileImage.image = MassageCell.storedImage
    }
    
}
