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
        nameLabel.anchor(top: topAnchor, leading: nil, trailing: trailingAnchor, bottom: bottomAnchor, centerX: nil, centerY: nil, width: nil, height: nil, topConstant: 0, leadingConstant: 0, trailingConstant: 0, bottomConstant: 0, centerXConstant: 0, centerYConstant: 0, widthConstant: 300, heightConstant: 0)
        
        contentView.addSubview(profileImage)
        profileImage.anchor(top: topAnchor, leading: leadingAnchor, trailing: nameLabel.leadingAnchor, bottom: bottomAnchor, centerX: nil, centerY: nil, width: nil, height: nil, topConstant: 2, leadingConstant: 0, trailingConstant: 0, bottomConstant: 2, centerXConstant: 0, centerYConstant: 0, widthConstant: 100, heightConstant: 100)
        
        profileImage.layer.cornerRadius = 100/2
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
