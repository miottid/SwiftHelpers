//
//  ComparisonHelper.swift
//  SwiftHelpers
//
//  Created by David Miotti on 19/01/2015.
//  Copyright (c) 2015 Wopata. All rights reserved.
//

import UIKit

public func == (lhs: Int, rhs: Float) -> Bool {
    return Float(lhs) == rhs
}

public func == (lhs: Float, rhs: Int) -> Bool {
    return rhs == lhs
}

public func < (lhs: Int, rhs: Float) -> Bool {
    return Float(lhs) < rhs
}

public func > (lhs: Int, rhs: Float) -> Bool {
    return Float(lhs) > rhs
}

public func < (lhs: Float, rhs: Int) -> Bool {
    return rhs > lhs
}

public func > (lhs: Float, rhs: Int) -> Bool {
    return rhs < lhs
}

public func >= (lhs: Float, rhs: Int) -> Bool {
    return lhs == rhs || lhs > rhs
}

public func <= (lhs: Float, rhs: Int) -> Bool {
    return lhs == rhs || lhs < rhs
}

public func >= (lhs: Int, rhs: Float) -> Bool {
    return lhs == rhs || lhs > rhs
}

public func <= (lhs: Int, rhs: Float) -> Bool {
    return lhs == rhs || lhs < rhs
}

public func += (inout lhs: Float, rhs: Int) {
    lhs = lhs + Float(rhs)
}

public func -= (inout lhs: Float, rhs: Int) {
    lhs = lhs - Float(rhs)
}
