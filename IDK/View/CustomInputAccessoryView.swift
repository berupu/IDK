//
//  CustomInputAccessoryView.swift
//  IDK
//
//  Created by be RUPU on 27/5/21.
//

import UIKit
import Firebase

//MARK: - ChatController is Delegate
protocol SendMessageDelegate {
    func sendMessage(_ text: String)
}

class CustomInputAccessoryView: UIView {
    
    var  delegate : SendMessageDelegate?
    
    
    
    let messageTextView: UITextView = {
       let tv = UITextView()
        tv.backgroundColor = .white
        tv.font = UIFont.systemFont(ofSize: 16)
        tv.becomeFirstResponder()
        return tv
    }()
    
    let sendButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .white
        button.setTitle("Send", for: .normal)
        button.addTarget(self, action: #selector(sendMessagePressed), for: .touchUpInside)
        return button
    }()
    
    let label: UILabel =  {
       let lb = UILabel()
        lb.text = "Enter Message"
        lb.font = UIFont.systemFont(ofSize: 16)
        lb.textColor = .lightGray
        lb.font = UIFont.systemFont(ofSize: 14)
        return lb
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        autoresizingMask = .flexibleHeight
        
        
        layer.shadowOpacity = 0.25

        
        
        addSubview(sendButton)
        sendButton.anchor(top: topAnchor, trailing: trailingAnchor,bottom: bottomAnchor, widthConstant: 50, heightConstant: 50)
        
        addSubview(messageTextView)
        messageTextView.anchor(top: topAnchor, leading: leadingAnchor, trailing: sendButton.leadingAnchor, bottom: bottomAnchor, trailingConstant: 0.5)
        
        addSubview(label)
        label.anchor(leading: messageTextView.leadingAnchor, centerY: messageTextView.centerYAnchor, leadingConstant: 4)
        
        //this will notify when textFiled start typing.
        NotificationCenter.default.addObserver(self, selector: #selector(textChange), name: UITextView.textDidChangeNotification, object: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var intrinsicContentSize: CGSize {
        return .zero
    }
    
    
    //MARK: - selector
    
    @objc func sendMessagePressed(){
        print("send Pressed")
        
        guard let message = messageTextView.text else {return}
        delegate?.sendMessage(message)
        
        
    }
    
    @objc func textChange(){
        label.text = nil
    }
}
