//
//  ClosureEducationTests.swift
//  ClosureEducationTests
//
//  Created by Scott McCoy on 8/26/15.
//  Copyright (c) 2015 ScottSoft. All rights reserved.
//

import UIKit
import XCTest

class ClosureEducationTests: XCTestCase {
	
	var expectation:XCTestExpectation!
	
	override func setUp() {
		OXMDebugLogWhereAmI()
		
		let expectation = self.expectationWithDescription("Expected object to deallocate")
	}
	
	override func tearDown() {
		OXMDebugLogWhereAmI()
		
		self.waitForExpectationsWithTimeout(1, handler:nil)
	}
	
    func testWithClosureCall() {
		
		OXMDebugLogWhereAmI()
		
		var testObj = HTMLElement(name:"Foo", deinitBlock:{
			self.expectation.fulfill()
		})
		testObj.asHTML()
		
		
    }
    
//	func testWithOutClosureCall() {
//		var testObj = HTMLElement(name:"Foo", deinitBlock:{
//			println("Test")
//		})
//		//testObj.asHTML()
//	}
	
	
}
