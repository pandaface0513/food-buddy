//
//  DataBaseTest.swift
//  Project Foodie
//
//  Created by MacWANG on 2015-02-21.
//  Copyright (c) 2015 Victor. All rights reserved.
//

import Foundation
import UIKit
import XCTest

class TestingUploadTest:XCTestCase{
	var isCompleted:Bool?
	
	let testUser = User()
	let testingDataBase = TestingDataBase()
	
	
	override func setUp() {
		super.setUp()
		// Put setup code here. This method is called before the invocation of each test method in the class.
		var isTimeout = false;
		var restaurantCount = 0
		var oneTimeUploadCount = 1
		Parse.setApplicationId("2fa3goVgGVtm6DyAga3k0W49MUqCd9PXnFYXP1FT", clientKey: "EReOFbDjtwvqtURF7FcjW4Tqer2niPVf8yt3UngE")
		
		while(restaurantCount < oneTimeUploadCount){
			
			NSNotificationCenter.defaultCenter().addObserver(self, selector: "completed:", name: "upload Done", object: nil)
			NSNotificationCenter.defaultCenter().addObserver(self, selector: "failed:", name: "upload Failed", object: nil)
			
//			let restaurant = ["name":"henry's kitchen \(restaurantCount)","description":"henry's home made good stuff","location":"123 vancouver ave. earth","menu":"any home made stuff"]
			let restaurant = ["name":"henry's kitchen","description":"henry's home made good stuff","location":"123 vancouver ave. earth","menu":"any home made stuff","typetest":123]
			testingDataBase.upload(restaurant)
			
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

			NSNotificationCenter.defaultCenter().removeObserver(self, name: "upload Done", object: nil)
			NSNotificationCenter.defaultCenter().removeObserver(self, name: "upload Failed", object: nil)
			
			println("restaurantCount = \(restaurantCount) isTimeout = \(isTimeout)\n")
			restaurantCount = restaurantCount + 1
			
			if isTimeout{
				return
			}
		}
	}
	
	func completed(notification:NSNotification){
		isCompleted = true;
		print("\n**********\(notification.description)**********\n")
	}
	
	func failed(notification:NSNotification){
		isCompleted = true;
		print("\n**********\(notification.description)**********\n")
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
	}*/
}