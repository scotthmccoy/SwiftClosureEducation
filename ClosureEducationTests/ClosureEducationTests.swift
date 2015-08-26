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
	
	
	
    func testWithoutClosureCall() {
		self.expectation = self.expectationWithDescription("Expected object to deallocate")
		
		useObjectWithoutInvokingClosure()

		self.waitForExpectationsWithTimeout(1, handler:nil)
    }
	
	func useObjectWithoutInvokingClosure() {
		var testObj = HTMLElement(name:"Foo", deinitBlock:{
			self.expectation.fulfill()
		})
		
		//testObj.asHTML()
	}
	
	
	
	
	
	func testWithClosureCall() {
		
		var testObj = HTMLElement(name:"Foo", deinitBlock:{
			XCTFail("Expected object to never deallocate")
		})
		testObj.asHTML()

	}
	
	
	
}
