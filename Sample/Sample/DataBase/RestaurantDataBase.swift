//
//  RestaurantDataBase.swift
//  Project Foodie
//
//  Created by MacWANG on 2015-02-21.
//  Copyright (c) 2015 Victor. All rights reserved.
//

import Foundation

class RestaurantDataBase:DataBase{
    override init(){
        super.init()
        dataBaseName="RestaurantDataBase"
    }
	
	func findBestSuitedRestaurants(userIds:[String]){
		PFCloud.callFunctionInBackground("findBestSuitedRestaurants", withParameters: ["userIds":userIds]){
			(objects:AnyObject!, error: NSError!)-> Void in
			if (error==nil){
				var data:Array<Dictionary<String,AnyObject>> = Array()
				data = self.changePFObjectsToDictionary(objects as! [PFObject])
				NSNotificationCenter.defaultCenter().postNotificationName("findBestSuitedRestaurants Done", object: data)
			}else{
				let errorString = error.userInfo?["error"] as! NSString
				// Show the errorString somewhere and let the user try again.
				
				NSNotificationCenter.defaultCenter().postNotificationName("findBestSuitedRestaurants Failed", object: errorString)
			}
		}
	}
	
	func findRestaurantWithName(name:String){
		NSNotificationCenter.defaultCenter().addObserver(self, selector: "findRestaurantWithNameNotificiationHelper:", name: "download Done", object: nil)
		NSNotificationCenter.defaultCenter().addObserver(self, selector: "findRestaurantWithNameNotificiationHelper:", name: "download Failed", object: nil)
		downloadcontainsString(["name":name])
	}
	
	func findRestaurantWithNameNotificiationHelper(notification:NSNotification){
		NSNotificationCenter.defaultCenter().removeObserver(self, name: "download Done", object: nil)
		NSNotificationCenter.defaultCenter().removeObserver(self, name: "download Failed", object: nil)
		if (notification.name == "download Done"){
			NSNotificationCenter.defaultCenter().postNotificationName("findRestaurantWithName Done", object: notification.object)
		}else{
			NSNotificationCenter.defaultCenter().postNotificationName("findRestaurantWithName Failed", object: notification.object)
		}
	}
	
	func findRestaurantWithGeoRange(rangeKiloRadius:Double){
		NSNotificationCenter.defaultCenter().addObserver(self, selector: "findRestaurantWithGeoRange:", name: "download Done", object: nil)
		NSNotificationCenter.defaultCenter().addObserver(self, selector: "findRestaurantWithGeoRange:", name: "download Failed", object: nil)
		downloadWithLocationRange(rangeKiloRadius)
	}
	
	func findRestaurantWithGeoRange(notification:NSNotification){
		NSNotificationCenter.defaultCenter().removeObserver(self, name: "download Done", object: nil)
		NSNotificationCenter.defaultCenter().removeObserver(self, name: "download Failed", object: nil)
		if (notification.name == "download Done"){
			NSNotificationCenter.defaultCenter().postNotificationName("findRestaurantWithGeoRange Done", object: notification.object)
		}else{
			NSNotificationCenter.defaultCenter().postNotificationName("findRestaurantWithGeoRange Failed", object: notification.object)
		}
	}
	
	func findRestaurantNameCloud(args:Dictionary<String,AnyObject>)->Void {
		PFCloud.callFunctionInBackground("findRestaurantName", withParameters: args){
			(objects:AnyObject!, error: NSError!)-> Void in
			if (error==nil){
				var data:Array<Dictionary<String,AnyObject>> = Array()
				data = self.changePFObjectsToDictionary(objects as! [PFObject])
				NSNotificationCenter.defaultCenter().postNotificationName("findRestaurantName Done", object: data)
			}else{
				let errorString = error.userInfo?["error"] as! NSString
				// Show the errorString somewhere and let the user try again.
				
				NSNotificationCenter.defaultCenter().postNotificationName("findRestaurantName Failed", object: errorString)
			}
		}
	}
}