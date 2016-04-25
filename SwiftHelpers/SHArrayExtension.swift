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


public extension Array {
    public var shuffle: [Element] {
        var elements = self
        for index in indices.dropLast() {
            guard
                case let swapIndex = Int(arc4random_uniform(UInt32(count - index))) + index
                where swapIndex != index else { continue }
            swap(&elements[index], &elements[swapIndex])
        }
        return elements
    }
    
    public mutating func shuffled() {
        for index in indices.dropLast() {
            guard
                case let swapIndex = Int(arc4random_uniform(UInt32(count - index))) + index
                where swapIndex != index
                else { continue }
            swap(&self[index], &self[swapIndex])
        }
    }
    
    public var chooseOne: Element {
        return self[Int(arc4random_uniform(UInt32(count)))]
    }
    
    public func choose(n: Int) -> [Element] {
        return Array(shuffle.prefix(n))
    }
}