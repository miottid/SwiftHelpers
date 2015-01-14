//
//  IntExtension.swift
//  SwiftHelpers
//
//  Created by David Miotti on 14/01/2015.
//  Copyright (c) 2015 Wopata. All rights reserved.
//

import UIKit

extension Int {
    ///Create a loop and run the provided block `self` times
    public func each(fn: (Int) -> ()) {
        for item in 0..<self {
            fn(item)
        }
    }
}
