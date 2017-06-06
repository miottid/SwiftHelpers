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
    
    public func split(forChunkSize chunkSize: Int) -> [[Element]] {
        return stride(from: 0, to: self.count, by: chunkSize).map({ (startIndex) -> [Element] in
            let endIndex = (startIndex.advanced(by: chunkSize) > self.count) ? self.count-startIndex : chunkSize
            return Array(self[startIndex..<startIndex.advanced(by: endIndex)])
        })
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

extension MutableCollection where Index == Int {
    /// Shuffle the elements of `self` in-place.
    mutating func shuffle() {
        // empty and single-element collections don't shuffle
        if count < 2 { return }
        
        for i in startIndex ..< endIndex - 1 {
            let j = Int(arc4random_uniform(UInt32(endIndex - i))) + i
            swapAt(i, j)
        }
    }
}

extension Array {
    public var random: Element {
        return chooseOne
    }
    
    func random(n: Int) -> [Element] {
        return choose(n: n)
    }
    
    public var chooseOne: Element {
        return self[Int(arc4random_uniform(UInt32(count)))]
    }
    
    func choose(n: Int) -> [Element] {
        var shuffled = self
        shuffled.shuffle()
        return Array(shuffled.prefix(n))
    }
}
