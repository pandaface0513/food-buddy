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
                let imageFile = PFFile(data: value as NSData)
                dataRow[key] = value
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
	
    func downloadEqualTo(args:Dictionary<String,AnyObject>...)->Void{
        var data:Array<Dictionary<String,AnyObject>> = Array()
        var query:PFQuery = PFQuery(className: dataBaseName)
        
        for arg in args{
            for (key,value) in arg{
                query.whereKey(key, equalTo: value)
            }
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
                            let image = value as PFFile
                            var errorPointer:NSErrorPointer!
                            value = image.getData()
                            if (errorPointer != nil){
                                dictionary.updateValue(errorPointer.debugDescription, forKey: "errorPointer")
                            }
                        }
                        dictionary.updateValue(value, forKey: dictionaryKey)
                    }
					
                    printDictionary(dictionary)
					
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