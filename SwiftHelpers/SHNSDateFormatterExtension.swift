//
//  NSDateFormatterExtension.swift
//  SwiftHelpers
//
//  Created by David Miotti on 14/01/2015.
//  Copyright (c) 2015 Wopata. All rights reserved.
//

import Foundation

public extension NSDateFormatter {
    ///A convenience NSDateFormatter initializer
    public convenience init(dateFormat: String) {
        self.init()
        self.dateFormat = dateFormat
    }
}
