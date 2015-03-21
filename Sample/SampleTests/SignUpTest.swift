//
//  UploadData.swift
//  Project Foodie
//
//  Created by caili lowang on 2015-02-27.
//  Copyright (c) 2015 Victor. All rights reserved.
//

import Foundation
import UIKit
//import XCTest

class SignUpTest:XCTestCase{
	var isCompleted:Bool?
	
    let testUser = User()
    //let userDataBase = UserDataBase()
    let postDataBase = PostDataBase()
    let preferenceDataBase = PreferenceDataBase()
    let photoDataBase = PhotoDataBase()
    let restaurantDataBase = RestaurantDataBase()
	
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        Parse.setApplicationId("2fa3goVgGVtm6DyAga3k0W49MUqCd9PXnFYXP1FT", clientKey: "EReOFbDjtwvqtURF7FcjW4Tqer2niPVf8yt3UngE")
		isCompleted = false

		NSNotificationCenter.defaultCenter().addObserver(self, selector: "completed:", name: "sigUp Done", object: nil)
		NSNotificationCenter.defaultCenter().addObserver(self, selector: "failed:", name: "signUp Failed", object: nil)
		
        testUser.signUp("testuser", passwd: "testpassword", email: "testuser@vanlemon.com")
		
		//timeout control
        let timeout:NSTimeInterval = 2.0
        let idle:NSTimeInterval = 0.01;
        var isTimeout = false;
        var timeoutDate:NSDate = NSDate.init(timeIntervalSinceNow: timeout)
        

        while(!isTimeout && !isCompleted!)
        {
            var tick:NSDate = NSDate.init(timeIntervalSinceNow: idle)
            NSRunLoop.currentRunLoop().runUntilDate(tick)
            isTimeout = (tick.compare(timeoutDate) == NSComparisonResult.OrderedDescending)
        }
		
		NSNotificationCenter.defaultCenter().removeObserver(self, name: "signUp Done", object: nil)
		NSNotificationCenter.defaultCenter().removeObserver(self, name: "signUp Failed", object: nil)
		
		if isTimeout {
			println("time out")
			return
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
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measureBlock() {
            // Put the code you want to measure the time of here.
        }
    }
}