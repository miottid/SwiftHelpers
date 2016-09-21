//
//  ArrayExtension.swift
//  SwiftHelpers
//
//  Created by David Miotti on 14/01/2015.
//  Copyright (c) 2015 Wopata. All rights reserved.
//

import Foundation

public extension Array {
    ///Loop through each item
    public func each(_ fn: (Element) -> ()) {
        for item in self {
            fn(item)
        }
    }
}

///Loop through each item of the provided array
///:params: array, the Array to loop from
public func each(_ array: Array<AnyObject>, fn: ((AnyObject) -> ())) {
    array.each(fn)
}

public func uniq<S : Sequence, T : Equatable>(_ source: S) -> [T] where S.Iterator.Element == T {
    var buffer = [T]()
    for elem in source {
        if !buffer.contains(elem) {
            buffer.append(elem)
        }
    }
    return buffer
}

func uniq<S : Sequence, T : Hashable>(_ source: S) -> [T] where S.Iterator.Element == T {
    var buffer = [T]()
    var added = Set<T>()
    for elem in source {
        if !added.contains(elem) {
            buffer.append(elem)
            added.insert(elem)
        }
    }
    return buffer
}
