//
//  ArrayExtension.swift
//  SwiftHelpers
//
//  Created by David Miotti on 14/01/2015.
//  Copyright (c) 2015 Wopata. All rights reserved.
//

import UIKit

extension Array {
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
