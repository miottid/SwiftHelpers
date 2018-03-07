//
//  SHNSObjectExtensionTests.swift
//  SwiftHelpers
//
//  Created by Maxime de Chalendar on 04/07/2016.
//  Copyright © 2016 Muxu.Muxu. All rights reserved.
//

import XCTest
import SwiftHelpers

class SHNSObjectExtensionTests: XCTestCase {

    func testClassName() {
        XCTAssertEqual(NSObject.className, "NSObject",
                       "The class name for NSObject should be \"NSObject\", not \(NSObject.className)")

        #if os(iOS)
        XCTAssertEqual(UITableViewCell.className, "UITableViewCell",
                       "The class name for UITableViewCell should be \"UITableViewCell\", not \(UITableViewCell.className)")
        #endif
    }

    func testClassReuseIdentifier() {
        XCTAssertEqual(NSObject.classReuseIdentifier, "NSObject",
                       "The reuse identifier for NSObject should be \"NSObject\", not \(NSObject.className)")

        #if os(iOS)
        XCTAssertEqual(UITableViewCell.classReuseIdentifier, "UITableViewCell",
                       "The class name for UITableViewCell should be \"UITableViewCell\", not \(UITableViewCell.className)")
        #endif
    }

}
