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
    
    @IBOutlet weak var warning: UILabel!
    
    var user = User()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        warning.text = ""
        
//        checkUser()
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func loginBtn(sender: UIButton) {
        if (usernameInput.text == "" || passInput.text == ""){
            warning.text = "Wrong"
        }
        else {
            user.logIn(usernameInput.text, passwd: passInput.text)
            performSegueWithIdentifier("loginSuccess", sender: self)
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
