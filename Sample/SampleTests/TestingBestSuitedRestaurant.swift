//
//  TestingBestSuitedRestaurant.swift
//  Project Foodie
//
//  Created by caili lowang on 2015-05-01.
//  Copyright (c) 2015 Victor. All rights reserved.
//

import UIKit
import XCTest

class TestingBestSuitedRestaurant: XCTestCase {
	var isCompleted:Bool?
	
	let restaurantDataBase = RestaurantDataBase()
	
	
    override func setUp() {
		super.setUp()
		// Put setup code here. This method is called before the invocation of each test method in the class.
		Parse.setApplicationId("2fa3goVgGVtm6DyAga3k0W49MUqCd9PXnFYXP1FT", clientKey: "EReOFbDjtwvqtURF7FcjW4Tqer2niPVf8yt3UngE")
		
		var isTimeout = false;
		var restaurantCount = 0
		var oneTimeUploadCount = 1
		
		while(restaurantCount < oneTimeUploadCount){
			
			NSNotificationCenter.defaultCenter().addObserver(self, selector: "completed:", name: "upload Done", object: nil)
			NSNotificationCenter.defaultCenter().addObserver(self, selector: "failed:", name: "upload Failed", object: nil)
			
			testBestSuitedRestaurantCloud()
			
			//timeout control
			isCompleted = false
			isTimeout = false
			let timeout:NSTimeInterval = 15.0
			let idle:NSTimeInterval = 0.01;
			var timeoutDate:NSDate = NSDate(timeIntervalSinceNow: timeout)
			while(!isTimeout && !isCompleted!)
			{
				var tick:NSDate = NSDate.init(timeIntervalSinceNow: idle)
				NSRunLoop.currentRunLoop().runUntilDate(tick)
				isTimeout = (tick.compare(timeoutDate) == NSComparisonResult.OrderedDescending)
			}
			
			println("restaurantCount = \(restaurantCount) isTimeout = \(isTimeout)\n")
			restaurantCount = restaurantCount + 1
			
			if isTimeout{
				return
			}
		}
    }
	
	func testBestSuitedRestaurantCloud(){
		let userIds = ["tEJ0nap2cQ","IW13xDIunF"]
		let geoPoint = PFGeoPoint(latitude: 42.72, longitude: 72.79)
		let rangeKiloRadius = 100 as Double
		
		NSNotificationCenter.defaultCenter().addObserver(self, selector: "testBestSuitedRestaurantCloudHelper:", name: "findBestSuitedRestaurantsCloud Done", object: nil)
		NSNotificationCenter.defaultCenter().addObserver(self, selector: "testBestSuitedRestaurantCloudHelper:", name: "findBestSuitedRestaurantsCloud Failed", object: nil)
		
		
		restaurantDataBase.findBestSuitedRestaurantsCloud(geoPoint,userIds: userIds,rangeKiloRadius: rangeKiloRadius)
	}
	
	func testBestSuitedRestaurantCloudHelper(notification:NSNotification){
		NSNotificationCenter.defaultCenter().removeObserver(self, name: "findBestSuitedRestaurantsCloud Done", object: nil)
		NSNotificationCenter.defaultCenter().removeObserver(self, name: "findBestSuitedRestaurantsCloud Failed", object: nil)
		
		let object = notification.object as! [Dictionary<String,AnyObject>]
		println(object)
		
		NSNotificationCenter.defaultCenter().addObserver(self, selector: "findRestaurantWithIdHelper:", name: "findRestaurantWithId Done", object: nil)
		NSNotificationCenter.defaultCenter().addObserver(self, selector: "findRestaurantWithIdHelper:", name: "findRestaurantWithId Failed", object: nil)
		
		restaurantDataBase.findRestaurantWithID(object[0]["objectId"]! as! String)
	}
	
	func findRestaurantWithIdHelper(notification:NSNotification){
		NSNotificationCenter.defaultCenter().removeObserver(self, name: "findRestaurantWithId Done", object: nil)
		NSNotificationCenter.defaultCenter().removeObserver(self, name: "findRestaurantWithId Failed", object: nil)
		
		let object = notification.object as! Dictionary<String,AnyObject>
		println(object)
	}
	
	
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testExample() {
        // This is an example of a functional test case.
        XCTAssert(true, "Pass")
    }
/*
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measureBlock() {
            // Put the code you want to measure the time of here.
        }
    }
*/

}
