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
    var toInt: Int {
        return Int(self)
    }
    
    var toFloat: Float {
        return Float(self)
    }
    
    var toCGFloat: CGFloat {
        return CGFloat(self)
    }
    
    var number: NSNumber {
        return NSNumber(value: self)
    }
}

public extension Int {
    var toDouble: Double {
        return Double(self)
    }
    
    var toFloat: Float {
        return Float(self)
    }
    
    var toCGFloat: CGFloat {
        return CGFloat(self)
    }
    
    var number: NSNumber {
        return NSNumber(value: self)
    }
}

public extension Float {
    var toDouble: Double {
        return Double(self)
    }
    
    var toInt: Int {
        return Int(self)
    }
    
    var toCGFloat: CGFloat {
        return CGFloat(self)
    }
    
    var number: NSNumber {
        return NSNumber(value: self)
    }
}

public extension CGFloat {
    var toDouble: Double {
        return Double(self)
    }
    
    var toInt: Int {
        return Int(self)
    }
    
    var toFloat: Float {
        return Float(self)
    }
    
    var number: NSNumber {
        return NSNumber(value: self.toFloat)
    }
}

public extension Bool {
    var number: NSNumber {
        return NSNumber(value: self)
    }
}
