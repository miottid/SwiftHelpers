//
//  UIViewExtension.swift
//  SwiftHelpers
//
//  Created by David Miotti on 14/01/2015.
//  Copyright (c) 2015 Wopata. All rights reserved.
//

import UIKit

public extension UIView {
    ///Helper to quickly add an animation to an UIView (typically for refresh purpose)
    public func addAnimationType(type: String, subType: String?, duration: NSTimeInterval) -> CATransition {
        let transition = CATransition()
        transition.duration = duration
        transition.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        transition.type = type
        transition.subtype = subType
        layer.addAnimation(transition, forKey: NSUUID().UUIDString)
        return transition
    }
}
