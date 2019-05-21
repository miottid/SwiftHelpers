//
//  UIFontExtension.swift
//  SwiftHelpers
//
//  Created by David Miotti on 16/06/2015.
//  Copyright (c) 2015 Muxu.Muxu. All rights reserved.
//

#if os(iOS)

import UIKit

public extension UIFont {
    
    func kern(tracking: CGFloat) -> CGFloat {
        return tracking * self.pointSize / 1000
    }
}

#endif
