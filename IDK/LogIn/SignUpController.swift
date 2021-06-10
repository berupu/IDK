//
//  SignUpController.swift
//  IDK
//
//  Created by be RUPU on 2/5/21.
//

import UIKit
import Firebase

class SignUpController: UIViewController{
    
    //MARK: - Properties
    
    var imageURL : String?
    
    let profileImageButton : UIButton = {
        let pi = UIButton(type: .system)
        pi.layer.borderWidth = 5
        pi.layer.borderColor = UIColor.black.cgColor
        pi.layer.masksToBounds = true
        pi.contentMode = .scaleAspectFill
        pi.addTarget(self, action: #selector(handleProfileImge), for: .touchUpInside)
        return pi
    }()

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
    
    //MARK: - Selector
    
    @objc func handleProfileImge(){
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.allowsEditing = true
        
        present(imagePickerController, animated: true, completion: nil)
    }
  
    
    @objc func handleSignIn(){
        print("sigIn")
    
        guard let username = userNameTextField.text, username.count > 0 else {return}
        guard let email = emailTextField.text, email.count > username.count else {return}
        guard let password = passwordTextField.text, password.count > 0 else {return}
        
        Auth.auth().createUser(withEmail: email, password: password) { [self] (result, error) in
            
            if error != nil {
                print("failed to create user")
            }
            
            guard let currentUser = result?.user.uid else {return}
            let randomNumber = NSUUID().uuidString
            
            let storageRef = Storage.storage().reference().child("Profile Images").child(currentUser)
            
            
            guard let profileImage = profileImageButton.imageView?.image?.jpegData(compressionQuality: 0.3) else {return}
            
            
            storageRef.putData(profileImage, metadata: nil) { (metaData, err) in
                
                if error != nil{
                    print("failed to upload image")
                }
                
                storageRef.downloadURL { (url, err) in
                    if error != nil{
                        print("failed to upload image")
                    }
                    
                    guard let url = url else {return}
                    
                    imageURL = url.absoluteString
                    
                    let values = ["userName": username, "Uid": currentUser, "profileImgaeURL": imageURL]
                    
                    Database.database().reference().child("Users").child(randomNumber).updateChildValues(values as [String : Any]) { (err, ref) in
                        
                        if error != nil {
                            print("failed to signUp")
                        }
                        
                        print("succefully signUp")
                    }
                    
                }
        }
    
            let viewController = ViewController()
            let navController = UINavigationController(rootViewController: viewController)
            navController.modalPresentationStyle = .fullScreen
            self.present(navController, animated: true, completion: nil)
        }
    
    }
    
    @objc func handlealreadyHaveAccount(){
        navigationController?.pushViewController(LogInController(), animated: true)
    }
    
    
    
    func signInDesign(){
        
        view.addSubview(profileImageButton)
        profileImageButton.anchor(top: view.topAnchor, leading: nil, trailing: nil, bottom: nil, centerX: view.centerXAnchor, centerY: nil, width: nil, height: nil, topConstant: 50, leadingConstant: 0, trailingConstant: 0, bottomConstant: 0, centerXConstant: 0, centerYConstant: 0, widthConstant: 120, heightConstant: 120)
        profileImageButton.layer.cornerRadius = 120/2
        
        let stack = UIStackView(arrangedSubviews: [userNameTextField,emailTextField,passwordTextField,signInButton])
        stack.axis = .vertical
        stack.spacing = 10
        stack.distribution = .fillEqually
        
        view.addSubview(stack)
        stack.anchor(top: profileImageButton.bottomAnchor, leading: view.leadingAnchor, trailing: view.trailingAnchor, bottom: nil, centerX: nil, centerY: nil, width: nil, height: nil, topConstant: 80, leadingConstant: 12, trailingConstant: 12, bottomConstant: 0, centerXConstant: 0, centerYConstant: 0, widthConstant: 300, heightConstant: 300)
        
        view.addSubview(alreadyHaveAccount)
        alreadyHaveAccount.anchor(top: nil, leading: view.leadingAnchor, trailing: view.trailingAnchor, bottom: view.bottomAnchor, centerX: nil, centerY: nil, width: nil, height: nil, topConstant: 0, leadingConstant: 12, trailingConstant: 12, bottomConstant: 102, centerXConstant: 0, centerYConstant: 0, widthConstant: 0, heightConstant: 0)
        
    }
    
    
}

//MARK: - ImagePickerController

extension SignUpController: UIImagePickerControllerDelegate , UINavigationControllerDelegate {
    
    internal func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        
        if let editedImage = info[.editedImage] as? UIImage {
            profileImageButton.setImage(editedImage.withRenderingMode(.alwaysOriginal), for: .normal)
            
            
        } else if let originalImage = info[.originalImage] as? UIImage {
            profileImageButton.setImage(originalImage.withRenderingMode(.alwaysOriginal), for: .normal)
            
        }
        picker.dismiss(animated: true, completion: nil)
    }
}
