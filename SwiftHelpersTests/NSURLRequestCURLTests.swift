//
//  NSURLRequestCURLTests.swift
//  SwiftHelpers
//
//  Created by David Miotti on 11/01/16.
//  Copyright © 2016 Wopata. All rights reserved.
//

import XCTest
import SwiftHelpers

class NSURLRequestCURLTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testcURL() {
        var req = URLRequest(url: URL(string: "http://google.fr")!)
        req.httpMethod = "POST"
        let params = [ "email": "david.miotti@wopata.com" ]

        let json = try! JSONSerialization.data(withJSONObject: params, options: .prettyPrinted)
        req.httpBody = json
        req.setValue("Boddy", forHTTPHeaderField: "Authorization")
        
        let cURL = req.cURL()

        let rangeOfMethod = cURL.rangeString("-X POST")
        XCTAssert(rangeOfMethod.length > 0, "\(cURL) Should have a -X POST")
        
        let rangeOfHeader = cURL.rangeString("-H 'Authorization: Boddy'")
        XCTAssert(rangeOfHeader.length > 0, "\(cURL) Should have formatted header")
        
        let rangeOfParams = cURL.rangeString("-d '{\"email\":\"david.miotti@wopata.com\"}'")
        XCTAssert(rangeOfParams.length > 0, "\(cURL) Should have formatted params")

        let rangeOfURL = cURL.rangeString("'http://google.fr'")
        XCTAssert(rangeOfURL.length > 0, "\(cURL) Should have URL in it")
    }
    
}
