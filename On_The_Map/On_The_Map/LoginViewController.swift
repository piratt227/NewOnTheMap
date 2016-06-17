//
//  ViewController.swift
//  On_The_Map
//
//  Created by Aaron Phillips on 6/15/16.
//  Copyright © 2016 Aaron Phillips. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    var studentManager: StudentManager?
    var client: Client?

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
    }

    @IBAction func loginButtonPressed(sender: AnyObject) {
        if emailTextField.text == ""{
            print("Enter Email Address")
        }
        else{
            if passwordTextField.text == ""{
                print("Enter Password")
            }
            else{
                loginToUdacity()
            }
        }
    }
    
    func loginToUdacity(){
        Client.sharedInstance.udacityLogin(emailTextField.text!, password: passwordTextField.text!){(success, result, error) in
            if success == true{
                print("Go to map now!!!!")
            }
            
        }
        }
    
    
    func getLoginUserData(){
        
    }
}
    
    



