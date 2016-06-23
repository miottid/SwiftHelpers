//
//  SHNSDataExtension.swift
//  SwiftHelpers
//
//  Created by David Miotti on 24/06/16.
//  Copyright © 2016 Wopata. All rights reserved.
//

import Foundation

public extension NSData {

    public func parseDeviceToken() -> String {
        let tokenChars = UnsafePointer<CChar>(self.bytes)
        var tokenString = ""

        for i in 0..<self.length {
            tokenString += String(format: "%02.2hhx", arguments: [tokenChars[i]])
        }

        return tokenString
    }

}
