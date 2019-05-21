//
//  SHDegreesToRadiansExtension.swift
//  SwiftHelpers
//
//  Created by David Miotti on 03/06/16.
//  Copyright © 2016 Muxu.Muxu. All rights reserved.
//

import Foundation
import UIKit

public extension Int {
    var degreesToRadians: Double { return Double(self) * Double.pi / 180 }
    var radiansToDegrees: Double { return Double(self) * 180 / Double.pi }
}

public extension Double {
    var degreesToRadians: Double { return self * Double.pi / 180 }
    var radiansToDegrees: Double { return self * 180 / Double.pi }
}

public extension CGFloat {
    var doubleValue:      Double  { return Double(self) }
    var degreesToRadians: CGFloat { return CGFloat(doubleValue * Double.pi / 180) }
    var radiansToDegrees: CGFloat { return CGFloat(doubleValue * 180 / Double.pi) }
}

public extension Float  {
    var doubleValue:      Double { return Double(self) }
    var degreesToRadians: Float  { return Float(doubleValue * Double.pi / 180) }
    var radiansToDegrees: Float  { return Float(doubleValue * 180 / Double.pi) }
}
