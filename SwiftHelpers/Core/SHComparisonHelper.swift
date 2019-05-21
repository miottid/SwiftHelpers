//
//  ComparisonHelper.swift
//  SwiftHelpers
//
//  Created by David Miotti on 19/01/2015.
//  Copyright (c) 2015 Muxu.Muxu. All rights reserved.
//

import Foundation
import UIKit

/// Int - Float operations

public func == (lhs: Int, rhs: Float) -> Bool {
    return Float(lhs) == rhs
}

public func == (lhs: Float, rhs: Int) -> Bool {
    return rhs == lhs
}

public func < (lhs: Int, rhs: Float) -> Bool {
    return Float(lhs) < rhs
}

public func < (lhs: Float, rhs: Int) -> Bool {
    return rhs > lhs
}

public func > (lhs: Int, rhs: Float) -> Bool {
    return Float(lhs) > rhs
}

public func > (lhs: Float, rhs: Int) -> Bool {
    return rhs < lhs
}

public func >= (lhs: Float, rhs: Int) -> Bool {
    return lhs == rhs || lhs > rhs
}

public func >= (lhs: Int, rhs: Float) -> Bool {
    return lhs == rhs || lhs > rhs
}

public func <= (lhs: Float, rhs: Int) -> Bool {
    return lhs == rhs || lhs < rhs
}

public func <= (lhs: Int, rhs: Float) -> Bool {
    return lhs == rhs || lhs < rhs
}

public func - (lhs: Float, rhs: Int) -> Float {
    return lhs - Float(rhs)
}

public func + (lhs: Float, rhs: Int) -> Float {
    return lhs + Float(rhs)
}

public func + (lhs: Int, rhs: Float) -> Float {
    return Float(lhs) + rhs
}

public func += (lhs: inout Float, rhs: Int) {
    lhs = lhs + rhs
}

public func -= (lhs: inout Float, rhs: Int) {
    lhs = lhs - rhs
}

public func / (lhs: Float, rhs: Int) -> Float {
    return lhs / Float(rhs)
}

public func * (lhs: Float, rhs: Int) -> Float {
    return lhs * Float(rhs)
}

public func / (lhs: Int, rhs: Float) -> Float {
    return Float(lhs) / rhs
}

/// Double - Float operations

public func == (lhs: Float, rhs: Double) -> Bool {
    return Double(lhs) == rhs
}

public func == (lhs: Double, rhs: Float) -> Bool {
    return rhs == lhs
}

public func < (lhs: Float, rhs: Double) -> Bool {
    return Double(lhs) < rhs
}

public func < (lhs: Double, rhs: Float) -> Bool {
    return rhs > lhs
}

public func > (lhs: Float, rhs: Double) -> Bool {
    return Double(lhs) > rhs
}

public func > (lhs: Double, rhs: Float) -> Bool {
    return rhs < lhs
}

public func >= (lhs: Double, rhs: Float) -> Bool {
    return lhs == rhs || lhs > rhs
}

public func >= (lhs: Float, rhs: Double) -> Bool {
    return lhs == rhs || lhs > rhs
}

public func <= (lhs: Double, rhs: Float) -> Bool {
    return lhs == rhs || lhs < rhs
}

public func <= (lhs: Float, rhs: Double) -> Bool {
    return lhs == rhs || lhs < rhs
}

public func - (lhs: Double, rhs: Float) -> Double {
    return lhs - Double(rhs)
}

public func + (lhs: Double, rhs: Float) -> Double {
    return lhs + Double(rhs)
}

public func + (lhs: Float, rhs: Double) -> Double {
    return Double(lhs) + rhs
}

public func += (lhs: inout Double, rhs: Float) {
    lhs = lhs + rhs
}

public func -= (lhs: inout Double, rhs: Float) {
    lhs = lhs - rhs
}

public func / (lhs: Double, rhs: Float) -> Double {
    return lhs / Double(rhs)
}

public func * (lhs: Double, rhs: Float) -> Double {
    return lhs * Double(rhs)
}

public func / (lhs: Float, rhs: Double) -> Double {
    return Double(lhs) / rhs
}

/// Int - Double operations

public func == (lhs: Int, rhs: Double) -> Bool {
    return Double(lhs) == rhs
}

