//
//  NSTimeIntervalExtension.swift
//  SwiftHelpers
//
//  Created by David Miotti on 14/01/2015.
//  Copyright (c) 2015 Wopata. All rights reserved.
//

import Foundation

///dispatch_after with seconds
public func delay(timeInterval: NSTimeInterval, closure:()->()) {
    return timeInterval.delay(closure)
}

public extension NSTimeInterval {
    ///Perform the given block after a delay
    public func delay(closure:()->()) {
        dispatch_after(
            dispatch_time(
                DISPATCH_TIME_NOW,
                Int64(self * Double(NSEC_PER_SEC))
            ),
            dispatch_get_main_queue(), closure)
    }
}
