//
//  ClosureEducationTests.swift
//  ClosureEducationTests
//
//  Created by Scott McCoy on 8/26/15.
//  Copyright (c) 2015 ScottSoft. All rights reserved.
//

import UIKit
import XCTest

class BadClassDesignWithLazyClosureVarTests: XCTestCase {
	
	var expectation:XCTestExpectation!
	
	
	
    func testWithoutClosureCall() {
		self.expectation = self.expectationWithDescription("Expected object to deallocate")
		
		useObjectWithoutInvokingClosure()

		self.waitForExpectationsWithTimeout(1, handler:nil)
    }
	
	func useObjectWithoutInvokingClosure() {
		var testObj = BadClassDesignWithLazyClosureVar(name:"Foo", deinitBlock:{
			self.expectation.fulfill()
		})
		
		//DON'T Call the closure
		//testObj.lazyVarClosureThatCapturesSelf()
	}
	
	
	
	
	//In this test we actually call the closure. Since the closure captures self without the use of [weak self],
	//we expect that testObj will never deinit.
	func testWithClosureCall() {
		
		var testObj = BadClassDesignWithLazyClosureVar(name:"Foo", deinitBlock:{
			XCTFail("Expected object to never deallocate")
		})
		
		//Call the closure
		testObj.lazyVarClosureThatCapturesSelf()

	}
	
	
	
}