public func == (lhs: Double, rhs: Int) -> Bool {
    return rhs == lhs
}

public func < (lhs: Int, rhs: Double) -> Bool {
    return Double(lhs) < rhs
}

public func < (lhs: Double, rhs: Int) -> Bool {
    return rhs > lhs
}

public func > (lhs: Int, rhs: Double) -> Bool {
    return Double(lhs) > rhs
}

public func > (lhs: Double, rhs: Int) -> Bool {
    return rhs < lhs
}

public func >= (lhs: Double, rhs: Int) -> Bool {
    return lhs == rhs || lhs > rhs
}

public func >= (lhs: Int, rhs: Double) -> Bool {
    return lhs == rhs || lhs > rhs
}

public func <= (lhs: Double, rhs: Int) -> Bool {
    return lhs == rhs || lhs < rhs
}

public func <= (lhs: Int, rhs: Double) -> Bool {
    return lhs == rhs || lhs < rhs
}

public func - (lhs: Double, rhs: Int) -> Double {
    return lhs - Double(rhs)
}

public func + (lhs: Double, rhs: Int) -> Double {
    return lhs + Double(rhs)
}

public func + (lhs: Int, rhs: Double) -> Double {
    return Double(lhs) + rhs
}

public func += (lhs: inout Double, rhs: Int) {
    lhs = lhs + rhs
}

public func -= (lhs: inout Double, rhs: Int) {
    lhs = lhs - rhs
}

public func / (lhs: Double, rhs: Int) -> Double {
    return lhs / Double(rhs)
}

public func * (lhs: Double, rhs: Int) -> Double {
    return lhs * Double(rhs)
}

public func / (lhs: Int, rhs: Double) -> Double {
    return Double(lhs) / rhs
}

/// Int - CGFloat

public func == (lhs: Int, rhs: CGFloat) -> Bool {
    return CGFloat(lhs) == rhs
}

public func == (lhs: CGFloat, rhs: Int) -> Bool {
    return rhs == lhs
}

public func < (lhs: Int, rhs: CGFloat) -> Bool {
    return CGFloat(lhs) < rhs
}

public func < (lhs: CGFloat, rhs: Int) -> Bool {
    return rhs > lhs
}

public func > (lhs: Int, rhs: CGFloat) -> Bool {
    return CGFloat(lhs) > rhs
}

public func > (lhs: CGFloat, rhs: Int) -> Bool {
    return rhs < lhs
}

public func >= (lhs: CGFloat, rhs: Int) -> Bool {
    return lhs == rhs || lhs > rhs
}

public func >= (lhs: Int, rhs: CGFloat) -> Bool {
    return lhs == rhs || lhs > rhs
}

public func <= (lhs: CGFloat, rhs: Int) -> Bool {
    return lhs == rhs || lhs < rhs
}

public func <= (lhs: Int, rhs: CGFloat) -> Bool {
    return lhs == rhs || lhs < rhs
}

public func - (lhs: CGFloat, rhs: Int) -> CGFloat {
    return lhs - CGFloat(rhs)
}

public func + (lhs: CGFloat, rhs: Int) -> CGFloat {
    return lhs + CGFloat(rhs)
}

public func + (lhs: Int, rhs: CGFloat) -> CGFloat {
    return CGFloat(lhs) + rhs
}

public func += (lhs: inout CGFloat, rhs: Int) {
    lhs = lhs + rhs
}

public func -= (lhs: inout CGFloat, rhs: Int) {
    lhs = lhs - rhs
}

public func / (lhs: CGFloat, rhs: Int) -> CGFloat {
    return lhs / CGFloat(rhs)
}

public func * (lhs: CGFloat, rhs: Int) -> CGFloat {
    return lhs * CGFloat(rhs)
}

public func * (lhs: Int, rhs: CGFloat) -> CGFloat {
    return rhs * lhs
}

public func / (lhs: Int, rhs: CGFloat) -> CGFloat {
    return CGFloat(lhs) / rhs
}

public extension Comparable {
    func ranged(between v1: Self, and v2: Self) -> Self {
        if v1 < v2 {
            return max(v1, min(v2, self))
        }
        return max(v2, min(v1, self))
    }
}
