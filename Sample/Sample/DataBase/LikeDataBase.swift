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
	
	func likeToggle(postId:String, userId:String){
		NSNotificationCenter.defaultCenter().addObserver(self, selector: "likeToggleHelper:", name: "isLike Done", object: nil)
		NSNotificationCenter.defaultCenter().addObserver(self, selector: "likeToggleHelper:", name: "isLike Failed", object: nil)
		isLiked(postId, userId: userId)
	}
	
	func likeToggleHelper(notification:NSNotification){
		NSNotificationCenter.defaultCenter().removeObserver(self, name: "isLike Done", object: nil)
		NSNotificationCenter.defaultCenter().removeObserver(self, name: "isLike Failed", object: nil)
		if (notification.name == "isLike Done") {
			let objectContainer = notification.object as! LikeObjectContainer
			likeToggle(objectContainer.postId, userId: objectContainer.userId, isExisted: objectContainer.isExisted)
		} else {
			NSNotificationCenter.defaultCenter().postNotificationName("likeToggle Failed", object: notification.object)
		}
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
					let objectContainer = LikeObjectContainer(postId: postId, userId: userId, isExisted: false)
					NSNotificationCenter.defaultCenter().postNotificationName("isLike Done", object: objectContainer)
				}else{
					let objectContainer = LikeObjectContainer(postId: postId, userId: userId, isExisted: true)
					NSNotificationCenter.defaultCenter().postNotificationName("isLike Done", object: objectContainer)
				}
			} else {
				let errorString = error.userInfo?["error"] as! NSString
				// Show the errorString somewhere and let the user try again.
				
				NSNotificationCenter.defaultCenter().postNotificationName("isLike Failed", object: errorString)
			}
		}
	}
    
    func didLike(postId:String,userId:String){
        let userRelation = PFObject(withoutDataWithClassName: "User", objectId: userId)
        let postRelation = PFObject(withoutDataWithClassName: "PostDataBase", objectId: postId)
        
        var query = PFQuery(className:dataBaseName)
        query.whereKey("user", equalTo: userRelation)
        query.whereKey("post", equalTo: postRelation)
        
        query.countObjectsInBackgroundWithBlock{
            (count:Int32,error:NSError!)->Void in
            if (error == nil) {
                if (count == 0 ){
//                    let objectContainer = LikeObjectContainer(postId: postId, userId: userId, isExisted: false)
                    NSNotificationCenter.defaultCenter().postNotificationName("didLike Done", object: "false")
                }else{
//                    let objectContainer = LikeObjectContainer(postId: postId, userId: userId, isExisted: true)
                    NSNotificationCenter.defaultCenter().postNotificationName("didLike Done", object: "true")
                }
            } else {
                let errorString = error.userInfo?["error"] as! NSString
                // Show the errorString somewhere and let the user try again.
                
                NSNotificationCenter.defaultCenter().postNotificationName("didLike Failed", object: errorString)
            }
        }
    }
    
    
	func likeToggle(postId:String, userId:String,isExisted:Bool){
		let userRelation = PFObject(withoutDataWithClassName: "User", objectId: userId)
		let postRelation = PFObject(withoutDataWithClassName: "PostDataBase", objectId: postId)
		
		if (isExisted){
			var query = PFQuery(className: dataBaseName)
			query.whereKey("userId", equalTo: userRelation)
			query.whereKey("postId", equalTo: postRelation)
			
			query.findObjectsInBackgroundWithBlock{
				(objects:[AnyObject]!, error:NSError!) -> Void in
				
				postRelation.incrementKey("likeCount",byAmount: -1);
				postRelation.save()
				
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
			dataRow["userId"] = userRelation
			dataRow["postId"] = postRelation
			
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
		query.whereKey("postId", equalTo: postRelation)
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

	class LikeObjectContainer{
		var postId:String = ""
		var userId:String = ""
		var isExisted:Bool = true
		internal init(postId:String,userId:String,isExisted:Bool){
			self.postId = postId
			self.userId = userId
			self.isExisted=isExisted
		}
	}
}
