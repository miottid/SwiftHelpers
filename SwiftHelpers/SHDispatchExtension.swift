//
//  SHDispatchExtension.swift
//  SwiftHelpers
//
//  Created by David Miotti on 25/04/16.
//  Copyright © 2016 Wopata. All rights reserved.
//

import Foundation

public func dispatch_on_main(_ block: @escaping (Void) -> Void) {
    DispatchQueue.main.async(execute: block)
}

public func dispatch_on(_ queue: DispatchQueue, block: @escaping (Void) -> Void) {
    queue.async(execute: block)
}

public func dispatch_on_background(_ block: @escaping (Void) -> Void) {
    DispatchQueue.global().async(execute: block)
}
