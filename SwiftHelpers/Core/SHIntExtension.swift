//
//  IntExtension.swift
//  SwiftHelpers
//
//  Created by David Miotti on 14/01/2015.
//  Copyright (c) 2015 Muxu.Muxu. All rights reserved.
//

import Foundation

public extension Int {
    ///Create a loop and run the provided block `self` times
    func each(_ fn: (Int) -> ()) {
        for item in 0..<self {
            fn(item)
        }
    }
    
    ///Loop from 0 to self and apply the function passed in parameter
    func map(_ fn: (Int) -> AnyObject) -> [AnyObject] {
        var objects = [AnyObject]()
        for item in 0..<self {
            objects.append(fn(item))
        }
        return objects
    }
    
    ///Create a random num Int
    ///
    ///- parameter lower: The lower boundary
    ///- parameter upper: The higher boundary
    ///
    ///- returns: A Random Int between lower and upper
    static func random(lower: Int, upper: Int) -> Int {
        let value = upper - lower + 1
        let rand = Int(arc4random_uniform(UInt32(value)))
        return lower + rand
    }
}
