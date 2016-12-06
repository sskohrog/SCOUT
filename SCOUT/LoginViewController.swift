//
//  LoginViewController.swift
//  SCOUT
//
//  Created by Mohammed Islubee & Sophie Kohrogi on 11/10/16.
//  Copyright © 2016 ScoutApp. All rights reserved.
//
//  The view controller of the login page, where users input
//  their email and pw to gain access to their account

import UIKit
import Firebase

class LoginViewController: UIViewController {

    // Outlet for username and password textfields
    // that user inputs
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

    // LoginAccount(_ sender: Any)
    //
    //If user has a valid account, it will log
    // them into their account, if not error msg
    @IBAction func LoginAccount(_ sender: Any) {
        FIRAuth.auth()?.createUser(withEmail: Username.text!, password: Password.text!, completion:{
            
            user, error in
            
            if error != nil {
                self.login()
            }
            else {
                print("User logged in!")
                self.login()
            }
        })
    }
  
    // NewUserRegister(_ sender: Any)
    //
    // Registers a new user by segueing to the 
    // ModelPhotographerViewController which is the sign
    // up view
    @IBAction func NewUserRegister(_ sender: Any) {
        self.performSegue(withIdentifier: "signUpSeg", sender: self)
    }
  
    // login()
    //
    // Controller of logging user into their account.
    // If user has correct email and pw, it will
    // direct user to DISCOVER page.
    // If user has an incorrect email/pw combo, it will
    // pop up an alert box warning users that their
    // combo doesn't work.
    func login(){
        FIRAuth.auth()?.signIn(withEmail: Username.text!, password: Password.text!, completion:{
            
            user, error in
            
            if error != nil {
                print("Password/User is incorrect!")
                
                let warning = UIAlertController(title: "LOGIN ERROR:",
                                                message: "Incorrect email or password.",
                                                preferredStyle: UIAlertControllerStyle.alert)
                let okay = UIAlertAction(title: "Try again", style: .default, handler: nil)
                warning.addAction(okay)
                
                self.present(warning, animated: false, completion: nil)
            } else {
                _ = self.navigationController?.popViewController(animated: true)
                
                self.dismiss(animated: true, completion: nil)
            }
        })
    }
}

