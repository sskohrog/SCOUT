//
//  UserProfile.swift
//  SCOUT
//
//  Created by ahmed waheeb on 11/26/16.
//  Copyright © 2016 ScoutApp. All rights reserved.
//
import UIKit
import Foundation
import Firebase
import FirebaseAuth
import FirebaseDatabase
import FirebaseStorage

class UserProfileController: UIViewController {
    
    @IBOutlet weak var username: UITextField!
    
    @IBOutlet weak var userprofpic: UIImageView!
    @IBOutlet weak var usertype: UITextField!

    @IBOutlet weak var email: UITextField!
    var databaseRef : FIRDatabaseReference!{
        return FIRDatabase.database().reference()
    }
    
    var strorageRef : FIRStorageReference!{
        return FIRStorage.storage().reference()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if FIRAuth.auth()?.currentUser == nil{
            
            
        }
        else
        {
            
            databaseRef.child("users/\(FIRAuth.auth()!.currentUser!.uid)").observe(.value, with: {(snapshot) in
         
                DispatchQueue.main.async {
                    let userr = User(snapshot: snapshot)
                    self.username.text = userr.username
                    self.email.text = userr.email
                    self.usertype.text = userr.usertypee
                    
                    if let profileImageUrl = userr.userprofileimage{
                        let url = Foundation.URL(string: profileImageUrl)
                        
                        Foundation.URLSession.shared.dataTask(with: url!, completionHandler: { (data,response,error) in
                            DispatchQueue.main.async{
                            self.userprofpic.image = UIImage(data: data!)
                            }
                            
                        }).resume()
                    }
                }
       
            }, withCancel: { (error) in
                print(error.localizedDescription)
            })
   
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
 
}
