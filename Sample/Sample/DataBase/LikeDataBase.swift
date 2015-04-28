//
//  LikeDataBase.swift
//  Project Foodie
//
//  Created by caili lowang on 2015-04-11.
//  Copyright (c) 2015 Victor. All rights reserved.
//

import Foundation

class LikeDataBase:DataBase{
	override init(){
		super.init()
		dataBaseName = "LikeDataBase"
	}
	
	func isLiked(postId:String,userId:String){
		let userRelation = PFObject(withoutDataWithClassName: "User", objectId: userId)
		let postRelation = PFObject(withoutDataWithClassName: "PostDataBase", objectId: postId)
		
	 	var query = PFQuery(className:dataBaseName)
		query.whereKey("user", equalTo: userRelation)
		query.whereKey("post", equalTo: postRelation)
		
		query.countObjectsInBackgroundWithBlock{
			(count:Int32,error:NSError!)->Void in
			if (error == nil) {
				if (count == 0 ){
					NSNotificationCenter.defaultCenter().postNotificationName("isLike Done", object: false)
				}else{
					NSNotificationCenter.defaultCenter().postNotificationName("isLike Done", object: true)
				}
			} else {
				let errorString = error.userInfo?["error"] as! NSString
				// Show the errorString somewhere and let the user try again.
				
				NSNotificationCenter.defaultCenter().postNotificationName("isLike Failed", object: errorString)
			}
		}
	}
	
	func likeToggle(postId:String, userId:String,isExisted:Bool){
		let userRelation = PFObject(withoutDataWithClassName: "User", objectId: userId)
		let postRelation = PFObject(withoutDataWithClassName: "PostDataBase", objectId: postId)
		
		if (isExisted){
			var query = PFQuery(className: dataBaseName)
			query.whereKey("user", equalTo: userRelation)
			query.whereKey("post", equalTo: postRelation)
			
			query.findObjectsInBackgroundWithBlock{
				(objects:[AnyObject]!, error:NSError!) -> Void in
				for object in objects as! [PFObject]{
					var errorPointer = NSErrorPointer()
					object.delete(errorPointer)
					if !(errorPointer == nil) {
						let errorString = errorPointer.debugDescription
						NSNotificationCenter.defaultCenter().postNotificationName("likeToggle Failed", object: errorString)
						break
					}
				}
				if (error==nil) {
					NSNotificationCenter.defaultCenter().postNotificationName("likeToggle Done", object: nil)
				}
			}
		}else{
			var dataRow = PFObject(className: dataBaseName)
			dataRow["user"] = userRelation
			dataRow["post"] = postRelation
			
			dataRow.saveInBackgroundWithBlock{
				(success:Bool, error:NSError!) -> Void in
				postRelation.incrementKey("likeCount");
				
				var errorPointer = NSErrorPointer()
				postRelation.save(errorPointer)
				let errorString = errorPointer.debugDescription
				NSNotificationCenter.defaultCenter().postNotificationName("likeToggle Done", object: errorString)
				
				self.updateLikeCountFromTable(postId)
			}
		}
			
	}

	
	func updateLikeCountFromTable(postId:String){
		let postRelation = PFObject(withoutDataWithClassName: "postDataBase", objectId: postId)
		
		var query = PFQuery(className: "likeDataBase")
		query.whereKey("post", equalTo: postRelation)
		query.countObjectsInBackgroundWithBlock {
			(count:Int32, error:NSError!) -> Void in
			if error == nil {
				postRelation["likeCount"] = Int(count)
				postRelation.saveInBackgroundWithBlock{
					(success:Bool, error2:NSError!) -> Void in
					if error==nil{
						NSNotificationCenter.defaultCenter().postNotificationName("updateLikeCountFromTable Done", object: nil)
					}else{
						let errorString = error.userInfo?["error"] as! NSString
						NSNotificationCenter.defaultCenter().postNotificationName("updateLikeCountFromTable Failed", object: errorString)
					}
				}
			} else {
				let errorString = error.userInfo?["error"] as! NSString
				NSNotificationCenter.defaultCenter().postNotificationName("updateLikeCountFromTable Failed", object: errorString)
			}
		}
	}
}