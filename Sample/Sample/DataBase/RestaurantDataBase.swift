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
	
	func findRestaurantName(args:Dictionary<String,AnyObject>)->Void {
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