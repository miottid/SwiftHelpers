//
//  IntExtension.swift
//  SwiftHelpers
//
//  Created by David Miotti on 14/01/2015.
//  Copyright (c) 2015 Wopata. All rights reserved.
//

import UIKit

extension Int {
    ///Create a loop and run the provided block `self` times
    public func each(fn: (Int) -> ()) {
        for item in 0..<self {
            fn(item)
        }
    }
    
    ///Loop from 0 to self and apply the function passed in parameter
    public func map(fn: (Int) -> AnyObject) -> [AnyObject] {
        var objects = [AnyObject]()
        for item in 0..<self {
            objects.append(fn(item))
        }
        return objects
    }
    
    ///Create a random num Int
    ///
    ///:param: lower The lower boundary
    ///:param: upper The higher boundary
    ///
    ///:returns: A Random Int between lower and upper
    public static func random (#lower: Int, upper: Int) -> Int {
        let value = upper - lower + 1
        let rand = Int(arc4random_uniform(UInt32(value)))
        return lower + rand
    }
}
