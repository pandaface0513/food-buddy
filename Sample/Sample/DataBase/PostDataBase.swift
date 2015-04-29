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
	
	func findPostCloud(args:Dictionary<String,AnyObject>)->Void {
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
	
    func findAllPostCloud()->Void {
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
	
	func findFriendPostCloud(userId:String)->Void {
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
    
    var lastPositionDate = NSDate()
    var needToLoad : Bool = false
    
    func findFriendFeed(userId:String, loadMore: Bool) -> Void {
        var userQuery = PFUser.query()
        userQuery.whereKey("objectId", equalTo: userId)
        userQuery.getFirstObjectInBackgroundWithBlock { (object: PFObject?, error: NSError?) -> Void in
            if (error == nil){
                var friendList : [String] = object?.objectForKey("friends") as! [String]
                
                println(object)
                println("postDataBase")
                
                var query = PFQuery(className: "PostDataBase")
                query.whereKey("userid", containedIn: friendList)
                query.orderByDescending("createdAt")
                query.limit = 10
                if (loadMore){
                    query.whereKey("createdAt", lessThan: self.lastPositionDate)
                }
                query.findObjectsInBackgroundWithBlock({ (objects:[AnyObject]!, error:NSError!) -> Void in
                    if (error == nil){
                        println("testing")
                        println(objects)
                        self.lastPositionDate = objects[objects.count - 1].createdAt
						
						//this change [PFObject] to [Dictionary]
						let objectList = self.changePFObjectsToDictionary(objects as! [PFObject])
						
                        if (loadMore && self.needToLoad){
                            self.needToLoad = false
                            NSNotificationCenter.defaultCenter().postNotificationName("addFriendFeed done", object: objectList)
                        }
                        else {
                        NSNotificationCenter.defaultCenter().postNotificationName("findFriendFeed done", object: objectList)
                        }
                    }
                    else {
                        println("shit")
                    }
                })
                
            }
            else {
                NSNotificationCenter.defaultCenter().postNotificationName("findFriendFeed failed", object: nil)
                println("get first object in bg failed")
            }
        }
    }
}