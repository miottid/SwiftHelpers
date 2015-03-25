//
//  StringExtensionTests.swift
//  SwiftHelpers
//
//  Created by David Miotti on 25/03/2015.
//  Copyright (c) 2015 Wopata. All rights reserved.
//

import UIKit
import XCTest

class StringExtensionTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testFloatValue() {
        var str = "1.4"
        XCTAssert(str.floatValue == 1.4, "\"1.4\".floatValue should be equal to 1.4")
    }
}
