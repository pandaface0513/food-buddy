//
//  CloudCodeTest.swift
//  Project Foodie
//
//  Created by caili lowang on 2015-04-28.
//  Copyright (c) 2015 Victor. All rights reserved.
//

import UIKit
import XCTest

class CloudCodeTest: XCTestCase {

	let postDataBase = PostDataBase()
	
    override func setUp() {
		postDataBase.findFriendPost("ZAFd9t4C2m")
        // Put setup code here. This method is called before the invocation of each test method in the class.
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
