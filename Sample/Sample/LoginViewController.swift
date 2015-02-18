//
//  LoginViewController.swift
//  Project Foodie
//
//  Created by Victor on 2015-02-11.
//  Copyright (c) 2015 Victor. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var usernameInput: UITextField!
    @IBOutlet weak var passInput: UITextField!
    
    @IBOutlet weak var label1: UILabel!
    let username:String = "admin"
    let password:String = "admin2015"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        label1.text = ""
        usernameInput.text = username
        passInput.text = password
        
//        checkUser()
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func loginBtn(sender: UIButton) {
        if (usernameInput.text == username && passInput.text == password){
            label1.text = "Logged In"
            println("logged in")
            self.performSegueWithIdentifier("loginSuccess", sender: self)
            
        }
        else {
            label1.text = "noob no account"
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
