//
//  MassageCell.swift
//  IDK
//
//  Created by be RUPU on 30/4/21.
//

import UIKit

class MassageCell: UITableViewCell {
    
    let massageCellID = "massageCellID"
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.text = " From here"
        label.backgroundColor = .yellow
        return label
    }()
    
    let profileImage: UIImageView = {
       let pi = UIImageView()
        pi.backgroundColor = .black
        return pi
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: massageCellID)
        
        contentView.addSubview(nameLabel)
        nameLabel.anchor(top: topAnchor, left: nil, bottom: bottomAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 300, height: 0)
        
        contentView.addSubview(profileImage)
        profileImage.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: nameLabel.leftAnchor, paddingTop: 2, paddingLeft: 0, paddingBottom: 2, paddingRight: 0, width: 100, height: 100)
        profileImage.layer.cornerRadius = 100/2
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
