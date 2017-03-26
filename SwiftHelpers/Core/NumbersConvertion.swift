//
//  TimeInterval+Convertion.swift
//  SwiftHelpers
//
//  Created by David Miotti on 26/03/2017.
//  Copyright © 2017 Wopata. All rights reserved.
//

import Foundation

public extension TimeInterval {
    public var toInt: Int {
        return Int(self)
    }
    
    public var toFloat: Float {
        return Float(self)
    }
    
    public var toCGFloat: CGFloat {
        return CGFloat(self)
    }
}

public extension Int {
    public var toDouble: Double {
        return Double(self)
    }
    
    public var toFloat: Float {
        return Float(self)
    }
    
    public var toCGFloat: CGFloat {
        return CGFloat(self)
    }
}

public extension Float {
    public var toDouble: Double {
        return Double(self)
    }
    
    public var toInt: Int {
        return Int(self)
    }
    
    public var toCGFloat: CGFloat {
        return CGFloat(self)
    }
}

public extension CGFloat {
    public var toDouble: Double {
        return Double(self)
    }
    
    public var toInt: Int {
        return Int(self)
    }
    
    public var toFloat: Float {
        return Float(self)
    }
}
