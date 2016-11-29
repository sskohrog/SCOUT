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
class ModelPhotographerController: UIViewController,UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var email: UITextField!
    var userName: String?
    @IBOutlet weak var password: UITextField!
    var passwordEntered: String?
    var photographerUserName: String?
    var photographerPasswordEntered: String?
    var accoutType: Int?
    
    @IBOutlet weak var userimageView: UIImageView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func choosePicture(_ sender: Any) {
        //instantiates the UIImagePickerController
        let imagePicker = UIImagePickerController()
        
        //sets sourceType of imagePicker
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            imagePicker.sourceType = .camera
        }
        else {
            imagePicker.sourceType = .photoLibrary
        }
        
        //sets DetailViewController as the delegate for imagePicker
        imagePicker.delegate = self
        
        //presents imagePicker modally
        present(imagePicker, animated: true, completion: nil)
    }
    
    private func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            userimageView.contentMode = .scaleAspectFit
            userimageView.image = pickedImage
        }
        
        dismiss(animated: true, completion: nil)
    }
    
    //delegate protocol for the UIImagePickerController that is called when the user selects a media item
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        print("imagePickerController(_:didFinishPickingMediaWithInfo:) delegate called.")
        
        //        for (key, value) in info {
        //            print("key: \(key) value: \(value)")
        //        }
        
        //info is a dictionary that contains information about the media (image) the user selected.
        //Subscript the dictionary with the appropriate key to get the image selected by the user
        let image = info[UIImagePickerControllerOriginalImage] as? UIImage
        
        //display the selected image on the imageView (by setting its image property)
        userimageView.image = image
        
        //item.image = image
        
        //store the selected image in the imageStore (which has a cache to store images)
     
        //dismiss the view of imagePicker (that was earlier presented modally)
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func indexHasChanged(_ sender: UISegmentedControl) {
        
        
        if sender.selectedSegmentIndex == 0
        
        {
         
            accoutType = 0
            print(accoutType!)
        }
        else
        {
     
         
            accoutType = 1
    
        }

    }
   
    
   
    @IBAction func signUpButton(_ sender: Any) {
        
    
        
        FIRAuth.auth()?.createUser(withEmail: self.email.text!, password: self.password.text!, completion:{
            
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
                
                if (self.accoutType == 0)
                {
                
                    let Values = ["email": self.email.text!, "name": self.username.text!, "usertype": "model"]
                    let usersReference = ref.child("users").child(uid)
                    
                    usersReference.updateChildValues(Values, withCompletionBlock: {(err,ref)
                        in
                        if err != nil{
                            print(err)
                            return
                        }
                        print("user has been added to database")
                        
                        
                    })
                }
                else
                {
                    let Values = ["email": self.email.text!, "name": self.username.text!, "usertype": "photographer"]
                    let usersReference = ref.child("users").child(uid)
                    
                    usersReference.updateChildValues(Values, withCompletionBlock: {(err,ref)
                        in
                        if err != nil{
                            print(err)
                            return
                        }
                        print("user has been added to database")
                        
                        
                    })
                }


                self.goBackToSignInPage(self)
            }
            
            
        })
        

    }
    

 
    @IBOutlet weak var secondView: UIView!
    @IBOutlet weak var firstView: UIView!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    
    @IBAction func goBackToSignInPage(_ sender: Any) {
        
        _ = self.navigationController?.popViewController(animated: true)
        
        self.dismiss(animated: true, completion: nil)
    }
    
   
    
}
