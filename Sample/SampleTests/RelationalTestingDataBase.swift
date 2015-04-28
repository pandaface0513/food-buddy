//
//  RelationalTestingDataBase.swift
//  Project Foodie
//
//  Created by caili lowang on 2015-03-18.
//  Copyright (c) 2015 Victor. All rights reserved.
//

import Foundation

class RelationalTestingDataBase: DataBase {
	override init(){
		super.init()
		dataBaseName = "RelationalTestingDataBase"
	}
	/*
	func findTesting(args:Dictionary<String,AnyObject>)->Void {
		PFCloud.callFunctionInBackground("findTestingRelational", withParameters: args){
			(result:AnyObject!, error: NSError!)-> Void in
			if (error==nil){
				NSNotificationCenter.defaultCenter().postNotificationName("findTestingRelational Done", object: result)
			}else{
				NSNotificationCenter.defaultCenter().postNotificationName("findTestingRelational Failed", object: error)
			}
		}
	}*/
}
