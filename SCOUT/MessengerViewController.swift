//
//  MessengerViewController.swift
//  SCOUT
//
//  Created by Sophie Kohrogi on 12/3/16.
//  Copyright © 2016 ScoutApp. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase
import FirebaseStorage


class MessengerViewController: UITableViewController {
    
    var users = [User]()
    
    var databaseRef : FIRDatabaseReference!{
        return FIRDatabase.database().reference()
    }
    
    var strorageRef : FIRStorageReference!{
        return FIRStorage.storage().reference()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let msgCell = tableView.dequeueReusableCell(withIdentifier: "MessageCell", for: indexPath) as! MessageCell
        
        FIRDatabase.database().reference().child("users").observe(.childAdded, with: { (snapshot) in
            
            let user = User(snapshot: snapshot)
            self.users.append(user)
            
            
            
            
        }, withCancel: nil)

        
        
        
        return msgCell
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Messages:"
    }
}
