//
//  SHDispatchExtension.swift
//  SwiftHelpers
//
//  Created by David Miotti on 25/04/16.
//  Copyright © 2016 Wopata. All rights reserved.
//

import Foundation

public func dispatch_on_main(block: Void -> Void) {
    dispatch_async(dispatch_get_main_queue(), block)
}

public func dispatch_on(queue: dispatch_queue_t, block: Void -> Void) {
    dispatch_async(queue, block)
}

public func dispatch_on_background(block: Void -> Void) {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), block)
}
