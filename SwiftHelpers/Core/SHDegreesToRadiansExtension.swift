//
//  SHDegreesToRadiansExtension.swift
//  SwiftHelpers
//
//  Created by David Miotti on 03/06/16.
//  Copyright © 2016 Wopata. All rights reserved.
//

import Foundation

public extension Int {
    public var degreesToRadians: Double { return Double(self) * M_PI / 180 }
    public var radiansToDegrees: Double { return Double(self) * 180 / M_PI }
}

public extension Double {
    public var degreesToRadians: Double { return self * M_PI / 180 }
    public var radiansToDegrees: Double { return self * 180 / M_PI }
}

public extension CGFloat {
    public var doubleValue:      Double  { return Double(self) }
    public var degreesToRadians: CGFloat { return CGFloat(doubleValue * M_PI / 180) }
    public var radiansToDegrees: CGFloat { return CGFloat(doubleValue * 180 / M_PI) }
}

public extension Float  {
    public var doubleValue:      Double { return Double(self) }
    public var degreesToRadians: Float  { return Float(doubleValue * M_PI / 180) }
    public var radiansToDegrees: Float  { return Float(doubleValue * 180 / M_PI) }
}