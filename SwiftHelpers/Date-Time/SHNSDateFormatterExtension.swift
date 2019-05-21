//
//  NSDateFormatterExtension.swift
//  SwiftHelpers
//
//  Created by David Miotti on 14/01/2015.
//  Copyright (c) 2015 Muxu.Muxu. All rights reserved.
//

import Foundation

public extension DateFormatter {
    ///A convenience NSDateFormatter initializer
    convenience init(dateFormat: String) {
        self.init()
        self.dateFormat = dateFormat
    }
}
