//
//  FeaturePostDataBase.swift
//  Project Foodie
//
//  Created by caili lowang on 2015-03-18.
//  Copyright (c) 2015 Victor. All rights reserved.
//

import Foundation

class FeaturePostDataBase:DataBase{
	override init(){
		super.init()
		dataBaseName="FeaturePostDataBase"
	}
	
	func findFeaturePostCloud(args:Dictionary<String,AnyObject>)->Void {
		PFCloud.callFunctionInBackground("findFeaturePost", withParameters: args){
			(result:AnyObject!, error: NSError!)-> Void in
			if (error==nil){
				NSNotificationCenter.defaultCenter().postNotificationName("findFeaturePost Done", object: result)
			}else{
				let errorString = error.userInfo?["error"] as! NSString
				// Show the errorString somewhere and let the user try again.
				
				NSNotificationCenter.defaultCenter().postNotificationName("findFeaturePost Failed", object: errorString)
			}
		}
	}
}