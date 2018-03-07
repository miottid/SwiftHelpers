//
//  UIColorExtensionTests.swift
//  SwiftHelpers
//
//  Created by David Miotti on 26/01/2015.
//  Copyright (c) 2015 Muxu.Muxu. All rights reserved.
//

#if os(iOS)

import UIKit
import XCTest

class UIColorExtensionTests: XCTestCase {

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testCreateUIColorRGBA() {
        let color = UIColor(r: 50, g: 50, b: 50, a: 1)
        XCTAssertNotNil(color, "convenient UIColor(r: 50, g: 50, b: 50, a: 1) constructor")
    }

}

#endif
