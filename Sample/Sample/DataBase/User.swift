//
//  DataBaseC.swift
//  Tutorial
//
//  Created by MacWANG on 2015-02-15.
//  Copyright (c) 2015 MacWANG. All rights reserved.
//

import Foundation

let Attributes = ["profilePic","firstName","lastName","friends"]

class User{
    
    func addFriend(userId:String){
        var friendsList:Array<String> = PFUser.currentUser().objectForKey("follower")! as! Array<String>

        friendsList.append(userId);
    
        PFUser.currentUser().setValue(friendsList, forKey: "friends")
    }
    
    func getFriends()->String{
        return PFUser.currentUser().objectForKey("friends")! as! String
    }
    
    func getObjectId()->String{
        return PFUser.currentUser().objectId
    }
    
    func setEmail(newEmail:String){
        PFUser.currentUser().email = newEmail
        PFUser.currentUser().saveInBackgroundWithBlock{
            (success:Bool,error:NSError!)->Void in
            if (success){
                NSNotificationCenter.defaultCenter().postNotificationName("setEmail Done", object: nil)
            }else{
                let errorString = error.userInfo?["error"] as! NSString
                // Show the errorString somewhere and let the user try again.
                NSNotificationCenter.defaultCenter().postNotificationName("setEmail Fail", object: errorString)
            }
        }
    }
    
    func getEmail()->String{
        return PFUser.currentUser().email
    }

    func setUsername(newUserName:String){
        PFUser.currentUser().username = newUserName
        PFUser.currentUser().saveInBackgroundWithBlock{
            (success:Bool,error:NSError!)->Void in
            if (success){
                NSNotificationCenter.defaultCenter().postNotificationName("setUsername Done", object: nil)
            }else{
                let errorString = error.userInfo?["error"] as! NSString
                // Show the errorString somewhere and let the user try again.
                NSNotificationCenter.defaultCenter().postNotificationName("setUserName Failed", object: errorString)
            }
        }
    }
    
    func getUsername()->String{
        return PFUser.currentUser().username
    }
    
    func retrieveUserInfo()->Dictionary<String,AnyObject>{
        let keys = PFUser.currentUser().allKeys()
        var info:Dictionary<String,AnyObject> = Dictionary()
        for key in keys{
            let dictionaryKey = key as! String
            let value: AnyObject = PFUser.currentUser().objectForKey(dictionaryKey)!
            info.updateValue(value, forKey: dictionaryKey)
        }
        return info
    }
    
    
    func setPassword(newPssd:String){
        PFUser.currentUser().password = newPssd
        PFUser.currentUser().saveInBackgroundWithBlock{
            (success:Bool,error:NSError!)->Void in
            if (success){
                NSNotificationCenter.defaultCenter().postNotificationName("setPassword Done", object: nil)
            }else{
                let errorString = error.userInfo?["error"] as! NSString
                // Show the errorString somewhere and let the user try again.
                NSNotificationCenter.defaultCenter().postNotificationName("setPassword Failed", object: errorString)
            }
        }
    }
    
    func logIn(acc:String,passwd:String){
        PFUser.logInWithUsernameInBackground(acc, password:passwd) {
            (user: PFUser!, error: NSError!) -> Void in
            if user != nil {
            // Do stuff after successful login.
                NSNotificationCenter.defaultCenter().postNotificationName("logIn Done", object: nil)
            } else {
                let errorString = error.userInfo?["error"] as! NSString
                // Show the errorString somewhere and let the user try again.
            // The login failed. Check error to see why.
                NSNotificationCenter.defaultCenter().postNotificationName("logIn Failed", object: errorString)
            }
        }
    }
    
    func signUp(acc:String,passwd:String,email:String){
        signUp(acc, psswd: passwd, email: email, additionalInfo: [:])
    }
    
    func signUp(acc:String,psswd:String,email:String,additionalInfo:Dictionary<String,AnyObject!>) {
        var user = PFUser()
        user.username = acc
        user.password = psswd
        user.email = email
        
        for(key,value) in additionalInfo{
            user[key] = value
        }

        user.signUpInBackgroundWithBlock {
            (succeeded: Bool, error: NSError!) -> Void in
            if error == nil {
                NSNotificationCenter.defaultCenter().postNotificationName("signUp Done", object: nil)
            } else {
                let errorString = error.userInfo?["error"] as! NSString
                // Show the errorString somewhere and let the user try again.
                
                NSNotificationCenter.defaultCenter().postNotificationName("signUp Failed", object: errorString)
            }
            return
        }
    }
    
}
