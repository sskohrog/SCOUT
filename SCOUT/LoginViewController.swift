//
//  ViewController.swift
//  SCOUT
//
//  Created by ahmed waheeb on 11/10/16.
//  Copyright © 2016 ScoutApp. All rights reserved.
//

import UIKit
import Firebase
class LoginViewController: UIViewController {

    @IBOutlet weak var Username: UITextField!
    @IBOutlet weak var Password: UITextField!
    let mainController = MainViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func CreateAccount(_ sender: Any) {
        FIRAuth.auth()?.createUser(withEmail: Username.text!, password: Password.text!, completion:{
            
            user, error in
            
            if error != nil{
                self.login()
            }
            else
            {
                print("User created!")
                self.login()
            }
            
            
        })
    }
  
   
    @IBAction func NewUserRegester(_ sender: Any) {
        self.performSegue(withIdentifier: "signUpSeg", sender: self)

    }
  

    func login(){
        FIRAuth.auth()?.signIn(withEmail: Username.text!, password: Password.text!, completion:{
            
            user, error in
            
            if error != nil{
                print("Password/User is incorrect!")
            }
            else
            {

            
                _ = self.navigationController?.popViewController(animated: true)
                
                self.dismiss(animated: true, completion: nil)            }
           
            
            
        
        })    }
}

