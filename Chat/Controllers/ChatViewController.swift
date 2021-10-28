//
//  ChatViewController.swift
//  Chat
//
//  Created by Alexander on 07.09.2021.
//

import UIKit
import Firebase

class ChatViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var messageTextfield: UITextField!
    @IBOutlet weak var containerView: UIView!
    
    let db = Firestore.firestore()
    var messages: [Message] = []
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //UI improvements
        containerView.layer.cornerRadius = 24
        containerView.layer.shadowColor = UIColor.black.cgColor
        containerView.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        containerView.layer.shadowOpacity = 0.2
        containerView.layer.shadowRadius = 4
        
        
        tableView.dataSource = self
        title = "⚡️FlashChat"
        navigationItem.hidesBackButton = true
        
        loadMessages()
    }
    
    func loadMessages() {
        
        db.collection("messages")
            .order(by: "date")
            .addSnapshotListener { (querySnapshot, error) in
                
                self.messages = []
                
                if let error = error {
                    print("There was an issue retrieving data from Firestore. \(error)")
                } else {
                    if let snapshotDocuments = querySnapshot?.documents {
                        for doc in snapshotDocuments {
                            let data = doc.data()
                            if let messageSender = data["sender"] as? String,
                               let messageBody = data["body"] as? String,
                               let dayDate = data["dayDate"] as? String,
                               let timeDate = data["timeDate"] as? String{
                                
                                let newMessage = Message(sender: messageSender, body: messageBody, dayDate: dayDate, timeDate: timeDate)
                                self.messages.append(newMessage)
                                
                                DispatchQueue.main.async {
                                    self.tableView.reloadData()
                                    let indexPath = IndexPath(row: self.messages.count - 1, section: 0)
                                    self.tableView.scrollToRow(at: indexPath, at: .top, animated: false)
                                }
                            }
                        }
                    }
                }
            }
        
    }
    
    @IBAction func sendPressed(_ sender: UIButton) {
        
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "dd MMM"
        let dayDate = formatter.string(from: date)
        formatter.dateFormat = "HH:mm"
        let timeDate = formatter.string(from: date)
        
        
        if let messageBody = messageTextfield.text, let messageSender = Auth.auth().currentUser?.email {
            db.collection("messages").addDocument(data: [
                "sender": messageSender,
//                "reciepient": 
                "body": messageBody,
                "date": Date().timeIntervalSince1970,
                "dayDate": dayDate,
                "timeDate": timeDate
            ]) { (error) in
                if let error = error {
                    print("There was an issue saving data to firestore, \(error)")
                } else {
                    print("Successfully saved data.")
                    
                    DispatchQueue.main.async {
                        self.messageTextfield.text = ""
                    }
                }
            }
        }
        
    }
    
    @IBAction func logOutPressed(_ sender: UIBarButtonItem) {
        do {
            try Auth.auth().signOut()
            navigationController?.popToRootViewController(animated: true)
        } catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
        }
    }
}

//MARK: - UITableViewDataSource

extension ChatViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let message = messages[indexPath.row]
        
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "dd MMM"
        let currentDay = formatter.string(from: date)
        var dateLabel = ""
        
        if message.dayDate == currentDay {
            dateLabel = message.timeDate
        } else {
            dateLabel = "\(message.dayDate)\n\(message.timeDate)"
        }
        
        //This is a message from the current user.
        if message.sender == Auth.auth().currentUser?.email {
            let cell = tableView.dequeueReusableCell(withIdentifier: "UserCell", for: indexPath) as! UserMessageCell
            cell.messageLabel.text = message.body
            cell.dateLabel.text = dateLabel
            return cell
        }
        //This is a message from another sender.
        else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "SenderCell", for: indexPath) as! SenderMessageCell
            cell.messageLabel.text = message.body
            cell.dateLabel.text = dateLabel
            return cell
        }
        
    }
    
}
