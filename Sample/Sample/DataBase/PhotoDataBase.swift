//
//  PhotoDataBase.swift
//  Project Foodie
//
//  Created by MacWANG on 2015-02-21.
//  Copyright (c) 2015 Victor. All rights reserved.
//

import Foundation

class PhotoDataBase:DataBase{
    override init(){
        super.init()
        dataBaseName="PhotoDataBase"
    }
	
	func findPostPhoto(args:Dictionary<String,AnyObject>)->Void {
		PFCloud.callFunctionInBackground("findPostPhoto", withParameters: args){
			(result:AnyObject!, error: NSError!)-> Void in
			if (error==nil){
				NSNotificationCenter.defaultCenter().postNotificationName("findPostPhoto Done", object: result)
			}else{
				NSNotificationCenter.defaultCenter().postNotificationName("findPostPhoto Failed", object: error)
			}
		}
	}
}