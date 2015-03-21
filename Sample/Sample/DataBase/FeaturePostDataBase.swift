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
	
	func findFeaturePost(args:Dictionary<String,AnyObject>)->Void {
		PFCloud.callFunctionInBackground("findFeaturePost", withParameters: args){
			(result:AnyObject!, error: NSError!)-> Void in
			if (error==nil){
				NSNotificationCenter.defaultCenter().postNotificationName("findFeaturePost Done", object: result)
			}else{
				NSNotificationCenter.defaultCenter().postNotificationName("findFeaturePost Failed", object: error)
			}
		}
	}
}