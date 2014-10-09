//
//  LoginViewController.swift
//  CoverPast
//
//  Created by SivaSankar on 08/10/14.
//  Copyright (c) 2014 Paradim Creatives. All rights reserved.
//

import Foundation
import UIKit

class LoginViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet var backgroundScroll: UIScrollView!
    @IBOutlet var emailTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        var defaults:NSUserDefaults = NSUserDefaults.standardUserDefaults()
        if (defaults.objectForKey("email") != nil){
            self.emailTextField.text = defaults.objectForKey("email") as String
            self.passwordTextField.text = defaults.objectForKey("password") as String
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        
    }
    
    @IBAction func loginButtonClicked(sender: AnyObject) {
     
        self.resignTextField()
        if self.emailTextField.text != nil{
            var defaults:NSUserDefaults = NSUserDefaults.standardUserDefaults()
            defaults.setObject(self.emailTextField.text, forKey: "email")
            defaults.setObject(self.passwordTextField.text, forKey: "password")
            defaults.synchronize()
            
            let homeView = self.storyboard?.instantiateViewControllerWithIdentifier("home") as HomeViewController
            self.presentViewController(homeView, animated: true, completion: nil)
        }

    }
    
    @IBAction func forgotPasswordButtonClicked(sender: AnyObject) {
        NSLog("forgot button clicked")
        self.resignTextField()
    }
    
    @IBAction func registrationButtonClicked(sender: AnyObject) {
        NSLog("register button clicked")
        self.resignTextField()
    }

    // text field delegate methods.
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        return textField.resignFirstResponder()
    }
    
    func resignTextField(){
        emailTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}