//
//  SignUpController.swift
//  IDK
//
//  Created by be RUPU on 2/5/21.
//

import UIKit

class SignUpController: UIViewController {
    
    private let userName : UITextField = {
       let textField = UITextField()
        textField.placeholder = "Enter your username"
        return textField
    }()
    
    private let emailTextField : UITextField = {
        let et = UITextField()
        et.placeholder = "Enter your mail"
        return et
    }()
    
    
    private let passwordTextField : UITextField = {
        let pt = UITextField()
        pt.placeholder = "Enter your password"
        return pt
    }()
    
    private let signInButton : UIButton = {
        let lb = UIButton(type: .system)
        lb.setTitle("SignIn", for: .normal)
        lb.backgroundColor = .black
        lb.tintColor = .cyan
        lb.addTarget(self, action: #selector(handleSignIn), for: .touchUpInside)
        lb.backgroundColor = UIColor.rgb(red: 149, green: 204, blue: 244)
        lb.layer.cornerRadius = 5
        lb.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        lb.setTitleColor(.white, for: .normal)
        return lb
    }()
    
    private let alreadyHaveAccount: UIButton = {
       let button = UIButton()
        button.setTitle("Already have account? LogIn", for: .normal)
        button.addTarget(self, action: #selector(handlealreadyHaveAccount), for: .touchUpInside)
        button.layer.cornerRadius = 5
        button.backgroundColor = .gray
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        navigationController?.isNavigationBarHidden = true
        signInDesign()
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    @objc func handleSignIn(){
        print("sigIn")
    }
    
    @objc func handlealreadyHaveAccount(){
        navigationController?.pushViewController(LogInController(), animated: true)
    }
    
    func signInDesign(){
        
        let stack = UIStackView(arrangedSubviews: [userName,emailTextField,passwordTextField,signInButton])
        stack.axis = .vertical
        stack.spacing = 10
        stack.distribution = .fillEqually
        
        view.addSubview(stack)
        stack.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 140, paddingLeft: 12, paddingBottom: 0, paddingRight: 12, width: 300, height: 300)
        
        view.addSubview(alreadyHaveAccount)
        alreadyHaveAccount.anchor(top: nil, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 12, paddingBottom: 102, paddingRight: 12, width: 0, height: 0)
    }
    
    
}
