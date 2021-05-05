//
//  SignUpController.swift
//  IDK
//
//  Created by be RUPU on 2/5/21.
//

import UIKit
import Firebase

class SignUpController: UIViewController{
    

    private let userNameTextField : UITextField = {
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
        
        let attributedText = NSMutableAttributedString(string: "Already ave a account?", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14), NSAttributedString.Key.foregroundColor: UIColor.gray])
        
        attributedText.append(NSAttributedString(string: " LogIn", attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 14), NSAttributedString.Key.foregroundColor: UIColor.darkGray]))
        
        button.setAttributedTitle(attributedText, for: .normal)
        
        button.addTarget(self, action: #selector(handlealreadyHaveAccount), for: .touchUpInside)
        button.layer.cornerRadius = 5
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
        
        guard let username = userNameTextField.text, username.count > 0 else {return}
        guard let email = emailTextField.text, email.count > username.count else {return}
        guard let password = passwordTextField.text, password.count > 0 else {return}
        
        Auth.auth().createUser(withEmail: email, password: password) { (user, error) in
            
            if error != nil {
                print("failed to create user")
            }
            
            print("succefully created user")
            
            let randomNum = NSUUID().uuidString
            let values = ["userName": username]
            
            Database.database().reference().child("Users").child(randomNum).updateChildValues(values) { (err, ref) in
                
                if error != nil {
                    print("failed to save user date")
                }
                
                print("succefully saved user date")
            }
        }
    
    }
    
    @objc func handlealreadyHaveAccount(){
        navigationController?.pushViewController(LogInController(), animated: true)
    }
    
    func signInDesign(){
        
        let stack = UIStackView(arrangedSubviews: [userNameTextField,emailTextField,passwordTextField,signInButton])
        stack.axis = .vertical
        stack.spacing = 10
        stack.distribution = .fillEqually
        
        view.addSubview(stack)
        stack.anchor(top: view.topAnchor, leading: view.leadingAnchor, trailing: view.trailingAnchor, bottom: nil, centerX: nil, centerY: nil, width: nil, height: nil, topConstant: 140, leadingConstant: 12, trailingConstant: 12, bottomConstant: 0, centerXConstant: 0, centerYConstant: 0, widthConstant: 300, heightConstant: 300)
        
        view.addSubview(alreadyHaveAccount)
        alreadyHaveAccount.anchor(top: nil, leading: view.leadingAnchor, trailing: view.trailingAnchor, bottom: view.bottomAnchor, centerX: nil, centerY: nil, width: nil, height: nil, topConstant: 0, leadingConstant: 12, trailingConstant: 12, bottomConstant: 102, centerXConstant: 0, centerYConstant: 0, widthConstant: 0, heightConstant: 0)
        
    }
    
    
}
