//
//  ViewController.swift
//  Flash Chat
//
//

import UIKit
import Firebase

class ChatViewController: UIViewController {
    
   // Instance variables

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

      // Set the tapGesture

      // Register MessageCell.xib file

   }

   ///////////////////////////////////////////

   //MARK: - TableView DataSource Methods



   //TODO: Declare cellForRowAtIndexPath here:



   //TODO: Declare numberOfRowsInSection



   //TODO: Declare tableViewTapped



   //TODO: Declare configureTableView



   ///////////////////////////////////////////

   //MARK:- TextField Delegate Methods




   //TODO: Declare textFieldDidBeginEditing




   //TODO: Declare textFieldDidEndEditing



   ///////////////////////////////////////////


   //MARK: - Send & Recieve from Firebase





   @IBAction func sendPressed(_ sender: AnyObject) {


   //TODO: Send the message to Firebase and save it in our database


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
