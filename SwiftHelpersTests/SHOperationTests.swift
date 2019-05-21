//
//  SHOperationTests.swift
//  SwiftHelpers
//
//  Created by David Miotti on 28/02/16.
//  Copyright © 2016 Muxu.Muxu. All rights reserved.
//

import XCTest
import SwiftHelpers

private let kTestOperationSayHello = "Hello!"

class TestOperation: SHOperation {
    func sayHello() -> String {
        return kTestOperationSayHello
    }
    override func execute() {
        finish()
    }
}

class SHOperationTests: XCTestCase {
    
    func testInitWithCompletionBlock() {
        let queue = OperationQueue()
        let exp = expectation(description: "Test completion block on SHOperation")
        let testOp = TestOperation { op in
            XCTAssertTrue(op is TestOperation, "\(op) is TestOperation")
            let op = op as! TestOperation
            let hello = op.sayHello()
            XCTAssertEqual(hello, kTestOperationSayHello, "\(hello) == \(kTestOperationSayHello)")
            exp.fulfill()
        }
        queue.addOperation(testOp)
        waitForExpectations(timeout: 10) { error in
            print("Expectation timeout: \(String(describing: error))")
        }
    }
    
    func testInit() {
        let queue = OperationQueue()
        let exp = expectation(description: "Test init SHOperation")
        let testOp = TestOperation()
        testOp.completionBlock = {
            exp.fulfill()
        }
        queue.addOperation(testOp)
        waitForExpectations(timeout: 10) { error in
            print("Expectation timeout: \(String(describing: error))")
        }
    }
    
}
