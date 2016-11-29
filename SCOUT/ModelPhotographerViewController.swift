//
//  DriverPhotographerViewController.swift
//  SCOUT
//
//  Created by ahmed waheeb on 11/12/16.
//  Copyright © 2016 ScoutApp. All rights reserved.
//

import Foundation
import UIKit
import Firebase
class ModelPhotographerController: UIViewController {
    var modelE = ModelSignUpController()
    var photoE = PhotographerSignUpController()
    var userName: String?
    var passwordEntered: String?
    var photographerUserName: String?
    var photographerPasswordEntered: String?
    var accoutType = 1
    var flag: String!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        firstView.isHidden = true
        secondView.isHidden = false
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func indexHasChanged(_ sender: UISegmentedControl) {
        
        if sender.selectedSegmentIndex == 0
        
        {
            firstView.isHidden = false
            secondView.isHidden = true
            accoutType = 0
        }
        else
        {
     
            firstView.isHidden = true
            secondView.isHidden = false
            accoutType = 1
    
        }

    }
   
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if  segue.identifier == "modelSeg"
        {
            modelE = (segue.destination as? ModelSignUpController)!
            flag = "model"
        }
        else if segue.identifier == "photogSeg"
        {
            photoE = (segue.destination as? PhotographerSignUpController)!
            flag = "photographer"
        }
    }
    @IBAction func signUpButton(_ sender: Any) {
        
        if (accoutType == 0)
        {
        
        FIRAuth.auth()?.createUser(withEmail: modelE.modelEmail.text!, password: modelE.modelPassword.text!, completion:{
            
            user, error in
            
            if error != nil{
                print("sign up error")
            }
            else
            {
                guard let uid = user?.uid else {
                    return
                }
                
                print("User created!")
            
                let ref = FIRDatabase.database().reference(fromURL: "https://scout-c335b.firebaseio.com/")
                let Values = ["email": self.modelE.modelEmail.text!, "name": self.modelE.modelName.text!]
                let usersReference = ref.child("users").child("models").child(uid)
                
                usersReference.updateChildValues(Values, withCompletionBlock: {(err,ref)
                    in
                    if err != nil{
                        print(err as Any)
                        return
                    }
                    print("user has been added to database")
                    
                    
                })

                self.goBackToSignInPage(self)
            }
            
            
        })
        }
        else
        {
            FIRAuth.auth()?.createUser(withEmail: photoE.photographerEmail.text!, password: photoE.phtographerPassword.text!, completion:{
                
                user, error in
                
                if error != nil{
                    print("sign up error")
                }
                else
                {
                    print("User created!")
                    guard let uid = user?.uid else {
                        return
                    }
                    
                    print("User created!")
                    
                    let ref = FIRDatabase.database().reference(fromURL: "https://scout-c335b.firebaseio.com/")
                    let Values = ["email": self.photoE.photographerEmail.text!, "name": self.photoE.photographerName.text!]
                    let usersReference = ref.child("users").child("photographers").child(uid)
                    
                    usersReference.updateChildValues(Values, withCompletionBlock: {(err,ref)
                        in
                        if err != nil{
                            print(err as Any)
                            return
                        }
                        print("user has been added to database")
                        
                        
                    })
                    self.goBackToSignInPage(self)
                }
                
                
            })
        }
    }
    

 
    @IBOutlet weak var secondView: UIView!
    @IBOutlet weak var firstView: UIView!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    
    @IBAction func goBackToSignInPage(_ sender: Any) {
        
        _ = self.navigationController?.popViewController(animated: true)
        
        self.dismiss(animated: true, completion: nil)
    }
    
   
    
}
