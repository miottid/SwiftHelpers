//
//  ComparisonHelperTests.swift
//  SwiftHelpers
//
//  Created by David Miotti on 19/01/2015.
//  Copyright (c) 2015 Muxu.Muxu. All rights reserved.
//

import Foundation
import XCTest
import SwiftHelpers

class ComparisonHelperTests: XCTestCase {

    func testIntEqualFloat() {
        let myInt = 10 as Int
        let myFloat = 10.000 as Float
        XCTAssert(myInt == myFloat, "myInt == myFloat")
    }
    
    func testFloatEqualInt() {
        let myInt = 10 as Int
        let myFloat = 10.000 as Float
        XCTAssert(myFloat == myInt, "myFloat == myInt")
    }
    
    func testIntLesserThanFloat() {
        let myInt = 10 as Int
        let myFloat = 999.99 as Float
        XCTAssert(myInt < myFloat, "myInt < myFloat")
    }
    
    func testIntGreaterThanFloat() {
        let myInt = 10 as Int
        let myFloat = 9.99 as Float
        XCTAssert(myInt > myFloat, "myInt > myFloat")
    }
    
    func testFloatLesserThanInt() {
        let myInt = 10 as Int
        let myFloat = 9.99 as Float
        XCTAssert(myFloat < myInt, "myFloat < myInt")
    }
    
    func testFloatGreaterThanInt() {
        let myInt = 10 as Int
        let myFloat = 11.99 as Float
        XCTAssert(myFloat > myInt, "myFloat > myInt")
    }
    
    func testFloatGreaterOrEqualInt() {
        let myInt = 10 as Int
        let myFloat = 11.99 as Float
        XCTAssert(myFloat >= myInt, "myFloat >= myInt")
        let equalFloat = 10.00 as Float
        XCTAssert(equalFloat >= myInt, "equalFloat >= myInt")
    }
    
    func testFloatLesserOrEqualInt() {
        let myInt = 10 as Int
        let myFloat = 9.99 as Float
        XCTAssert(myFloat <= myInt, "myFloat >= myInt")
        let equalFloat = 10.00 as Float
        XCTAssert(equalFloat <= myInt, "equalFloat >= myInt")
    }
    
    func testIntGreaterOrEqualFloat() {
        let myInt = 100 as Int
        let myFloat = 19.99 as Float
        XCTAssert(myInt >= myFloat, "myInt >= myFloat")
        let equalFloat = 10.000 as Float
        XCTAssert(myInt >= equalFloat, "myInt >= myFloat")
    }
    
    func testIntLesserOrEqualFloat() {
        let myInt = 10 as Int
        let myFloat = 19.99 as Float
        XCTAssert(myInt <= myFloat, "myInt <= myFloat")
        let equalFloat = 10.00 as Float
        XCTAssert(myInt <= equalFloat, "myInt <= equalFloat")
    }
    
    func testFloatAddEqualInt() {
        let myInt = 10 as Int
        var myFloat = 10.5 as Float
        myFloat += myInt
        XCTAssert(myFloat == 20.5, "myFloat == 20.5 (+=)")
    }
    
    func testFloatMinusEqualInt() {
        let myInt = 10 as Int
        var myFloat = 10.5 as Float
        myFloat -= myInt
        XCTAssert(myFloat == 0.5, "myFloat == 0.5 (-=)")
    }

}
