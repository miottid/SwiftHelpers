//
//  SHNSDataExtension.swift
//  SwiftHelpers
//
//  Created by David Miotti on 24/06/16.
//  Copyright © 2016 Muxu.Muxu. All rights reserved.
//

import Foundation

public extension Data {

    func parseDeviceToken() -> String {
        let tokenChars = (self as NSData).bytes.bindMemory(to: CChar.self, capacity: self.count)
        var tokenString = ""

        for i in 0..<self.count {
            tokenString += String(format: "%02.2hhx", arguments: [tokenChars[i]])
        }

        return tokenString
    }

}
