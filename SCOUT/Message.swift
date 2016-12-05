//
//  Message.swift
//  SCOUT
//
//  Created by Sophie Kohrogi on 12/3/16.
//  Copyright © 2016 ScoutApp. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class Message: NSObject {
    var name: String!
    var msg: String?
    var img: String!
    var ref: FIRDatabaseReference?
    var key: String
    
    init(snapshot: FIRDataSnapshot) {
        key = snapshot.key
        
        let snapshotValue = snapshot.value as? NSDictionary
        name = snapshotValue?["name"] as? String
        img = snapshotValue?["profileImageUrl"] as? String
        ref = snapshot.ref
    }
}
