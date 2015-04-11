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

	func uploadRelational(dataBase:DataBase?, parentId:String?, child:Dictionary<String,AnyObject!>)->Void{
		var dataRow:PFObject = PFObject(className: dataBaseName)
		if !(dataBase==nil){
			dataRow["parent"] = PFObject(withoutDataWithClassName:dataBase!.dataBaseName, objectId:parentId!)
		}
		
		for (key,value) in child{
			if (value is NSData){
				let file = PFFile(data: value as! NSData)
				dataRow[key] = file
			}
			else{
				dataRow[key] = value
			}
		}
		
		dataRow.saveInBackgroundWithBlock({
			(success:Bool, error:NSError!)-> Void in
			
			if (success){
				NSNotificationCenter.defaultCenter().postNotificationName("upload Done", object: nil)
			} else {
				let errorString = error.userInfo?["error"] as! NSString
				// Show the errorString somewhere and let the user try again.
				
				NSNotificationCenter.defaultCenter().postNotificationName("upload Failed", object: errorString)
			}
		})
	}
	
    func upload(data:Dictionary<String,AnyObject>)->Void{
		uploadRelational(nil, parentId: nil, child: data)
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
			data.append(dictionary)
		}
		
		return data
	}
	
	func download(equalTo:Dictionary<String,AnyObject>, containedIn:Dictionary<String,[String]>, containString:Dictionary<String,String>, greaterThanOrEqualTo:Dictionary<String,Float>, lessThanOrEqualTo:Dictionary<String,Float>)->Void{
        var data:Array<Dictionary<String,AnyObject>> = Array()
        var querys:Array<PFQuery> = Array()
		var orQuery:PFQuery = PFQuery(className: dataBaseName)
		
		for (key,value) in equalTo{
			var temp = PFQuery(className: dataBaseName)
			temp.whereKey(key, equalTo: value)
			querys.append(temp)
		}
		
		for (key,value) in containedIn{
			var temp = PFQuery(className: dataBaseName)
			temp.whereKey(key, equalTo: value)
			querys.append(temp)
		}
		
		for (key,value) in containString{
			var temp = PFQuery(className: dataBaseName)
			temp.whereKey(key, equalTo: value)
			querys.append(temp)
		}
		
		for (key,value) in greaterThanOrEqualTo{
			var temp = PFQuery(className: dataBaseName)
			temp.whereKey(key, equalTo: value)
			querys.append(temp)
		}
		
		for (key,value) in lessThanOrEqualTo{
			var temp = PFQuery(className: dataBaseName)
			temp.whereKey(key, equalTo: value)
			querys.append(temp)
		}
		
		
		orQuery = PFQuery.orQueryWithSubqueries(querys)

    
        orQuery.findObjectsInBackgroundWithBlock{
            (objects:[AnyObject]!,error:NSError!) -> Void in
			
            if (error==nil){
				data = self.changePFObjectsToDictionary(objects as! [PFObject])
                NSNotificationCenter.defaultCenter().postNotificationName("download Done", object: data)
            } else{
				let errorString = error.userInfo?["error"] as! NSString
				// Show the errorString somewhere and let the user try again.
				
                NSNotificationCenter.defaultCenter().postNotificationName("download Failed", object:errorString)
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