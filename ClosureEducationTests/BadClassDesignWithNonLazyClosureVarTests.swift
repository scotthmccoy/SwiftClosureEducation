import UIKit
import XCTest

class BadClassDesignWithNonLazyClosureVarTests: XCTestCase {
	
	

	//MARK: Test 1
	//In this test we set and call the closure. We expect that testObj will never deinit.
	func testWithClosureCall() {
		
		var testObj = BadClassDesignWithNonLazyClosureVar(deinitBlock:{
			XCTFail("Expected object to never deallocate")
		})
		
		//Set the closure
		testObj.nonLazyVarClosureThatCapturesSelf = {
			return testObj.myVar
		}
		
		//Call the closure
		testObj.nonLazyVarClosureThatCapturesSelf()
	}
	
	
	//MARK: Test 2
	//In this test we *dont* call the closure and expect that the deinit block will get called.
	var expectationForTestWithClosureCall:XCTestExpectation!
	func testWithoutClosureCall() {
		self.expectationForTestWithClosureCall = self.expectationWithDescription("Expected object to deallocate")
		
		useObjectWithoutInvokingClosure()
		
		self.waitForExpectationsWithTimeout(1, handler:nil)
	}
	
	func useObjectWithoutInvokingClosure() {
		var testObj = BadClassDesignWithNonLazyClosureVar(deinitBlock:{
			self.expectationForTestWithClosureCall.fulfill()
		})
	}

	//MARK: Test 3
	//In this test we set and call the closure, then nil it. We expect that testObj will deinit.
	var expectationForTestWithClosureCallThatGetsNilledOut:XCTestExpectation!
	func testWithClosureCallThatGetsNilledOut() {
		self.expectationForTestWithClosureCallThatGetsNilledOut = self.expectationWithDescription("Expected object to deallocate")
		useObjectAndClosureThenNil()
		self.waitForExpectationsWithTimeout(1, handler:nil)		
	}
	
	func useObjectAndClosureThenNil() {
		var testObj = BadClassDesignWithNonLazyClosureVar(deinitBlock:{
			self.expectationForTestWithClosureCallThatGetsNilledOut.fulfill()
		})
		
		//Set the closure
		testObj.nonLazyVarClosureThatCapturesSelf = {
			return testObj.myVar
		}
		
		//Call the closure
		testObj.nonLazyVarClosureThatCapturesSelf()
		
		//Nil It
		testObj.nonLazyVarClosureThatCapturesSelf = nil
	}


}
