//
//  Post.swift
//  Project Foodie
//
//  Created by MacWANG on 2015-02-21.
//  Copyright (c) 2015 Victor. All rights reserved.
//

import Foundation

class PostDataBase:DataBase{
    override init(){
        super.init()
        dataBaseName="PostDataBase"
    }
	
	func findPost(args:Dictionary<String,AnyObject>)->Void {
		PFCloud.callFunctionInBackground("findPost", withParameters: args){
			(result:AnyObject!, error: NSError!)-> Void in
			if (error==nil){
				NSNotificationCenter.defaultCenter().postNotificationName("findPost Done", object: result)
			}else{
				NSNotificationCenter.defaultCenter().postNotificationName("findPost Failed", object: error)
			}
		}
	}
}