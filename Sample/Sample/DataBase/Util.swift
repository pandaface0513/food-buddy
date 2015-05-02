//
//  util.swift
//  Project Foodie
//
//  Created by caili lowang on 2015-05-02.
//  Copyright (c) 2015 Victor. All rights reserved.
//

import Foundation

func changePFObjectToDictionaru(object:PFObject)->Dictionary<String,AnyObject>{
	var dictionary:Dictionary<String,AnyObject> = Dictionary()
	var keys = object.allKeys()!
	for key in keys{
		let dictionaryKey = key as! String
		var value: AnyObject! = object.objectForKey(dictionaryKey) as AnyObject!
		if (value is PFFile){
			value = value.url
		}
		dictionary.updateValue(value, forKey: dictionaryKey)
	}
	return dictionary
}

func changePFObjectsToDictionary(objects: [PFObject]) -> Array<Dictionary<String,AnyObject>>{
	var data:Array<Dictionary<String,AnyObject>> = Array()
	
	for object in objects{
		var dictionary:Dictionary<String,AnyObject> = Dictionary()
		var keys = object.allKeys()!
		for key in keys{
			let dictionaryKey = key as! String
			var value: AnyObject! = object.objectForKey(dictionaryKey) as AnyObject!
			if (value is PFFile){
				value = value.url
			}
			dictionary.updateValue(value, forKey: dictionaryKey)
		}
		dictionary.updateValue(object.objectId, forKey:"objectId")
		dictionary.updateValue(object.createdAt, forKey: "createdAt")
		dictionary.updateValue(object.updatedAt, forKey: "updatedAt")
		data.append(dictionary)
	}
	
	return data
}

func changeNSArrayToDictionary(nsArray: NSArray)->Array<Dictionary<String,AnyObject>>{
	var data:Array<Dictionary<String,AnyObject>>=Array()
	
	for objects in nsArray{
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
		dictionary.updateValue(object.objectId, forKey: "objectId")
		dictionary.updateValue(object.createdAt, forKey: "createdAt")
		dictionary.updateValue(object.updatedAt, forKey: "updatedAt")
		data.append(dictionary)
	}
	return data
}

func changeArrayDictionaryToArrayDictionary(arrayDictionary:Array<Dictionary<String,AnyObject>>)->Array<Dictionary<String,AnyObject>>{
	var results:Array<Dictionary<String,AnyObject>> = Array()
	
	for dictionary in arrayDictionary{
		var result:Dictionary<String,AnyObject> = Dictionary()
		for key in dictionary.keys{
			result[key] = dictionary[key]!
		}
		results.append(result)
	}
	
	return results
}


func printDictionary(dictionary:Dictionary<String,AnyObject>){
	for (key,value) in dictionary{
		println("\(key) is \(value)")
	}
}

func printDictionaries(dictionaries:Array<Dictionary<String,AnyObject>>){
	for dictionary in dictionaries{
		for (key, value) in dictionary{
			println("\(key) is \(value)")
		}
	}
}
	