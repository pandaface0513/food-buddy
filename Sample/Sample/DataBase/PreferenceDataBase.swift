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
			(result:AnyObject!, error: NSError!)-> Void in
			if (error==nil){
				NSNotificationCenter.defaultCenter().postNotificationName("findPreference Done", object: result)
			}else{
				NSNotificationCenter.defaultCenter().postNotificationName("findPreference Failed", object: error)
			}
		}
	}
}