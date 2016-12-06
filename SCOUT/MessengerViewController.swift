//
//  MessengerViewController.swift
//  SCOUT
//
//  Created by Mohammed Islubee & Sophie Kohrogi on 12/3/16.
//  Copyright © 2016 ScoutApp. All rights reserved.
//
// table view controller for the messenger list

import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase
import FirebaseStorage

class MessengerViewController: UITableViewController {
    
    var users = [User]()
    var messageCount: Int!
    
    var databaseRef : FIRDatabaseReference!{
        return FIRDatabase.database().reference()
    }
    
    // returns only one section beacuse it only
    // needs to list messages
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    // sets the section header title
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Messages:"
    }
    
    // returns ten rows.
    // will implement this better once we get a APN certificate
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    //sets the other user's profile picture and name on the message cels
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let msgCell = tableView.dequeueReusableCell(withIdentifier: "MessageCell", for: indexPath) as! MessageCell
        
        databaseRef.child("users").observe(.childAdded, with: { (snapshot) in
            
            let user = User(snapshot: snapshot)
            self.users.append(user)
            
            msgCell.nameLabel.text = self.users[indexPath.row].username
            
            if let profileImageUrl = self.users[indexPath.row].userprofileimage{
                let url = Foundation.URL(string: profileImageUrl)
                
                Foundation.URLSession.shared.dataTask(with: url!, completionHandler: { (data,response,error) in
                    DispatchQueue.main.async{
                        msgCell.userImg.image = UIImage(data: data!)
                    }
                    
                }).resume()
            }
        }, withCancel: nil)

        return msgCell
    }
}
