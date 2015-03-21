//
//  DataBase.swift
//  Tutorial
//
//  Created by MacWANG on 2015-02-15.
//  Copyright (c) 2015 MacWANG. All rights reserved.
//

import Foundation

class DataBase{
    
    var dataBaseName:String = ""

    func upload(data:Dictionary<String,AnyObject>)->Void{
		var dataRow:PFObject = PFObject(className: dataBaseName)
        
        for (key,value) in data{
            if (value is NSData){
                let file = PFFile(data: value as NSData)
                dataRow[key] = file
            }
            else{
                dataRow[key] = value
            }
        }
        
        dataRow.saveInBackgroundWithBlock({
            (success:Bool, error:NSError!)-> Void in
            
            if (success){
                NSLog("%s", "upload succeeded")
				NSNotificationCenter.defaultCenter().postNotificationName("upload Done", object: nil)
            } else {
                NSLog("%s", "upload failed")
				NSNotificationCenter.defaultCenter().postNotificationName("upload Failed", object: error)
            }
        })
    }
	
	func downloadEqualTo(equalTo:Dictionary<String,AnyObject>)->Void{
		download(equalTo, containedIn: [:], containString: [:], greaterThanOrEqualTo: [:], lessThanOrEqualTo: [:])
	}
	
	func downloadContainedIn(containedIn:Dictionary<String,[String]>)->Void{
		download([:], containedIn: containedIn, containString: [:], greaterThanOrEqualTo: [:], lessThanOrEqualTo: [:])
	}
	
	func downloadcontainsString(containString:Dictionary<String,String>)->Void{
		download([:], containedIn: [:], containString: containString, greaterThanOrEqualTo: [:], lessThanOrEqualTo: [:])
	}
	
	func downloadGreaterThanOrEqualTo(greaterThanOrEqualTo:Dictionary<String,Float>)->Void{
		download([:], containedIn: [:], containString: [:], greaterThanOrEqualTo: greaterThanOrEqualTo, lessThanOrEqualTo: [:])
	}
	
	func downloadLessThanOrEqualTo(lessThanOrEqualTo:Dictionary<String,Float>)->Void{
		download([:], containedIn: [:], containString: [:], greaterThanOrEqualTo: [:], lessThanOrEqualTo: lessThanOrEqualTo)
	}
	
	func download(equalTo:Dictionary<String,AnyObject>, containedIn:Dictionary<String,[String]>, containString:Dictionary<String,String>, greaterThanOrEqualTo:Dictionary<String,Float>, lessThanOrEqualTo:Dictionary<String,Float>)->Void{
        var data:Array<Dictionary<String,AnyObject>> = Array()
        var query:PFQuery = PFQuery(className: dataBaseName)
		
		for (key,value) in equalTo{
			query.whereKey(key, equalTo: value)
		}
		
		for (key,value) in containedIn{
			query.whereKey(key, containedIn: value)
		}
		
		for (key,value) in containString{
			query.whereKey(key, containedIn: [value])
		}
		
		for (key,value) in greaterThanOrEqualTo{
			query.whereKey(key, greaterThanOrEqualTo: value)
		}
		
		for (key,value) in lessThanOrEqualTo{
			query.whereKey(key, lessThanOrEqualTo: value)
		}
		
		
		
    
        query.findObjectsInBackgroundWithBlock{
            (objects:[AnyObject]!,error:NSError!) -> Void in
            
            if (error==nil){
                for object in objects as [PFObject]{
                    var dictionary:Dictionary<String,AnyObject> = Dictionary()
                    var keys = object.allKeys()!
                    for key in keys{
                        let dictionaryKey = key as String
                        var value: AnyObject! = object.objectForKey(dictionaryKey) as AnyObject!
                        if (value is PFFile){
                            value = value.url
                        }
                        dictionary.updateValue(value, forKey: dictionaryKey)
                    }
					data.append(dictionary)
                }
                NSNotificationCenter.defaultCenter().postNotificationName("downloadContaining Done", object: data)
            } else{
                NSNotificationCenter.defaultCenter().postNotificationName("downloadContaining Failed", object:error)
            }
            
        }
        
        return
    }
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