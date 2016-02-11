//
//  DateProximityTests.swift
//  SwiftHelpers
//
//  Created by David Miotti on 30/06/2015.
//  Copyright (c) 2015 Wopata. All rights reserved.
//

import UIKit
import XCTest
import SwiftHelpers

class DateProximityTests: XCTestCase {
    func testToday() {
        let now = NSDate()
        let date = SHDateProximityToDate(now)
        XCTAssert(date == .Today, "date must be today")
    }
}
