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

	func uploatRelationalWithCurrentGeoLocation(dataBase:DataBase?, parentId:String?, child:Dictionary<String,AnyObject!>)->Void{
		PFGeoPoint.geoPointForCurrentLocationInBackground{
			(geoPoint:PFGeoPoint!, error:NSError!)->Void in
			if error == nil{
				var newData = child
				newData.updateValue(geoPoint, forKey: "geoLocation")
				self.uploadRelational(dataBase, parentId: parentId, child: newData)
			}
			else{
				let errorString = error.userInfo?["error"] as! NSString
				NSNotificationCenter.defaultCenter().postNotificationName("upload Failed", object: errorString)
			}
		}
	}
	
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
				let errorString = error.userInfo?["error"]as! NSString
				// Show the errorString somewhere and let the user try again.
				
				NSNotificationCenter.defaultCenter().postNotificationName("upload Failed", object: errorString)
			}
		})
	}
	
	func uploadWithCurrentGeoPoint(data:Dictionary<String,AnyObject>){
		PFGeoPoint.geoPointForCurrentLocationInBackground{
			(geoPoint:PFGeoPoint!, error:NSError!)->Void in
			if error == nil{
				var newData = data
				newData.updateValue(geoPoint, forKey: "geoLocation")
				self.upload(newData)
			}
			else{
				let errorString = error.userInfo?["error"] as! NSString
				NSNotificationCenter.defaultCenter().postNotificationName("upload Failed", object: errorString)
			}
		}
	}
	
    func upload(data:Dictionary<String,AnyObject>)->Void{
		uploadRelational(nil, parentId: nil, child: data)
    }
	
	func downloadEqualTo(equalTo:Dictionary<String,AnyObject>)->Void{
		download(equalTo, containedIn: nil, containString: nil, greaterThanOrEqualTo: nil, lessThanOrEqualTo: nil, dataBase: nil, parentId: nil)
	}
	
	func downloadContainedIn(containedIn:Dictionary<String,[String]>)->Void{
		download(nil, containedIn: containedIn, containString: nil, greaterThanOrEqualTo: nil, lessThanOrEqualTo: nil, dataBase: nil, parentId: nil)
	}
	
	func downloadcontainsString(containString:Dictionary<String,String>)->Void{
		download(nil, containedIn: nil, containString: containString, greaterThanOrEqualTo: nil, lessThanOrEqualTo: nil, dataBase: nil, parentId: nil)
	}
	
	func downloadGreaterThanOrEqualTo(greaterThanOrEqualTo:Dictionary<String,Float>)->Void{
		download(nil, containedIn: nil, containString: nil, greaterThanOrEqualTo: greaterThanOrEqualTo, lessThanOrEqualTo: nil, dataBase: nil, parentId: nil)
	}
	
	func downloadLessThanOrEqualTo(lessThanOrEqualTo:Dictionary<String,Float>)->Void{
		download(nil, containedIn: nil, containString: nil, greaterThanOrEqualTo: nil, lessThanOrEqualTo: lessThanOrEqualTo, dataBase: nil, parentId: nil)
	}
	
	func downloadRelational(dataBase:DataBase,parentId:String){
		download(nil, containedIn: nil, containString: nil, greaterThanOrEqualTo: nil, lessThanOrEqualTo: nil, dataBase: dataBase, parentId: parentId)
	}
	
	func download(equalTo:Dictionary<String,AnyObject>?, containedIn:Dictionary<String,[String]>?, containString:Dictionary<String,String>?, greaterThanOrEqualTo:Dictionary<String,Float>?, lessThanOrEqualTo:Dictionary<String,Float>?, dataBase:DataBase?, parentId:String?){
		
		downloadHelper(equalTo, containedIn: containedIn, containString: containString, greaterThanOrEqualTo: greaterThanOrEqualTo, lessThanOrEqualTo: lessThanOrEqualTo, dataBase: dataBase, parentId: parentId, rangeKiloRadius: nil, geoPoint: nil)
		
	}
	
	func downloadWithLocationRange(rangeKiloRadius:Double?){
		downloadWithLocationRange(nil, containedIn: nil, containString: nil, greaterThanOrEqualTo: nil, lessThanOrEqualTo: nil, dataBase: nil, parentId: nil, rangeKiloRadius: rangeKiloRadius)
	}
	
	func downloadWithLocationRange(equalTo:Dictionary<String,AnyObject>?, containedIn:Dictionary<String,[String]>?, containString:Dictionary<String,String>?, greaterThanOrEqualTo:Dictionary<String,Float>?, lessThanOrEqualTo:Dictionary<String,Float>?, dataBase:DataBase?, parentId:String?, rangeKiloRadius:Double?){
		
		PFGeoPoint.geoPointForCurrentLocationInBackground{
			(geoPoint:PFGeoPoint!, error:NSError!)->Void in
			if error == nil{
				self.downloadHelper(equalTo, containedIn: containedIn, containString: containString, greaterThanOrEqualTo: greaterThanOrEqualTo, lessThanOrEqualTo: lessThanOrEqualTo, dataBase: dataBase, parentId: parentId, rangeKiloRadius: rangeKiloRadius, geoPoint: geoPoint)
			}
			else{
				let errorString = error.userInfo?["error"] as! NSString
				NSNotificationCenter.defaultCenter().postNotificationName("download Failed", object: errorString)
			}
		}
		
	}
	
	func downloadHelper(equalTo:Dictionary<String,AnyObject>?, containedIn:Dictionary<String,[String]>?, containString:Dictionary<String,String>?, greaterThanOrEqualTo:Dictionary<String,Float>?, lessThanOrEqualTo:Dictionary<String,Float>?, dataBase:DataBase?, parentId:String?, rangeKiloRadius:Double?, geoPoint:PFGeoPoint?){
		var data:Array<Dictionary<String,AnyObject>> = Array()
		var querys:Array<PFQuery> = Array()
		var orQuery:PFQuery = PFQuery(className: dataBaseName)
		
		if let option = equalTo{
			for (key,value) in option{
				var temp = PFQuery(className: dataBaseName)
				temp.whereKey(key, equalTo: value)
				querys.append(temp)
			}
		}
		if let option = containedIn{
			for (key,value) in option{
				var temp = PFQuery(className: dataBaseName)
				temp.whereKey(key, equalTo: value)
				querys.append(temp)
			}
		}
		
		if let option = containString{
			for (key,value) in option{
				var temp = PFQuery(className: dataBaseName)
				temp.whereKey(key, equalTo: value)
				querys.append(temp)
			}
		}
		
		if let option = greaterThanOrEqualTo{
			for (key,value) in option{
				var temp = PFQuery(className: dataBaseName)
				temp.whereKey(key, equalTo: value)
				querys.append(temp)
			}
		}
		if let option = lessThanOrEqualTo{
			for (key,value) in option{
				var temp = PFQuery(className: dataBaseName)
				temp.whereKey(key, equalTo: value)
				querys.append(temp)
			}
		}
		
		if !(querys==[]){
			orQuery = PFQuery.orQueryWithSubqueries(querys)
		}
		
		if let dataBaseOption = dataBase{
			if let parentIdOption = parentId{
				orQuery.whereKey("parent", equalTo: PFObject(withoutDataWithClassName: dataBaseOption.dataBaseName, objectId: parentIdOption))
			}
		}
		
		if let range = rangeKiloRadius{
			if let location = geoPoint{
				orQuery.whereKey("location", nearGeoPoint: location, withinKilometers: range)
			}
		}
			
		orQuery.orderByDescending("updatedAt")
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
			dictionary.updateValue(object.createdAt, forKey: "updatedAt")
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
			dictionary.updateValue(object.createdAt, forKey: "updatedAt")
			data.append(dictionary)
		}
		return data
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