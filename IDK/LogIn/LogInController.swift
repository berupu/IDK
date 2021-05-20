//
//  LogInController.swift
//  IDK
//
//  Created by be RUPU on 2/5/21.
//

import UIKit
import Firebase

class LogInController: UIViewController {
    
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
    
    private let loginButton : UIButton = {
        let lb = UIButton(type: .system)
        lb.setTitle("Login", for: .normal)
        lb.addTarget(self, action: #selector(handleLogin), for: .touchUpInside)
        lb.backgroundColor = UIColor.rgb(red: 149, green: 204, blue: 244)
        lb.layer.cornerRadius = 5
        lb.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        lb.setTitleColor(.white, for: .normal)
        return lb
    }()
    
    private let dontHaveAccount : UIButton = {
       let button = UIButton()
        let attributedText = NSMutableAttributedString(string: "Don't have an account?", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14), NSAttributedString.Key.foregroundColor: UIColor.gray])
        
        attributedText.append(NSAttributedString(string: " SignIn", attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 14), NSAttributedString.Key.foregroundColor: UIColor.darkGray]))
        
        button.setAttributedTitle(attributedText, for: .normal)
        button.addTarget(self, action: #selector(handleDontHaveAccount), for: .touchUpInside)
        button.layer.cornerRadius = 5
        return button
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        loginDesign()
        
    }
    
    @objc fileprivate func handleLogin(){
        print("Log in works")
        
        guard let email = emailTextField.text else {return}
        guard let password = passwordTextField.text else {return}
        
        Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
            
            if error != nil{
                print("failed to logIn: \(String(describing: error))")
            }
            
            print("successfully logged in")
            
            let navController = UINavigationController(rootViewController: ViewController())
            navController.modalPresentationStyle = .fullScreen
            self.present(navController, animated: true, completion: nil)
            
        }

    }
    
    @objc func handleDontHaveAccount(){
        print("sign up")
        
        let navController = UINavigationController(rootViewController: SignUpController())
        navController.modalPresentationStyle = .fullScreen
        present(navController, animated: true, completion: nil)
    }
    
    func loginDesign(){
        let stack = UIStackView(arrangedSubviews: [emailTextField,passwordTextField,loginButton])
        stack.axis = .vertical
        stack.spacing = 10
        stack.distribution = .fillEqually
        
        view.addSubview(stack)
        stack.anchor(top: view.topAnchor, leading: view.leadingAnchor, trailing: view.trailingAnchor, bottom: nil, centerX: nil, centerY: nil, width: nil, height: nil, topConstant: 140, leadingConstant: 12, trailingConstant: 12, bottomConstant: 0, centerXConstant: 0, centerYConstant: 0, widthConstant: 200, heightConstant: 200)
        
        view.addSubview(dontHaveAccount)
        dontHaveAccount.anchor(top: nil, leading: view.leadingAnchor, trailing: view.trailingAnchor, bottom: view.bottomAnchor, centerX: nil, centerY: nil, width: nil, height: nil, topConstant: 0, leadingConstant: 12, trailingConstant: 12, bottomConstant: 102, centerXConstant: 0, centerYConstant: 0, widthConstant: 0, heightConstant: 0)
    }
    
}
