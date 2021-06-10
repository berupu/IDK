//
//  ChatController.swift
//  IDK
//
//  Created by be RUPU on 26/5/21.
//

import UIKit
import Firebase


class ChatController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    private let reuseIdentifier = "ChatCell"

    
    var sentMessage = [MessageModel]()
    
    var user: User?
  
    //MARK: - InputAccessoryView Implementation
    
    lazy var chatView : CustomInputAccessoryView = {
        let iv = CustomInputAccessoryView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 60))
        
        iv.delegate = self
        
        
        return iv
    }()
    
    override var inputAccessoryView: UIView? {
        get { return chatView }
    }
    
    override var canBecomeFirstResponder: Bool {
        return true
    }
    
    
    init(user: User){
        self.user = user
        super.init(collectionViewLayout: UICollectionViewFlowLayout())
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.backgroundColor = .white
        collectionView.alwaysBounceVertical = true
        collectionView.keyboardDismissMode = .interactive
      
        navigationItem.title = user?.username
        collectionView.register(ChatCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        collectionView.register(HeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "headerID")
        
        
        configureChatView()
        fetchMessages()
       
        
    }
    
    
    func configureChatView(){        
        //navigationController?.isNavigationBarHidden = true
    }

    
    //MARK: - selector
    
    @objc func handleDissmiss(){
        dismiss(animated: true, completion: nil)
    }


}

    //MARK: - collectionView

extension ChatController {
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return sentMessage.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! ChatCell
        
        cell.message = sentMessage[indexPath.row]
        cell.user = user
        
        return cell
    }
    
    //top Space for collectionViewCell
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .init(top: 16, left: 0, bottom: 16, right: 0)
    }
    
    //cell size
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: view.frame.width, height: 50)
    }
    
    
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "headerID", for: indexPath) as! HeaderView
        
        header.profileImage.image = MassageCell.storedImage
        header.nameLabel.text = user?.username
        header.dissMissButton.addTarget(self, action: #selector(handleDissmiss), for: .touchUpInside)
       
        return header
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.width, height: 96)
    }
    
}

//MARK: - SendMessageDelegate

extension ChatController: SendMessageDelegate {

    func sendMessage(_ text: String) {
        
        
        guard let currentUser = Auth.auth().currentUser?.uid else {return}
        guard let toUser = user?.uid else {return}

        let values = ["text": text,"fromID": currentUser,"toID": toUser] as [String : Any]
        
        
        Database.database().reference().child("Recent Messages").child(currentUser).child((user?.uid)!).childByAutoId().setValue(values) { [self] (err, ref) in
                        
            
            if err != nil {
                print("failed to save message data")
            }
            Database.database().reference().child("Recent Messages").child((user?.uid)!).child(currentUser).childByAutoId().setValue(values) { (err, ref) in
                
                //
            }
        }
    }

    func fetchMessages(){
        
        var myArray = [MessageModel]()
        
        guard let currentUser = Auth.auth().currentUser?.uid else {return}
        guard let toUser = user?.uid else {return}
        
        let query = Database.database().reference().child("Recent Messages").child(toUser).child(currentUser)

        query.observe(.childAdded) { [self] (snapshot) in
            
            let messageDictionary = MessageModel(dictionary: snapshot.value as! [String : Any])
            
            myArray.append(messageDictionary)
            let lastElement = myArray.last
        
            
            sentMessage.append(lastElement!)
            self.collectionView.reloadData()
            self.collectionView.scrollToItem(at: [0, sentMessage.count - 1], at: .bottom, animated: true)
        }
        
    }
    
}

