//
//  CommonInitTests.swift
//  SwiftHelpers
//
//  Created by David Miotti on 22/11/15.
//  Copyright © 2015 Wopata. All rights reserved.
//

import XCTest

private let kTagTestCommonInit = 55

class TestView: SHCommonInitView {
    override func commonInit() {
        super.commonInit()
        tag = kTagTestCommonInit
    }
}

class TestTableViewCell: SHCommonInitTableViewCell {
    override func commonInit() {
        super.commonInit()
        tag = kTagTestCommonInit
    }
}

class TestCollectionViewCell: SHCommonInitCollectionViewCell {
    override func commonInit() {
        super.commonInit()
        tag = kTagTestCommonInit
    }
}

class CommonInitTests: XCTestCase {
    
    func testViewCommonInit() {
        let testView = TestView()
        XCTAssertEqual(testView.tag, 55)
        
        let testTableViewCell = TestTableViewCell()
        XCTAssertEqual(testTableViewCell.tag, 55)
        
        let testCollectionViewCell = TestCollectionViewCell()
        XCTAssertEqual(testCollectionViewCell.tag, 55)
    }
    
}
