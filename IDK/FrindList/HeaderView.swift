//
//  HeaderView.swift
//  IDK
//
//  Created by be RUPU on 6/6/21.
//

import UIKit

class HeaderView: UICollectionViewCell {
    
    
     let profileImage: UIImageView = {
        let pi = UIImageView()
        pi.backgroundColor = .gray
        pi.contentMode = .scaleAspectFill
        pi.clipsToBounds = true
        return pi
    }()
    
     let nameLabel: UILabel = {
       let nl = UILabel()
        nl.backgroundColor = .white
        nl.font = UIFont.boldSystemFont(ofSize: 16)
        nl.textAlignment = .center
        return nl
    }()
    
     let dissMissButton: UIButton = {
        let db = UIButton(type: .system)
        db.setImage(UIImage(systemName: "house.fill"), for: .normal)
        return db
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        //addSubview(nameLabel)
        //nameLabel.anchor(centerX: centerXAnchor,widthConstant: 100,heightConstant: 20)
        
        addSubview(profileImage)
        profileImage.anchor(top: topAnchor,centerX: centerXAnchor, topConstant: 4,widthConstant: 80,heightConstant: 80)
        profileImage.layer.cornerRadius = 40
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
