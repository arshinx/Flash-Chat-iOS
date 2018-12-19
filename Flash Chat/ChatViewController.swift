//
//  ViewController.swift
//  Flash Chat
//
//

import UIKit
import Firebase

class ChatViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {
    
   // Instance variables
   let keyboardRatio = 2.4216216216216218

   // We've pre-linked the IBOutlets
   @IBOutlet var heightConstraint: NSLayoutConstraint!
   @IBOutlet var sendButton: UIButton!
   @IBOutlet var messageTextfield: UITextField!
   @IBOutlet var messageTableView: UITableView!

   override func viewDidLoad() {
   super.viewDidLoad()

      // Set VC as the delegate and datasource
      messageTableView.delegate = self
      messageTableView.dataSource = self

      // Set VC as the delegate of the text field
      messageTextfield.delegate = self
      
      // Set the tapGesture
      let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tableViewTapped))
      messageTableView.addGestureRecognizer(tapGesture)
      
      // Register MessageCell.xib file
      messageTableView.register(UINib(nibName: "MessageCell", bundle: nil), forCellReuseIdentifier: "customMessageCell")

      // Enable Auto-resizing for cells
      configureTableView()
   }

   ///////////////////////////////////////////

   //MARK: - TableView DataSource Methods

   // cellForRowAtIndexPath
   func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      
      let cell = tableView.dequeueReusableCell(withIdentifier: "customMessageCell", for: indexPath) as! CustomMessageCell
      let messageArray = ["Message A", "MessageB", "Message C"]
      cell.messageBody.text = messageArray[indexPath.row]
      cell.senderUsername.text = "@username"
      return cell
   }

   // numberOfRowsInSection
   func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      return 3
   }

   // Declare tableViewTapped (selector reference)
   @objc func tableViewTapped() {
      messageTextfield.endEditing(true)
   }

   // Flexible sizing for cells
   func configureTableView() {
      messageTableView.rowHeight = UITableView.automaticDimension
      messageTableView.estimatedRowHeight = 120.0
   }


   ///////////////////////////////////////////

   //MARK:- TextField Delegate Methods

   // Begins Editing
   func textFieldDidBeginEditing(_ textField: UITextField) {
      
      // Animate
      UIView.animate(withDuration: 0.3) {
         // move up message textfield
         if (UIScreen.main.bounds.height >= 800) {
            self.heightConstraint.constant = 370
         } else if (UIScreen.main.bounds.height >= 700 && UIScreen.main.bounds.height < 800) {
            self.heightConstraint.constant = 330
         } else {
            self.heightConstraint.constant = 320
         }
         self.view.layoutIfNeeded()
      }
   }

   // Ends Editing
   func textFieldDidEndEditing(_ textField: UITextField) {
      
      // Animate Back
      UIView.animate(withDuration: 0.5) {
         // move down message textfield
         self.heightConstraint.constant = 50
         self.view.layoutIfNeeded()
      }
      
   }

   
   ///////////////////////////////////////////


   // MARK: - Send & Recieve from Firebase

   @IBAction func sendPressed(_ sender: AnyObject) {
      
      // hide keyboard
      messageTextfield.endEditing(true)
      
      // Disable UI Elements
      messageTextfield.isEnabled = false
      sendButton.isEnabled = false
      
      // Send the message to Firebase and save it in our database
      let messagesDB = Database.database().reference().child("Messages")
      let messageDictionary = ["Sender": Auth.auth().currentUser?.email,
                               "MessageBody": messageTextfield.text!]
      
      // Allows messages to be saved via custom identifier and saves values
      messagesDB.childByAutoId().setValue(messageDictionary) {
         (error, reference) in
         
         // Error
         if error != nil {
            print(error!)
         } else {
            print("\n\n Message Saved!! \n\n")
            
            // Enable UI
            self.messageTextfield.isEnabled = true
            self.sendButton.isEnabled = true
            self.messageTextfield.text = ""
         }
      }
      
   }

   //TODO: Create the retrieveMessages method here:


   @IBAction func logOutPressed(_ sender: AnyObject) {

      // Log out the user and send them back to WelcomeViewController
      do {
         try Auth.auth().signOut()
         navigationController?.popViewController(animated: true)
      } catch {
         print("Error Signing out!")
      }

   }
}
