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
    
    var warningMsg = ""
    
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
            warningMsg = "Email"
            alertPopup("Check your \(warningMsg)")
        }
        else if (usernameInput.text == ""){
            warningMsg = "Username"
            alertPopup("Check your \(warningMsg)")
        }
        else if (passInput.text == "" || passInput.text != retypePassInput.text){
            warningMsg = "Password"
            alertPopup("Check your \(warningMsg)")
        }
        else {
            user.signUp(usernameInput.text, passwd: passInput.text, email: emailInput.text)
            NSNotificationCenter.defaultCenter().addObserver(self, selector: "signupSuc:", name: "signUp Done", object: nil)
            NSNotificationCenter.defaultCenter().addObserver(self, selector: "signupEr:", name: "signUp Failed", object: nil)
        }
        warningMsg = ""
    }
    
    func signupSuc(notification: NSNotification){
        println("signUp Done")
        NSNotificationCenter.defaultCenter().removeObserver(self)
        self.navigationController?.popToRootViewControllerAnimated(true)
    }
    
    func signupEr(notification: NSNotification){
        var msg = notification.object? as String
        println("signUp Failed")
        println("error msg: \(msg)")
        alertPopup(msg)
    }
    
    func alertPopup(warningMsg:String){
        var alert = UIAlertController(title: "Alert", message: warningMsg, preferredStyle: UIAlertControllerStyle.Alert)
        var alertAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil)
        alert.addAction(alertAction)
        presentViewController(alert, animated: true, completion: nil)
    }
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        self.view.endEditing(true);
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
