import Foundation

class TypicalClassDesign {
	
	//MARK: vars
	var myVar = "Foo"
	
	//USe a delaytime of 3 seconds to give plenty of time for self to deinit
	var delayTime = dispatch_time(DISPATCH_TIME_NOW, Int64(3.0 * Double(NSEC_PER_SEC)))
	var deinitBlock: () -> ()
	
	
	//MARK: Methods
	init(deinitBlock: () -> ()) {
		self.deinitBlock = deinitBlock
	}

	func dispatchAfterWithNoCaptureList() {
		dispatch_after(delayTime, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0)) {
			//This is not safe!
			//self.myVar = "Different"
		}
	}
	
	
	func dispatchAfterWithWeakSelf() {
		dispatch_after(delayTime, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0)) { [weak self]()->() in
			self?.myVar = "Different"
		}
	}
	
	func dispatchAfterWithUnownedSelf() {
		dispatch_after(delayTime, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0)) { [unowned self]()->() in
			OXMDebugLogWhereAmI()
			//This will cause an EXC_BREAKPOINT
			//self.myVar = "Different"
			
			//NOTE: No way to check if self is safe to use!!!
			//This is not legal:
			//let optionalSelf:TypicalClassDesign = self
		}
	}
	
	deinit {
		deinitBlock()
	}
}