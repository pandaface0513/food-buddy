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

class LogInTest:XCTestCase{
	var isCompleted:Bool?
	
	let testUser = User()
	//let userDataBase = UserDataBase()
	let postDataBase = PostDataBase()
	let photoDataBase = PhotoDataBase()
	let restaurantDataBase = RestaurantDataBase()
	
	
	override func setUp() {
		super.setUp()
		// Put setup code here. This method is called before the invocation of each test method in the class.
		isCompleted = false
		Parse.setApplicationId("2fa3goVgGVtm6DyAga3k0W49MUqCd9PXnFYXP1FT", clientKey: "EReOFbDjtwvqtURF7FcjW4Tqer2niPVf8yt3UngE")
		
		NSNotificationCenter.defaultCenter().addObserver(self, selector: "completed:", name: "logIn Done", object: nil)
		NSNotificationCenter.defaultCenter().addObserver(self, selector: "failed:", name: "logIn Failed", object: nil)
		testUser.logIn("testuser",passwd: "testpassword")
		
		//timeout control
		isCompleted = false
		var isTimeout = false
		let timeout:NSTimeInterval = 15.0
		let idle:NSTimeInterval = 0.01;
		var timeoutDate:NSDate = NSDate(timeIntervalSinceNow: timeout)
		while(!isTimeout && !isCompleted!)
		{
			var tick:NSDate = NSDate.init(timeIntervalSinceNow: idle)
			NSRunLoop.currentRunLoop().runUntilDate(tick)
			isTimeout = (tick.compare(timeoutDate) == NSComparisonResult.OrderedDescending)
		}
		
		NSNotificationCenter.defaultCenter().removeObserver(self, name: "logIn Done", object: nil)
		NSNotificationCenter.defaultCenter().removeObserver(self, name: "logIn Failed", object: nil)
		
		if isTimeout {
			println("time out")
			return
		}
	}
	
	func completed(notification:NSNotification){
		isCompleted = true;
		testUser.addFriend("hicharliehowareyou?")
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
	}
*/
}