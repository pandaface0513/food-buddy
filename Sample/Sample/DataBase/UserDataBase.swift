//
//  UserDataBase.swift
//  Project Foodie
//
//  Created by MacWANG on 2015-02-21.
//  Copyright (c) 2015 Victor. All rights reserved.
//

import Foundation

class UserDataBase:DataBase{
    override init(){
        super.init()
        dataBaseName = "UserDataBase"
    }
	
	func findUser(args:Dictionary<String,AnyObject>)->Void {
		PFCloud.callFunctionInBackground("findUser", withParameters: args){
			(result:AnyObject!, error: NSError!)-> Void in
			if (error==nil){
				NSNotificationCenter.defaultCenter().postNotificationName("findUser Done", object: result)
			}else{
				NSNotificationCenter.defaultCenter().postNotificationName("findUser Failed", object: error)
			}
		}
	}
}