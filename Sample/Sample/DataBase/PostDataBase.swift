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
    
    func findAllPost()->Void {
        PFCloud.callFunctionInBackground("findAllPost", withParameters: [:]){
            (result:AnyObject!, error: NSError!)-> Void in
            if (error==nil){
                var data:Array<Dictionary<String,AnyObject>> = Array()
                for objects in result! as! NSArray{
                    var dictionary:Dictionary<String,AnyObject> = Dictionary()
                    var object = objects as! PFObject
                    var keys = object.allKeys()!
                    for key in keys{
                        let dictionaryKey = key as! String
                        var value: AnyObject! = object.objectForKey(dictionaryKey) as AnyObject!
                        if (value is PFFile){
                            value = value.url
                        }
                        dictionary.updateValue(value, forKey: dictionaryKey)
                    }
                    data.append(dictionary)
                }
                NSNotificationCenter.defaultCenter().postNotificationName("findAllPost Done", object: data)
            }else{
                NSNotificationCenter.defaultCenter().postNotificationName("findAllPost Failed", object: error)
            }
        }
    }
}