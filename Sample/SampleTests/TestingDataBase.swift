//
//  TestingDataBase.swift
//  Project Foodie
//
//  Created by caili lowang on 2015-03-07.
//  Copyright (c) 2015 Victor. All rights reserved.
//

import Foundation

class TestingDataBase: DataBase {
	override init(){
		super.init()
		dataBaseName = "TestingDataBase"
	}
	/*
	func findTesting(args:Dictionary<String,AnyObject>)->Void {
		PFCloud.callFunctionInBackground("findTesting", withParameters: args){
			(result:AnyObject!, error: NSError!)-> Void in
			if (error==nil){
				NSNotificationCenter.defaultCenter().postNotificationName("findTesting Done", object: result)
			}else{
				NSNotificationCenter.defaultCenter().postNotificationName("findTesting Failed", object: error)
			}
		}
	}*/
}
