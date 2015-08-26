//
//  ObjectWithClosureProperty.swift
//  ClosureEducation
//
//  Created by Scott McCoy on 8/26/15.
//  Copyright (c) 2015 ScottSoft. All rights reserved.
//

import Foundation

class HTMLElement {
	
	let name: String
	var deinitBlock: () -> ()
	lazy var asHTML: () -> String = {

		return "<\(self.name)>TAG BODY</\(self.name)>"

	}
	
	init(name: String, deinitBlock: () -> ()) {
		self.name = name
		self.deinitBlock = deinitBlock
	}
	
	
	deinit {
		deinitBlock()
	}
}