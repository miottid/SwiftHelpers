//
//  ArrayExtensionTests.swift
//  SwiftHelpers
//
//  Created by David Miotti on 14/01/2015.
//  Copyright (c) 2015 Muxu.Muxu. All rights reserved.
//

import Foundation
import XCTest
import SwiftHelpers

class ArrayExtensionTests: XCTestCase {

    func testEach() {
        let array = [1, 2, 3, 4]
        var executeTimes = 0
        let expectedExecuteTimes = array.count
        let closure: (Int) -> () = { i in executeTimes += 1 }
        [1, 2, 3, 4].forEach(closure)
        XCTAssert(executeTimes == expectedExecuteTimes, "executeTimes == expectedExecuteTimes")
    }

    func testUniq() {
        let array = [1, 1, 2, 2, 3, 4, 4]
        let un = uniq(array)
        XCTAssert(un.count == 4)
    }

}
