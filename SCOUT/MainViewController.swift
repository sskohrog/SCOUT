//
//  MainViewController.swift
//  SCOUT
//
//  Created by Mohammed Islubee & Sophie Kohrogi on 11/10/16.
//  Copyright © 2016 ScoutApp. All rights reserved.
//
//  View controller of the DISCOVER page

import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase

class MainViewController: UIViewController {

    var count = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.performSegue(withIdentifier: "segLogView", sender: self)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // viewWillAppear(_ animated: Bool)
    //
    // loads draggableViewBackground into DISCOVER view, which controls the swipeable profile
    // cards and makes them visible on the view.
    override func viewWillAppear(_ animated: Bool) {
        if(count == 0) {
            
        }
        else {
            
            let draggableBackground: DraggableViewBackground = DraggableViewBackground(frame: self.view.frame)
            
            self.view.addSubview(draggableBackground)
            
        }
        count = count+1
    }

    // signOut(_ sender: Any)
    //
    // if user wants to sign out of their account, they can press
    // this button at the top of the app
    @IBAction func signOut(_ sender: Any) {
       if (FIRAuth.auth()?.currentUser != nil) {
            do {
                try FIRAuth.auth()?.signOut()
                
                self.performSegue(withIdentifier: "segLogView", sender: self)
                
            } catch let error as NSError {
                print(error.localizedDescription)
            }
        }
    }
}
