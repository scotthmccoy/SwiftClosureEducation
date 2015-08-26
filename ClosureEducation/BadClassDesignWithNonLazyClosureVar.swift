import Foundation

class BadClassDesignWithNonLazyClosureVar {
	
	//MARK: vars
	var myVar = "Foo"
	var deinitBlock: () -> ()
	

	typealias myClosureType = () -> String
	var nonLazyVarClosureThatCapturesSelf:myClosureType!
	
	
	//MARK: Methods
	init(deinitBlock: () -> ()) {
		self.deinitBlock = deinitBlock
	}
	
	
	deinit {
		deinitBlock()
	}
}