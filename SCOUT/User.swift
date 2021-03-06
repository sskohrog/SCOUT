//
//  User.swift
//  SCOUT
//
//  Created by Mohammed Islubee & Sophie Kohrogi on 11/26/16.
//  Copyright © 2016 ScoutApp. All rights reserved.
//
//  User object

import Foundation
import Firebase
import FirebaseDatabase

struct User {
    
    var username: String!
    var email: String!
    var usertypee: String!
    var ref: FIRDatabaseReference?
    var userprofileimage: String!
    var key: String
    
    init(snapshot: FIRDataSnapshot) {
        key = snapshot.key
        
        let snapshotValue = snapshot.value as? NSDictionary
        username = snapshotValue?["name"] as? String
        email = snapshotValue?["email"] as? String
        usertypee = snapshotValue?["usertype"] as? String
        userprofileimage = snapshotValue?["profileImageUrl"] as? String
        ref = snapshot.ref
    }
}
