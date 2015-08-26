//
//  ObjectWithClosureProperty.swift
//  ClosureEducation
//
//  Created by Scott McCoy on 8/26/15.
//  Copyright (c) 2015 ScottSoft. All rights reserved.
//

import Foundation

class BadClassDesignWithLazyClosureVar {
	
	//MARK: vars
	var myVar = "Foo"
	var deinitBlock: () -> ()
	
	//This is an example of bad class design. The closure captures self.
	//If invoked, it will cause a strong reference cycle and instances of the class
	//will never deinit.
	lazy var lazyVarClosureThatCapturesSelf: () -> String = {
		return self.myVar
	}

	//MARK: Methods
	init(deinitBlock: () -> ()) {
		self.deinitBlock = deinitBlock
	}
	
	
	deinit {
		deinitBlock()
	}
}