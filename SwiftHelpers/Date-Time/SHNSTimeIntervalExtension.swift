//
//  NSTimeIntervalExtension.swift
//  SwiftHelpers
//
//  Created by David Miotti on 14/01/2015.
//  Copyright (c) 2015 Muxu.Muxu. All rights reserved.
//

import Foundation

///dispatch_after with seconds
public func delay(_ timeInterval: TimeInterval, closure:@escaping ()->()) {
    return timeInterval.delay(closure)
}

public extension TimeInterval {
    ///Perform the given block after a delay
    public func delay(_ closure:@escaping ()->()) {
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + self, execute: closure)
    }
}
