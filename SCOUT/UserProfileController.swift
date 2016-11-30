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
import MessageUI

class UserProfileController: UIViewController, MFMailComposeViewControllerDelegate {
    
    @IBOutlet weak var username: UILabel!
    @IBOutlet weak var usertype: UILabel!
    @IBOutlet weak var email: UIButton!
    @IBOutlet weak var userprofpic: UIImageView!
    
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
                    self.email.setTitle(userr.email, for: .normal)
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
    
    @IBAction func sendEmailButton(sender: AnyObject) {
        if MFMailComposeViewController.canSendMail() {
            let email = MFMailComposeViewController()
            email.mailComposeDelegate = self
            email.setToRecipients(["\(self.email.titleLabel!.text)"])
            email.setSubject("Hi \(self.username.text)! I found you on SCOÜT!")
            email.setMessageBody("I found you on SCOÜT and wanted to get to know you better.", isHTML: false)
        } else {
            print("can't send message")
        }
    }
}









