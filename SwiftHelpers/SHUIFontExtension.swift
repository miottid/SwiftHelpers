//
//  UIFontExtension.swift
//  SwiftHelpers
//
//  Created by David Miotti on 16/06/2015.
//  Copyright (c) 2015 Wopata. All rights reserved.
//

#if os(iOS)

import UIKit

public extension UIFont {
    
    public func kernWithTracking(tracking: CGFloat) -> CGFloat {
        return tracking * self.pointSize / 1000
    }
}

#endif
