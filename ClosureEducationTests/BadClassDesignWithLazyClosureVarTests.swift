//In this test we demonstrate how lazy vars can cause self-retains, but only if activated (and thus, instatiated)

import UIKit
import XCTest

class BadClassDesignWithLazyClosureVarTests: XCTestCase {
	
	var expectation:XCTestExpectation!
	
	//MARK: Test 1
	//In this test we call the closure. Since the closure captures self without the use of [weak self],
	//we expect that testObj will never deinit.
	func testWithClosureCall() {
		
		var testObj = BadClassDesignWithLazyClosureVar(deinitBlock:{
			XCTFail("Expected object to never deallocate")
		})
		
		//Call the closure
		testObj.lazyVarClosureThatCapturesSelf()
		
	}
	
	//MARK: Test 2
	//In this test we *dont* call the closure and expect that the deinit block will get called.
	func testWithoutClosureCall() {
		self.expectation = self.expectationWithDescription("Expected object to deallocate")
		
		useObjectWithoutInvokingClosure()

		self.waitForExpectationsWithTimeout(1, handler:nil)
    }
	
	func useObjectWithoutInvokingClosure() {
		var testObj = BadClassDesignWithLazyClosureVar(deinitBlock:{
			self.expectation.fulfill()
		})
		
		//DON'T Call the closure
		//testObj.lazyVarClosureThatCapturesSelf()
	}
	
}
