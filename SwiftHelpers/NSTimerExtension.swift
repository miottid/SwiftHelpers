//
//  NSTimerExtension.swift
//  SwiftHelpers
//
//  Created by David Miotti on 14/01/2015.
//  Copyright (c) 2015 Wopata. All rights reserved.
//

import UIKit

private class TimerBlock {
    var block: () -> ()
    
    init(block: () -> ()) {
        self.block = block
    }
    
    dynamic func execute() {
        block()
    }
}

extension NSTimer {
    
    public convenience init(_ timeInterval: NSTimeInterval, block: () -> ()) {
        let timerBlock = TimerBlock(block: block)
        self.init(timeInterval: timeInterval, target: timerBlock, selector: "execute", userInfo: nil, repeats: false)
    }
    
    public convenience init(every timeInterval: NSTimeInterval, block: () -> ()) {
        let timerBlock = TimerBlock(block: block)
        self.init(timeInterval: timeInterval, target: timerBlock, selector: "execute", userInfo: nil, repeats: true)
    }
    
    public class func schedule(timeInterval: NSTimeInterval, block: () -> ()) -> NSTimer {
        let timer = NSTimer(timeInterval, block)
        NSRunLoop.currentRunLoop().addTimer(timer, forMode: NSDefaultRunLoopMode)
        return timer
    }
    
    public class func schedule(every timeInterval: NSTimeInterval, block: () -> ()) -> NSTimer {
        let timer = NSTimer(every: timeInterval, block)
        NSRunLoop.currentRunLoop().addTimer(timer, forMode: NSDefaultRunLoopMode)
        return timer
    }
    
}

extension NSTimeInterval {
    public func every(fn: () -> ()) -> NSTimer {
        return NSTimer.schedule(every: self, block: fn)
    }
}

extension Int {
    public func every(fn: () -> ()) -> NSTimer {
        return NSTimer.schedule(every: NSTimeInterval(self), block: fn)
    }
}
