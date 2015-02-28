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
        var friendsList = PFUser.currentUser().objectForKey("friends")! as String
        
        if(friendsList==""){
            friendsList=userId
        }else{
            friendsList = "\(friendsList),\(userId)"
        }
        PFUser.currentUser().setValue(friendsList, forKey: "friends")
    }
    
    func getFriends()->String{
        return PFUser.currentUser().objectForKey("friends")! as String
    }
    
    func getObjectId()->String{
        return PFUser.currentUser().objectId
    }
    
    func setEmail(newEmail:String){
        PFUser.currentUser().email = newEmail
        PFUser.currentUser().saveInBackgroundWithBlock{
            (success:Bool,error:NSError!)->Void in
            if (success){
                NSNotificationCenter.defaultCenter().postNotificationName("Email Update Successful", object: nil)
            }else{
                NSNotificationCenter.defaultCenter().postNotificationName("Email Update Failed", object: nil)            
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
                NSNotificationCenter.defaultCenter().postNotificationName("Userame Update Successful", object: nil)
            }else{
                NSNotificationCenter.defaultCenter().postNotificationName("Username Update Failed", object: nil)
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
            let dictionaryKey = key as String
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
                NSNotificationCenter.defaultCenter().postNotificationName("Password Update Successful", object: nil)
            }else{
                NSNotificationCenter.defaultCenter().postNotificationName("Password Update Failed", object: nil)
            }
        }
    }
    
    func logIn(){
        PFUser.logInWithUsernameInBackground("myname", password:"mypass") {
            (user: PFUser!, error: NSError!) -> Void in
            if user != nil {
            // Do stuff after successful login.
                NSNotificationCenter.defaultCenter().postNotificationName("Log In Successful", object: nil)
            } else {
            // The login failed. Check error to see why.
                NSNotificationCenter.defaultCenter().postNotificationName("Log In Failed", object: nil)
            }
        }
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
            (succeeded: Bool!, error: NSError!) -> Void in
            if error == nil {
                NSNotificationCenter.defaultCenter().postNotificationName("Sign In Successful", object: nil)
            } else {
                let errorString = error.userInfo?["error"] as NSString
                // Show the errorString somewhere and let the user try again.
                
                NSNotificationCenter.defaultCenter().postNotificationName("Sign In Failed", object: errorString)
            }
        }
    }
    
}