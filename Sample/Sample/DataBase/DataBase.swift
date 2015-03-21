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
        var dataRow:PFObject = PFObject()
        
        for (key,value) in data{
<<<<<<< HEAD
            dataRow[key] = value
=======
            if (value is NSData){
                let file = PFFile(data: value as NSData)
                dataRow[key] = file
            }
            else{
                dataRow[key] = value
            }
>>>>>>> database
        }
        
        dataRow.saveInBackgroundWithBlock({
            (success:Bool, error:NSError!)-> Void in
            
            if (success){
                NSLog("%s", "upload succeeded")
            } else {
                NSLog("%s", "upload failed")
            }
        })
    }
<<<<<<< HEAD
    
    func downloadContaining(args:Dictionary<String,AnyObject>...)->Void{
        var data:Array<Dictionary<String,AnyObject>> = Array()
        var query:PFQuery = PFQuery(className: dataBaseName)
        
        for arg in args{
            for (key,value) in arg{
                query.whereKey(key, containsString: value as String)
            }
        }
=======
	
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
		
		
		
>>>>>>> database
    
        query.findObjectsInBackgroundWithBlock{
            (objects:[AnyObject]!,error:NSError!) -> Void in
            
            if (error==nil){
                for object in objects as [PFObject]{
                    var dictionary:Dictionary<String,AnyObject> = Dictionary()
                    var keys = object.allKeys()!
                    for key in keys{
                        let dictionaryKey = key as String
<<<<<<< HEAD
                        let value: AnyObject! = object[dictionaryKey]
                        dictionary.updateValue(value!, forKey: dictionaryKey)
                    }
                    //printDictionary(dictionary)
                    data.append(dictionary)
=======
                        var value: AnyObject! = object.objectForKey(dictionaryKey) as AnyObject!
                        if (value is PFFile){
                            value = value.url
                        }
                        dictionary.updateValue(value, forKey: dictionaryKey)
                    }
					data.append(dictionary)
>>>>>>> database
                }
                //printDictionaries(data)
                NSNotificationCenter.defaultCenter().postNotificationName("Download Successful", object: data)
            } else{
                NSNotificationCenter.defaultCenter().postNotificationName("Download Failed", object:nil)
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