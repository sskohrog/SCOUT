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

class MainViewController: UIViewController {

    var count = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        self.performSegue(withIdentifier: "segLogView", sender: self)

        //  view.addSubview(swipeableView)
        // Do any additional setup after loading the view, typically from a nib.
    }
        
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
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if(count == 0) {
            
        }
        else {
         
            let draggableBackground: DraggableViewBackground = DraggableViewBackground(frame: self.view.frame)
            
            self.view.addSubview(draggableBackground)
            
            print("appeareeeeeeeeeeeeeeeeeeeeeeed")
            
        }
        count = count+1
    }
}
