//
//  IntExtensionTests.swift
//  SwiftHelpers
//
//  Created by David Miotti on 14/01/2015.
//  Copyright (c) 2015 Wopata. All rights reserved.
//

import UIKit
import XCTest
import SwiftHelpers

class IntExtensionTests: XCTestCase {

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testEach() {
        var number = 5
        var executeTimes = 0
        var closure: (Int) -> () = { i in executeTimes += 1 }
        5.each(closure)
        XCTAssert(executeTimes == number, "executeTimes == number")
    }

}
