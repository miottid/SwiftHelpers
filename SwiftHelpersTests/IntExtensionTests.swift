//
//  IntExtensionTests.swift
//  SwiftHelpers
//
//  Created by David Miotti on 14/01/2015.
//  Copyright (c) 2015 Wopata. All rights reserved.
//

import Foundation
import XCTest
import SwiftHelpers

class IntExtensionTests: XCTestCase {

    func testEach() {
        let number = 5
        var executeTimes = 0
        let closure: (Int) -> () = { i in executeTimes += 1 }
        5.each(closure)
        XCTAssert(executeTimes == number, "executeTimes == number")
    }
    
    func testRandom () {
        for i in -100...100 {
            let number = Int.random(lower: i, upper: i+5)
            XCTAssertLessThanOrEqual(number, i+5, "Random number less than higher boundary")
            XCTAssertGreaterThanOrEqual(number, i, "Random number greater than lesser boundary")
        }
    }

}
