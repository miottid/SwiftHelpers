//
//  TimeInterval+Convertion.swift
//  SwiftHelpers
//
//  Created by David Miotti on 26/03/2017.
//  Copyright © 2017 Muxu.Muxu. All rights reserved.
//

import Foundation
import UIKit

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
    
    public var number: NSNumber {
        return NSNumber(value: self)
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
    
    public var number: NSNumber {
        return NSNumber(value: self)
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
    
    public var number: NSNumber {
        return NSNumber(value: self)
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
    
    public var number: NSNumber {
        return NSNumber(value: self.toFloat)
    }
}

public extension Bool {
    public var number: NSNumber {
        return NSNumber(value: self)
    }
}
