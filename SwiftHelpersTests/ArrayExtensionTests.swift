//
//  ArrayExtensionTests.swift
//  SwiftHelpers
//
//  Created by David Miotti on 14/01/2015.
//  Copyright (c) 2015 Wopata. All rights reserved.
//

import UIKit
import XCTest
import SwiftHelpers

class ArrayExtensionTests: XCTestCase {

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testEach() {
        let array = [1, 2, 3, 4]
        var executeTimes = 0
        var expectedExecuteTimes = array.count
        var closure: (Int) -> () = { i in executeTimes += 1 }
        [1, 2, 3, 4].each(closure)
        XCTAssert(executeTimes == expectedExecuteTimes, "executeTimes == expectedExecuteTimes")
    }

}
