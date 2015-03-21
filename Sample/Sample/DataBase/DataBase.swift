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
            dataRow[key] = value
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
    
    func downloadContaining(args:Dictionary<String,AnyObject>...)->Void{
        var data:Array<Dictionary<String,AnyObject>> = Array()
        var query:PFQuery = PFQuery(className: dataBaseName)
        
        for arg in args{
            for (key,value) in arg{
                query.whereKey(key, containsString: value as String)
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
                        let value: AnyObject! = object[dictionaryKey]
                        dictionary.updateValue(value!, forKey: dictionaryKey)
                    }
                    //printDictionary(dictionary)
                    data.append(dictionary)
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