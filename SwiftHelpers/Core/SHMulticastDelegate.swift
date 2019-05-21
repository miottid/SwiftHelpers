//
//  SHMulticastDelegate.swift
//  SwiftHelpers
//
//  Created by David Miotti on 23/05/2018.
//  Copyright © 2018 Wopata. All rights reserved.
//

import Foundation

open class SHMulticastDelegate<T> {
    private let delegates: NSHashTable<AnyObject> = NSHashTable.weakObjects()

    public init() {}

    open func add(delegate: T) {
        delegates.add(delegate as AnyObject)
    }

    open func remove(delegate: T) {
        for oneDelegate in delegates.allObjects.reversed() {
            if oneDelegate === delegate as AnyObject {
                delegates.remove(oneDelegate)
            }
        }
    }

    open func invoke(invocation: (T) -> ()) {
        for delegate in delegates.allObjects.reversed() {
            invocation(delegate as! T)
        }
    }
}

func += <T: AnyObject> (left: SHMulticastDelegate<T>, right: T) {
    left.add(delegate: right)
}

func -= <T: AnyObject> (left: SHMulticastDelegate<T>, right: T) {
    left.remove(delegate: right)
}
