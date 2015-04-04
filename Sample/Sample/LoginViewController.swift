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
            NSNotificationCenter.defaultCenter().addObserver(self, selector: "loginSuccessful:", name: "logIn Done", object: nil)
            NSNotificationCenter.defaultCenter().addObserver(self, selector: "loginEr:", name: "logIn Failed", object: nil)
        }
    }
    
    func loginSuccessful(notification: NSNotification){
        println("Login Done")
        NSNotificationCenter.defaultCenter().removeObserver(self)
        self.navigationController?.popToRootViewControllerAnimated(true)
    }
    
    func loginEr(notification: NSNotification){
        println("Login failed")
        alertPopup("Login Error")
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
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
