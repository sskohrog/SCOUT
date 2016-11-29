//
//  ProfileViewController.swift
//  SCOUT
//
//  Created by Sophie Kohrogi on 11/28/16.
//  Copyright © 2016 ScoutApp. All rights reserved.
//

import UIKit
import Firebase
class ProfileViewController: UIViewController {
    
    @IBOutlet var aboutButton: UIButton!
    @IBOutlet var statButton: UIButton!
    @IBOutlet var genreButton: UIButton!
    @IBOutlet var reviewButton: UIButton!
    
    @IBOutlet var profileImgView: UIImageView!
    @IBOutlet var profileInfo: UILabel!
    
    var ref: FIRDatabaseReference!
    var refHandle: UInt!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ref = FIRDatabase.database().reference(fromURL: "https://scout-c335b.firebaseio.com/")
        refHandle = ref.observe(FIRDataEventType.value,
                                with: { (snapshot) in
                                    let dataDict = snapshot.value as! [String: AnyObject]
                                    
                                    print(dataDict)
        })
        
        self.performSegue(withIdentifier: "segLogView", sender: self)
        // Do any additional setup after loading the view, typically from a nib.
        
        //PROFILE IMAGE
        self.profileImgView.image = UIImage(named: "model_profile")
        
        //SET INFO
        //profileInfo.text =
        
        //SET BUTTON BORDERS
        aboutButton.layer.borderWidth = 0.8
        aboutButton.layer.borderColor = UIColor.lightGray.cgColor
        
        statButton.layer.borderWidth = 0.8
        statButton.layer.borderColor = UIColor.lightGray.cgColor
        
        genreButton.layer.borderWidth = 0.8
        genreButton.layer.borderColor = UIColor.lightGray.cgColor
        
        reviewButton.layer.borderWidth = 0.8
        reviewButton.layer.borderColor = UIColor.lightGray.cgColor
    }
    
    @IBAction func signOut(_ sender: Any) {
        if (FIRAuth.auth()?.currentUser != nil)
        {
            do
            {
                try FIRAuth.auth()?.signOut()
                
                self.performSegue(withIdentifier: "segLogView", sender: self)
                
                
            }catch let error as NSError{
                print(error.localizedDescription)
            }
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
}
