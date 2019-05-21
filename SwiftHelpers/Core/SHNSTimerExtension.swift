//
//  NSTimerExtension.swift
//  SwiftHelpers
//
//  Created by David Miotti on 14/01/2015.
//  Copyright (c) 2015 Muxu.Muxu. All rights reserved.
//

import Foundation

private class TimerBlock {
    var block: () -> ()
    
    init(block: @escaping () -> ()) {
        self.block = block
    }
    
    @objc dynamic func execute() {
        block()
    }
}

public extension Timer {
    
    convenience init(for timeInterval: TimeInterval, block: @escaping () -> ()) {
        let timerBlock = TimerBlock(block: block)
        self.init(timeInterval: timeInterval, target: timerBlock, selector: #selector(TimerBlock.execute), userInfo: nil, repeats: false)
    }
    
    convenience init(every timeInterval: TimeInterval, block: @escaping () -> ()) {
        let timerBlock = TimerBlock(block: block)
        self.init(timeInterval: timeInterval, target: timerBlock, selector: #selector(TimerBlock.execute), userInfo: nil, repeats: true)
    }
    
    class func schedule(_ timeInterval: TimeInterval, block: @escaping () -> ()) -> Timer {
        let timer = Timer(for: timeInterval, block: block)
        RunLoop.current.add(timer, forMode: RunLoop.Mode.default)
        return timer
    }
    
    class func schedule(every timeInterval: TimeInterval, block: @escaping () -> ()) -> Timer {
        let timer = Timer(every: timeInterval, block: block)
        RunLoop.current.add(timer, forMode: RunLoop.Mode.default)
        return timer
    }
    
    class func scheduled(with interval: TimeInterval, repeats: Bool, handler: @escaping (Timer?) -> Void) -> Timer? {
        let fireDate = interval + CFAbsoluteTimeGetCurrent()
        let repeatInterval = repeats ? interval : 0
        if let timer = CFRunLoopTimerCreateWithHandler(kCFAllocatorDefault, fireDate, repeatInterval, 0, 0, handler) {
            CFRunLoopAddTimer(CFRunLoopGetCurrent(), timer, CFRunLoopMode.commonModes)
            return timer
        }
        return nil
    }
    
}

public extension TimeInterval {
    func every(_ fn: @escaping () -> ()) -> Timer {
        return Timer.schedule(every: self, block: fn)
    }
}

public extension Int {
    func every(_ fn: @escaping () -> ()) -> Timer {
        return Timer.schedule(every: TimeInterval(self), block: fn)
    }
}
