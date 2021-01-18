//
//  XCTestCase+MemoryLeakTracking.swift
//  Tests
//
//  Created by Alok Subedi on 18/01/2021.
//  Copyright © 2021 Essential Developer. All rights reserved.
//

import XCTest

extension XCTestCase{
	func trackForMemoryLeak(_ instance: AnyObject, file: StaticString = #file, line: UInt = #line){
		addTeardownBlock { [weak instance] in
			XCTAssertNil(instance, "Instance should have deallocated. Possible memory leak",file: file, line: line)
		}
	}
}
