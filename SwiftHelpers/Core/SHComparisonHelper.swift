//
//  ComparisonHelper.swift
//  SwiftHelpers
//
//  Created by David Miotti on 19/01/2015.
//  Copyright (c) 2015 Wopata. All rights reserved.
//

import Foundation

public extension Comparable {
    public func ranged(between v1: Self, and v2: Self) -> Self {
        if v1 < v2 {
            return max(v1, min(v2, self))
        }
        return max(v2, min(v1, self))
    }
}

