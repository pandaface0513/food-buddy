//
//  PreferenceDataBase.swift
//  Project Foodie
//
//  Created by MacWANG on 2015-02-21.
//  Copyright (c) 2015 Victor. All rights reserved.
//

import Foundation

class PreferenceDataBase:DataBase{
    override init(){
        super.init()
        dataBaseName="PreferenceDataBase"
    }
	
	func findPreference(args:Dictionary<String,AnyObject>)->Void {
		PFCloud.callFunctionInBackground("findPreference", withParameters: args){
			(objects:AnyObject!, error: NSError!)-> Void in
			if (error==nil){
				var data:Array<Dictionary<String,AnyObject>> = Array()
				data = self.changePFObjectsToDictionary(objects as! [PFObject])
				NSNotificationCenter.defaultCenter().postNotificationName("findPreference Done", object: data)
			}else{
				let errorString = error.userInfo?["error"] as! NSString
				// Show the errorString somewhere and let the user try again.
				
				NSNotificationCenter.defaultCenter().postNotificationName("findPreference Failed", object: errorString)
			}
		}
	}
}