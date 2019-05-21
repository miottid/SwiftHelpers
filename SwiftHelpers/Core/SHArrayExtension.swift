//
//  ArrayExtension.swift
//  SwiftHelpers
//
//  Created by David Miotti on 14/01/2015.
//  Copyright (c) 2015 Muxu.Muxu. All rights reserved.
//

import Foundation

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

public func uniq<S : Sequence, T : Hashable>(_ source: S) -> [T] where S.Iterator.Element == T {
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

public extension Array {
    ///Loop through each item
    func each(_ fn: (Element) -> ()) {
        for item in self {
            fn(item)
        }
    }

    func split(forChunkSize chunkSize: Int) -> [[Element]] {
        return stride(from: 0, to: self.count, by: chunkSize).map({ (startIndex) -> [Element] in
            let endIndex = (startIndex.advanced(by: chunkSize) > self.count) ? self.count-startIndex : chunkSize
            return Array(self[startIndex..<startIndex.advanced(by: endIndex)])
        })
    }

    var shuffled: Array {
        return shuffle()
    }

    func shuffle() -> Array {
        var elements = self
        for index in indices.dropLast() {
            guard
                case let swapIndex = Int(arc4random_uniform(UInt32(count - index))) + index,
                swapIndex != index else { continue }
            elements.swapAt(index, swapIndex)
        }
        return elements
    }

    var random: Element {
        return chooseOne
    }

    func random(n: Int) -> [Element] {
        return choose(n: n)
    }

    var chooseOne: Element {
        return self[Int(arc4random_uniform(UInt32(count)))]
    }

    func choose(n: Int) -> [Element] {
        return Array(shuffled.prefix(n))
    }
}
