//
//  LocalizationTests.swift
//  SwiftHelpers
//
//  Created by Guillaume Bellue on 18/01/2017.
//  Copyright © 2017 Muxu.Muxu. All rights reserved.
//

import XCTest
import SwiftHelpers

class LocalizationTests: XCTestCase {
    var bundle = Bundle.main
    
    override func setUp() {
        super.setUp()

        guard let path = Bundle(for: LocalizationTests.self).path(forResource: "en", ofType: "lproj") else { return }
        bundle = Bundle(path: path)!
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testL() {
        XCTAssertEqual(L("simple-no-count", bundle: bundle), "text without count")

        XCTAssertEqual(L("simple-with-count", nb: 0, bundle: bundle), "text with count 0 zero")
        XCTAssertEqual(L("simple-with-count", nb: 1, bundle: bundle), "text with count 1 one")
        XCTAssertEqual(L("simple-with-count", nb: 2, bundle: bundle), "text with count 2 other")
    }

    func testLocalize() {
        XCTAssertEqual("args-no-count".localize(bundle: bundle), "text without count")

        XCTAssertEqual("args-with-count".localize(arguments: ["count": 0], bundle: bundle), "text with count 0 zero")
        XCTAssertEqual("args-with-count".localize(arguments: ["count": 1], bundle: bundle), "text with count 1 one")
        XCTAssertEqual("args-with-count".localize(arguments: ["count": 2], bundle: bundle), "text with count 2 other")
        XCTAssertEqual("args-with-count".localize(arguments: ["count": 0.5], bundle: bundle), "text with count 0.5 other")


        XCTAssertEqual("args-with-args".localize(arguments: ["arg1": "foo", "arg2": "bar"], bundle: bundle), "text with args bar foo")

        XCTAssertEqual("args-with-args-count".localize(arguments: ["arg1": "foo", "count": 0], bundle: bundle), "text with foo no bars")
        XCTAssertEqual("args-with-args-count".localize(arguments: ["arg1": "foo", "count": 1], bundle: bundle), "text with foo 1 bar")
        XCTAssertEqual("args-with-args-count".localize(arguments: ["arg1": "foo", "count": 12], bundle: bundle), "text with foo 12 bars")
    }
    
}
