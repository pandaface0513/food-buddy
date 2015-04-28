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
			(objects:AnyObject!, error: NSError!)-> Void in
			if (error==nil){
				var data:Array<Dictionary<String,AnyObject>> = Array()
				data = self.changePFObjectsToDictionary(objects as! [PFObject])
				NSNotificationCenter.defaultCenter().postNotificationName("findPostPhoto Done", object: data)
			}else{
				let errorString = error.userInfo?["error"]as! NSString
				// Show the errorString somewhere and let the user try again.
				
				NSNotificationCenter.defaultCenter().postNotificationName("findPostPhoto Failed", object: errorString)
			}
		}
	}
}