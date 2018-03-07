//
//  SHFloatExtension.swift
//  SwiftHelpers
//
//  Created by David Miotti on 10/05/16.
//  Copyright © 2016 Muxu.Muxu. All rights reserved.
//

import Foundation
import UIKit

public extension Float {
    public var cleanValue: String {
        return Double(self).cleanValue
    }
}

public extension CGFloat {
    public var cleanValue: String {
        return Double(self).cleanValue
    }
}

public extension Double {
    public var cleanValue: String {
        return self.truncatingRemainder(dividingBy: 1) == 0 ? String(format: "%.0f", self) : String(self)
    }
}
