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
			(result:AnyObject!, error: NSError!)-> Void in
			if (error==nil){
				NSNotificationCenter.defaultCenter().postNotificationName("findRestaurantName Done", object: result)
			}else{
				NSNotificationCenter.defaultCenter().postNotificationName("findRestaurantName Failed", object: error)
			}
		}
	}
}