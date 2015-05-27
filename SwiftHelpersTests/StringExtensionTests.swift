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
    
    func testFloatValue() {
        let str = "1.4"
        XCTAssert(str.floatValue == 1.4, "\"1.4\".floatValue should be equal to 1.4")
    }
    
    func testRangeOfString() {
        let str = "Hi, my name is David"
        let range = str.rangeString("David")
        XCTAssert(range.location == 15, "range location must be 15")
        XCTAssert(range.length == 5, "range length must be 5")
    }
    
}
