//
//  DateProximityTests.swift
//  SwiftHelpers
//
//  Created by David Miotti on 30/06/2015.
//  Copyright (c) 2015 Muxu.Muxu. All rights reserved.
//

import Foundation
import XCTest
import SwiftHelpers

class DateProximityTests: XCTestCase {
    func testToday() {
        let prox = SHDateProximityToDate(Date())
        XCTAssert(prox == .today, "date must be today")
    }
}
