//
//  ArrayExtension.swift
//  SwiftHelpers
//
//  Created by David Miotti on 14/01/2015.
//  Copyright (c) 2015 Wopata. All rights reserved.
//

import UIKit

public extension Array {
    ///Loop through each item
    public func each(fn: (Element) -> ()) {
        for item in self {
            fn(item)
        }
    }
}

///Loop through each item of the provided array
///:params: array, the Array to loop from
public func each(array: Array<AnyObject>, fn: ((AnyObject) -> ())) {
    array.each(fn)
}

public func uniq<S : SequenceType, T : Equatable where S.Generator.Element == T>(source: S) -> [T] {
    var buffer = [T]()
    for elem in source {
        if !buffer.contains(elem) {
            buffer.append(elem)
        }
    }
    return buffer
}
