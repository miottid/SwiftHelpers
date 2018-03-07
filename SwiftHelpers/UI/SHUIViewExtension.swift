//
//  UIViewExtension.swift
//  SwiftHelpers
//
//  Created by David Miotti on 14/01/2015.
//  Copyright (c) 2015 Muxu.Muxu. All rights reserved.
//

#if os(iOS)

import UIKit

public extension UIView {

    /**
     Layouts the received if needed, animated and with an optional completion closure

     - parameter duration:   The duration of the animation layout. A duration of 0 or less calls layoutIfNeeded()
     - parameter completion: The closure to execute after the animation has ended. Will be called even if duration <= 0
     */
    func layoutIfNeeded(
        animationDuration duration: TimeInterval,
                          delay: TimeInterval = 0,
                          options: UIViewAnimationOptions = UIViewAnimationOptions(rawValue: 0),
                          completion: ((Bool) -> Void)? = nil) {

        guard duration > 0 else {
            layoutIfNeeded()
            completion?(true)
            return
        }

        UIView.animate(withDuration: duration, delay: delay, options: options, animations: {
            self.layoutIfNeeded()
        }, completion: completion)
    }

    ///Helper to quickly add an animation to an UIView (typically for refresh purpose)
    @discardableResult public func addAnimation(type: String, subType: String?, duration: TimeInterval) -> CATransition {
        let transition = CATransition()
        transition.duration = duration
        transition.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        transition.type = type
        transition.subtype = subType
        layer.add(transition, forKey: UUID().uuidString)
        return transition
    }
    
    // Helper to add rounded corners to any side you want and with a specified radius
    public func addRound(to corners:UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        self.layer.mask = mask
    }
    
    // Pick color from a 1x1 pixel at a given location
    public func pickColor(at point: CGPoint) -> UIColor {
        var pixel: [CUnsignedChar] = [0, 0, 0, 0]
        
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        let bitmapInfo = CGBitmapInfo(rawValue: CGImageAlphaInfo.premultipliedLast.rawValue)
        let bitsPerComponent = 8
        let bytesPerRow = 4
        let context = CGContext(data: &pixel, width: 1, height: 1, bitsPerComponent: bitsPerComponent, bytesPerRow: bytesPerRow, space: colorSpace, bitmapInfo: bitmapInfo.rawValue)
        
        context?.translateBy(x: -point.x, y: -point.y)
        
        self.layer.render(in: context!)
        
        let red = CGFloat(pixel[0]) / 255.0
        let green = CGFloat(pixel[1]) / 255.0
        let blue = CGFloat(pixel[2]) / 255.0
        let alpha = CGFloat(pixel[3]) / 255.0
        
        return UIColor(red: red, green: green, blue: blue, alpha: alpha)
    }

    /// Allows to instantiate a view from a nib name
    /// Can be used like this :
    /// let view: MyView = .fromNib(named: "MyView")
    /// If the nib name is the same as the classe's name, it can be ommited.
    public class func fromNib<T : UIView>(named name: String? = nil) -> T {
        let className = NSStringFromClass(self).components(separatedBy: ".").last!
        let name = (name ?? className)
        return Bundle.main.loadNibNamed(name, owner: nil, options: nil)?.first as! T
    }
    
}

#endif
