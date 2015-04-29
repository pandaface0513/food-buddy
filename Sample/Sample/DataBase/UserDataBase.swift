//
//  UserDataBase.swift
//  Project Foodie
//
//  Created by MacWANG on 2015-02-21.
//  Copyright (c) 2015 Victor. All rights reserved.
//

import Foundation

class UserDataBase:DataBase{
    override init(){
        super.init()
        dataBaseName = "Users"
    }
	
	func getFriends(userId:String)->Void{
		var query = PFQuery(className: "User")
		query.whereKey("objectId", equalTo: userId)
		query.getFirstObjectInBackgroundWithBlock {
			(object:PFObject!, error:NSError!) -> Void in
			if (error==nil){
				let friendsList = object.objectForKey("friends") as! Array<String>
				NSNotificationCenter.defaultCenter().addObserver(self, selector: "getFriendsNotificationHelper:", name: "download Done", object: nil)
				NSNotificationCenter.defaultCenter().addObserver(self, selector: "getFriendsNotificationHelper:", name: "download Failed", object: nil)
				self.downloadContainedIn(["objectId":friendsList])
			}else{
				NSNotificationCenter.defaultCenter().postNotificationName("getFriends Failed", object: error.description)
			}
		}
	}
	
	func getFriendsNotificationHelper(notification:NSNotification){
		NSNotificationCenter.defaultCenter().removeObserver(self, name: "download Done", object: nil)
		NSNotificationCenter.defaultCenter().removeObserver(self, name: "download Failed", object: nil)
		if (notification.name == "download Done"){
			NSNotificationCenter.defaultCenter().postNotificationName("getFriends Done", object: notification.object)
		}else{
			NSNotificationCenter.defaultCenter().postNotificationName("getFriends Failed", object: notification.object)
		}
	}
	
	
	func findUserCloud (args:Dictionary<String,AnyObject>)->Void {
		PFCloud.callFunctionInBackground("findUser", withParameters: args){
			(objects:AnyObject!, error: NSError!)-> Void in
			if (error==nil){
				var data:Array<Dictionary<String,AnyObject>> = Array()
				data = self.changePFObjectsToDictionary(objects as! [PFObject])
				NSNotificationCenter.defaultCenter().postNotificationName("findUser Done", object: objects)
			}else{
				let errorString = error.userInfo?["error"] as! NSString
				// Show the errorString somewhere and let the user try again.
				
				NSNotificationCenter.defaultCenter().postNotificationName("findUser Failed", object: errorString)
			}
		}
	}
}