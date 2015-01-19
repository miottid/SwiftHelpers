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

    func testEach() {
        var number = 5
        var executeTimes = 0
        var closure: (Int) -> () = { i in executeTimes += 1 }
        5.each(closure)
        XCTAssert(executeTimes == number, "executeTimes == number")
    }

}
