//
//  SHOperationTests.swift
//  SwiftHelpers
//
//  Created by David Miotti on 28/02/16.
//  Copyright © 2016 Wopata. All rights reserved.
//

import XCTest
import SwiftHelpers

private let kTestOperationSayHello = "Hello!"

final class TestOperation: SHOperation {
    func sayHello() -> String {
        return kTestOperationSayHello
    }
    override func execute() {
        finish()
    }
}

class SHOperationTests: XCTestCase {
    
    func testInitWithCompletionBlock() {
        let queue = NSOperationQueue()
        let expectation = expectationWithDescription("Test completion block on SHOperation")
        let testOp = TestOperation { op in
            XCTAssertTrue(op is TestOperation, "\(op) is TestOperation")
            let op = op as! TestOperation
            let hello = op.sayHello()
            XCTAssertEqual(hello, kTestOperationSayHello, "\(hello) == \(kTestOperationSayHello)")
            expectation.fulfill()
        }
        queue.addOperation(testOp)
        waitForExpectationsWithTimeout(10) { error in
            print("Expectation timeout: \(error)")
        }
    }
    
    func testInit() {
        let queue = NSOperationQueue()
        let expectation = expectationWithDescription("Test init SHOperation")
        let testOp = TestOperation()
        testOp.completionBlock = {
            expectation.fulfill()
        }
        queue.addOperation(testOp)
        waitForExpectationsWithTimeout(10) { error in
            print("Expectation timeout: \(error)")
        }
    }
    
}
