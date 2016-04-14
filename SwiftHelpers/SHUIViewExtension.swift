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
    
    // Helper to add rounded corners to any side you want and with a specified radius
    public func addRound(toCorners corners:UIRectCorner, withRadius radius: CGFloat) {
        let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.CGPath
        self.layer.mask = mask
    }
    
    // Pick color from a 1x1 pixel at a given location
    public func pickColor(atPoint point: CGPoint) -> UIColor {
        var pixel: [CUnsignedChar] = [0, 0, 0, 0]
        
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        let bitmapInfo = CGBitmapInfo(rawValue: CGImageAlphaInfo.PremultipliedLast.rawValue)
        let bitsPerComponent = 8
        let bytesPerRow = 4
        let context = CGBitmapContextCreate(&pixel, 1, 1, bitsPerComponent, bytesPerRow, colorSpace, bitmapInfo.rawValue)
        
        CGContextTranslateCTM(context, -point.x, -point.y)
        
        self.layer.renderInContext(context!)
        
        let red = CGFloat(pixel[0]) / 255.0
        let green = CGFloat(pixel[1]) / 255.0
        let blue = CGFloat(pixel[2]) / 255.0
        let alpha = CGFloat(pixel[3]) / 255.0
        
        return UIColor(red: red, green: green, blue: blue, alpha: alpha)
    }
    
}
