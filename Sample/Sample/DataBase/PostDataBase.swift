//
//  Post.swift
//  Project Foodie
//
//  Created by MacWANG on 2015-02-21.
//  Copyright (c) 2015 Victor. All rights reserved.
//

import Foundation

class PostDataBase:DataBase{
    override init(){
        super.init()
        dataBaseName="PostDataBase"
    }
	
	func findPost(args:Dictionary<String,AnyObject>)->Void {
		PFCloud.callFunctionInBackground("findPost", withParameters: args){
			(objects:AnyObject!, error: NSError!)-> Void in
			if (error==nil){
				var data: Array<Dictionary<String,AnyObject>> = Array()
				data = self.changePFObjectsToDictionary(objects as! [PFObject])
				NSNotificationCenter.defaultCenter().postNotificationName("findPost Done", object: data)
			}else{
				let errorString = error.userInfo?["error"] as! NSString
				// Show the errorString somewhere and let the user try again.
				
				NSNotificationCenter.defaultCenter().postNotificationName("findPost Failed", object: errorString)
			}
		}
	}
	
    func findAllPost()->Void {
        PFCloud.callFunctionInBackground("findAllPost", withParameters: [:]){
            (result:AnyObject!, error: NSError!)-> Void in
            if (error==nil){
                var data:Array<Dictionary<String,AnyObject>> = Array()
				data = self.changeNSArrayToDictionary(result as! NSArray)
                NSNotificationCenter.defaultCenter().postNotificationName("findAllPost Done", object: data)
            }else{
                NSNotificationCenter.defaultCenter().postNotificationName("findAllPost Failed", object: error)
            }
        }
    }
	
	func findFriendPost(userId:String)->Void {
		PFCloud.callFunctionInBackground("findFriendPost", withParameters: ["userId":userId]){
			(result:AnyObject!, error: NSError!)-> Void in
			if (error==nil){
				var data:Array<Dictionary<String,AnyObject>> = Array()
				data=self.changeNSArrayToDictionary(result as!NSArray)
				NSNotificationCenter.defaultCenter().postNotificationName("findFriendPost Done", object: data)
			}else{
				NSNotificationCenter.defaultCenter().postNotificationName("findFriendPost Failed", object: error)
			}
		}
	}
}