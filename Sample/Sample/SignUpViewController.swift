//
//  SignUpViewController.swift
//  Project Foodie
//
//  Created by Stardustxx on 2015-03-10.
//  Copyright (c) 2015 Victor. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController {

    @IBOutlet weak var emailInput: UITextField!
    @IBOutlet weak var usernameInput: UITextField!
    @IBOutlet weak var passInput: UITextField!
    @IBOutlet weak var retypePassInput: UITextField!
    @IBOutlet weak var warning: UILabel!
    
    
    var user = User()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func signupBtn(sender: UIButton) {
        if (emailInput.text == ""){
            warning.text = "Email"
        }
        else if (usernameInput.text == ""){
            warning.text = "Username"
        }
        else if (passInput.text == "" || passInput.text != retypePassInput.text){
            warning.text = "Password"
        }
        else {
            user.signUp(usernameInput.text, passwd: passInput.text, email: emailInput.text)
            self.navigationController?.popToRootViewControllerAnimated(true)
        }
    }
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        self.view.endEditing(true);
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
