//
//  CommentDataBase.swift
//  Project Foodie
//
//  Created by caili lowang on 2015-04-11.
//  Copyright (c) 2015 Victor. All rights reserved.
//

import Foundation

class CommentDataBase:DataBase{
	
	let userDataBase = UserDataBase()
	let postDataBase = PostDataBase()
	
	override init(){
		super.init();
		dataBaseName = "CommentDataBase";
	}
	
	func uploadComment(postId:String, userId:String, comment:Dictionary<String,AnyObject!>)->Void{
		var dataRow:PFObject = PFObject(className: dataBaseName)
		
		dataRow["postId"] = PFObject(withoutDataWithClassName: postDataBase.dataBaseName, objectId:postId)
		dataRow["userId"] = PFObject(withoutDataWithClassName: userDataBase.dataBaseName, objectId:userId)
		
		for (key,value) in comment{
			if (value is NSData){
				let file = PFFile(data: value as! NSData)
				dataRow[key] = file
			}
			else{
				dataRow[key] = value
			}
		}
		
		dataRow.saveInBackgroundWithBlock({
			(success:Bool, error:NSError!)-> Void in
			
			if (success){
				NSNotificationCenter.defaultCenter().postNotificationName("uploadComment Done", object: nil)
			} else {
				let errorString = error.userInfo?["error"]as! NSString
				// Show the errorString somewhere and let the user try again.
				
				NSNotificationCenter.defaultCenter().postNotificationName("uploadComment Failed", object: errorString)
			}
		})
	}
	
	func downloadComment(postId:String, userId:String){
		let post = PFObject(withoutDataWithClassName: postDataBase.dataBaseName, objectId:postId)
		let user = PFObject(withoutDataWithClassName: userDataBase.dataBaseName, objectId:userId)
		
		NSNotificationCenter.defaultCenter().addObserver(self, selector: "downloadCommentNotificationHelper:", name: "download Done", object: nil)
		NSNotificationCenter.defaultCenter().addObserver(self, selector: "downloadCommentNotificationHelper:", name: "download Failed", object: nil)
		downloadEqualTo(["postId":post,"userId":user])
	}
	
	func downloadCommentNotificationHelper(notification:NSNotification){
		NSNotificationCenter.defaultCenter().removeObserver(self, name: "download Done", object: nil)
		NSNotificationCenter.defaultCenter().removeObserver(self, name: "download Failed", object: nil)
		
		if (notification.name == "download Done"){
			NSNotificationCenter.defaultCenter().postNotificationName("downloadComment Done", object: notification.object)
		}else{
			NSNotificationCenter.defaultCenter().postNotificationName("downloadComment Failed", object: notification.object)
		}
	}
	
	
}