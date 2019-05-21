//
//  SHComparisonHelpers.swift
//  SwiftHelpers
//
//  Created by David Miotti on 27/03/2017.
//  Copyright © 2017 Muxu.Muxu. All rights reserved.
//

import Foundation

// Comparison operators with optionals were removed from the Swift Standard Libary.
func < <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
    switch (lhs, rhs) {
    case let (l?, r?):
        return l < r
    case (nil, _?):
        return true
    default:
        return false
    }
}

// Comparison operators with optionals were removed from the Swift Standard Libary.
func > <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
    switch (lhs, rhs) {
    case let (l?, r?):
        return l > r
    default:
        return rhs < lhs
    }
}
