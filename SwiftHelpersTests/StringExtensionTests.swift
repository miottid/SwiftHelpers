//
//  StringExtensionTests.swift
//  SwiftHelpers
//
//  Created by David Miotti on 25/03/2015.
//  Copyright (c) 2015 Muxu.Muxu. All rights reserved.
//

import Foundation
import XCTest
import SwiftHelpers

class StringExtensionTests: XCTestCase {
    
    func testFloatValue() {
        let expected = 1.456
        let str = "\(expected)"
        XCTAssert(expected.description == str.floatValue.description, "\"\(str)\".floatValue should be equal to \(expected)")
    }
    
    func testRangeOfString() {
        let str = "Hi, my name is David"
        let range = str.rangeString("David")
        XCTAssert(range.location == 15, "range location must be 15")
        XCTAssert(range.length == 5, "range length must be 5")
    }
    
    func testCreateColorFromHex() {
        let hex = "#000099"
        let color = hex.UIColor
        let hexValue = color.hexRGB
        XCTAssert(hexValue == hex, "hex must be the same")
    }

    func testFirstLetterCapitalisation() {
        let source = "hello worlD!"
        let expected = "Hello worlD!"
        let transformed = source.firstLetterCapitalization
        XCTAssertEqual(expected, transformed)
    }

    func testRangesOfString() {
        let source = "Hi you ! Is there something I can do for you ?"
        let pattern = "you"

        let ranges = source.ranges(of: pattern)

        let expectations = [
            NSRange(location: 3, length: 3),
            NSRange(location: 41, length: 3)
        ]

        ranges.forEach { range in
            let matched = expectations.contains {
                range.location == $0.location && range.length == $0.length
            }
            XCTAssert(matched)
        }
    }
    
}
