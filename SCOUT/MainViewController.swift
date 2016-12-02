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
class MainViewController: UIViewController{
    
    
    var count = 0
 
    override func viewDidLoad() {
        super.viewDidLoad()
     
//        let statusBarHeight = UIApplication.shared.statusBarFrame.height
//        
//        let insets = UIEdgeInsets(top: statusBarHeight, left: 0, bottom: 0, right: 0)
//        tableView.contentInset = insets
       

        print("view did load")
        
        // Do any additional setup after loading the view, typically from a nib.
        
      }
//    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return 1
//    }
//    
//    override func numberOfSections(in tableView: UITableView) -> Int {
//        return 1
//    }
    
 
//    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        // Table view cells are reused and should be dequeued using a cell identifier.
//        
//        let cell = tableView.dequeueReusableCell(withIdentifier: "UserCell", for: indexPath) as! UserCell
//       
//        cell.nameLabel.text = "Mohammed"
//        //cell.photoImageView.image = meal.photo
//        cell.userTypeLabel.text = "model"
//        
//        return cell
//    }
    
    override func viewDidAppear(_ animated: Bool) {
       if (count == 0)
       {
        self.performSegue(withIdentifier: "segLogView", sender: self)
       }
        count += 1
        print("view did appeeeaaar")
        
    }
    @IBAction func signOut(_ sender: Any) {
       if (FIRAuth.auth()?.currentUser != nil)
       {
            do
            {
                try FIRAuth.auth()?.signOut()
                count = 0
                self.performSegue(withIdentifier: "segLogView", sender: self)
                
            }catch let error as NSError{
                print(error.localizedDescription)
        }
       }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
//    override func viewWillAppear(_ animated: Bool) {
//        if(count == 0)
//        {
//           
//        }
//        else
//        {
//            print("appeareeeeeeeeeeeeeeeeeeeeeeed")
////            if let uid = FIRAuth.auth()?.currentUser?.uid
////            {
////                FIRDatabase.database().reference().child("users").child(uid).observeSingleEvent(of: .value, with: {
////                    (snapshot) in
////                    if let dictionary = snapshot.value as? [String: Any]{
////                        self.navigationItem.title = dictionary["name"] as? String
////                        
////                    }
////                    
////                }, withCancel: nil)
////            }
//            
//        }
//        count = count+1
//        
//        
//    }
    
    
}
