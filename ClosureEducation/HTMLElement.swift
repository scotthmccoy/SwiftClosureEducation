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
	let text: String?
	
	lazy var asHTML: () -> String = {
		if let text = self.text {
			return "<\(self.name)>\(text)</\(self.name)>"
		} else {
			return "<\(self.name) />"
		}
	}
	
	init(name: String, text: String? = nil) {
		self.name = name
		self.text = text
	}
	
	
	deinit {
		println("\(self.name) is being deinitialized")
	}
}