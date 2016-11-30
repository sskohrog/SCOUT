//
//  MainViewController.swift
//  SCOUT
//
//  Created by ahmed waheeb on 11/10/16.
//  Copyright © 2016 ScoutApp. All rights reserved.
//



import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase
class MainViewController: UITableViewController {
    
    
    var count = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        //self.performSegue(withIdentifier: "segLogView", sender: self)
        // Do any additional setup after loading the view, typically from a nib.
        
    }
//    @IBAction func signOut(_ sender: Any) {
//       if (FIRAuth.auth()?.currentUser != nil)
//       {
//            do
//            {
//                try FIRAuth.auth()?.signOut()
//                count = 0
//                self.performSegue(withIdentifier: "segLogView", sender: self)
//                
//            }catch let error as NSError{
//                print(error.localizedDescription)
//        }
//       }
//    }
//    override func didReceiveMemoryWarning() {
//        super.didReceiveMemoryWarning()
//    }
//    override func viewWillAppear(_ animated: Bool) {
//        if(count == 0)
//        {
//            
//        }
//        else
//        {
//            print("appeareeeeeeeeeeeeeeeeeeeeeeed")
//            if let uid = FIRAuth.auth()?.currentUser?.uid
//            {
//                FIRDatabase.database().reference().child("users").child(uid).observeSingleEvent(of: .value, with: {
//                    (snapshot) in
//                    if let dictionary = snapshot.value as? [String: Any]{
//                        self.navigationItem.title = dictionary["name"] as? String
//                        
//                    }
//                    
//                }, withCancel: nil)
//            }
//            
//        }
//        count = count+1
//        
//        
//    }
    
    
}
