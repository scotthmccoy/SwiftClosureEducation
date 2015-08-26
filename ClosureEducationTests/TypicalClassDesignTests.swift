
import XCTest

class NoCaptureListTest: XCTestCase {
	
	var expectation:XCTestExpectation!
	func testDispatchAfterWithWeakSelf() {
		expectation = self.expectationWithDescription("Expected object to deallocate")
		
		doStuff()
		
		self.waitForExpectationsWithTimeout(2, handler:nil)
		
		//I'm not sure if this is a hack or not, but it this seems to give the test application context
		//plenty of time to allow GCD queues to complete. I tried putting it in is own XCTest file but it doesn't
		//seem to have the same effect there.
		sleep(3)
	}
	
	func doStuff() {
		var testObj = TypicalClassDesign(deinitBlock:{
			self.expectation.fulfill()
		})
		testObj.dispatchAfterWithNoCaptureList()
	}
	
	
	
}


class WeakSelfTest: XCTestCase {

	var expectation:XCTestExpectation!
    func testDispatchAfterWithWeakSelf() {
		expectation = self.expectationWithDescription("Expected object to deinit")

		doStuff()
		
		self.waitForExpectationsWithTimeout(2, handler:nil)
		
		//I'm not sure if this is a hack or not, but it this seems to give the test application context 
		//plenty of time to allow GCD queues to complete. I tried putting it in is own XCTest file but it doesn't
		//seem to have the same effect there.
		//sleep(3)
    }
	
	func doStuff() {
		var testObj = TypicalClassDesign(deinitBlock:{
			self.expectation.fulfill()
		})
		testObj.dispatchAfterWithWeakSelf()
	}
}




class UnownedSelfTest: XCTestCase {
	
	var expectation:XCTestExpectation!
	func testDispatchAfterWithUnownedSelf() {
		self.expectation = self.expectationWithDescription("Expected object to deallocate")
		doStuff()
		self.waitForExpectationsWithTimeout(2, handler:nil)
	}
	
	func doStuff() {
		var testObj = TypicalClassDesign(deinitBlock:{
			self.expectation.fulfill()
		})
		testObj.dispatchAfterWithUnownedSelf()
	}
}
