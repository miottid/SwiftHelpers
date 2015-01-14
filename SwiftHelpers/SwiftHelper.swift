//
//  SwiftHelper.swift
//  SwiftHelper
//
//  Created by David Miotti on 06/01/2015.
//  Copyright (c) 2015 Wopata. All rights reserved.
//

import UIKit

///dispatch_after with seconds
public func delay(delay: NSTimeInterval, closure:()->()) {
    dispatch_after(
        dispatch_time(
            DISPATCH_TIME_NOW,
            Int64(delay * Double(NSEC_PER_SEC))
        ),
        dispatch_get_main_queue(), closure)
}

///Returns a localized string, using the main bundle if one is not specified.
public func L(key: String) -> String {
    return NSLocalizedString(key, comment: "")
}

///Helper for `println` function with a filter for use in debug mode only
public func P(string: String) {
    #if RELEASE
    #else
        println(string)
    #endif
}

public func each(array: NSArray, fn: ((AnyObject) -> ())) {
    for item in array {
        fn(item)
    }
}

///Get the current version of the app
public func appVersion() -> String {
    let mainBundle = NSBundle.mainBundle()
    if let bundleDictionary = mainBundle.infoDictionary {
        if let shortVersion = bundleDictionary["CFBundleShortVersionString"] as? String {
            if let bundleVersion = bundleDictionary["CFBundleVersion"] as? String {
                return NSString(format: "%@.%@", shortVersion, bundleVersion)
            }
        }
    }
    
    return ""
}

// MARK: - Iteration helper

extension Array {
    ///Loop through each item
    func each(fn: (T) -> ()) {
        for item in self {
            fn(item)
        }
    }
}

extension NSTimeInterval {
    ///Perform the given block after a delay
    public func delay(closure:()->()) {
        dispatch_after(
            dispatch_time(
                DISPATCH_TIME_NOW,
                Int64(self * Double(NSEC_PER_SEC))
            ),
            dispatch_get_main_queue(), closure)
    }
}

extension Int {
    ///Create a loop and run the provided block `self` times
    public func each(fn: (Int) -> ()) {
        for item in 0..<self {
            fn(item)
        }
    }
}

extension UIView {
    ///Helper to quickly add an animation to an UIView (typically for refresh purpose)
    public func addAnimationType(type: String, duration: NSTimeInterval) -> CATransition {
        let transition = CATransition()
        transition.duration = duration
        transition.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        transition.type = type
        return transition
    }
}

///Mix two colors
public func blendColor(firstColor: UIColor, secondColor: UIColor, alpha: Float) -> UIColor {
    let boundAlpha = min(1.0, max(0.0, alpha))
    let beta = 1.0 - boundAlpha
    var r1: CGFloat = 0; var g1: CGFloat = 0; var b1: CGFloat = 0; var a1: CGFloat = 0
    firstColor.getRed(&r1, green: &g1, blue: &b1, alpha: &a1)
    var r2: CGFloat = 0; var g2: CGFloat = 0; var b2: CGFloat = 0; var a2: CGFloat = 0
    secondColor.getRed(&r2, green: &g2, blue: &b2, alpha: &a2)
    let r = Float(r1) * beta + Float(r2) * boundAlpha
    let g = Float(g1) * beta + Float(g2) * boundAlpha
    let b = Float(b1) * beta + Float(b2) * boundAlpha
    return UIColor(red: CGFloat(r), green: CGFloat(g), blue: CGFloat(b), alpha: 1.0)
}

///Create a color from hexa
///:returns: UIColor created with the hexa
public func UIColorFromHex(rgbValue: UInt32) -> UIColor {
    let red = CGFloat((rgbValue & 0xFF0000) >> 16)/256.0
    let green = CGFloat((rgbValue & 0xFF00) >> 8)/256.0
    let blue = CGFloat(rgbValue & 0xFF)/256.0
    return UIColor(red:red, green:green, blue:blue, alpha:1.0)
}

extension NSDateFormatter {
    ///A convenience NSDateFormatter initializer
    public convenience init(dateFormat: String) {
        self.init()
        self.dateFormat = dateFormat
    }
}

public enum DeviceResolution {
    case Unknown //Handle future iOS screen devices
    case PhoneStandard
    case PhoneRetina4
    case PhoneRetina5
    case PadStandard
    case PadRetina
}

///Helper for accessing the device resolution, it may also help checking the kind of device
public func deviceResolution() -> DeviceResolution {
    var resolution: DeviceResolution = .Unknown
    let mainScreen = UIScreen.mainScreen()
    let scale = mainScreen.scale
    let pixelHeight = CGRectGetHeight(mainScreen.bounds) * scale
    if UIDevice.currentDevice().userInterfaceIdiom == .Phone {
        if scale == 2.0 {
            if pixelHeight == 960.0 {
                resolution = .PhoneRetina4
            } else if pixelHeight == 1136.0 {
                resolution = .PhoneRetina5
            }
        } else if scale == 1.0 && pixelHeight == 480.0 {
            resolution = .PhoneStandard
        }
    } else {
        if scale == 2.0 && pixelHeight == 2048.0 {
            resolution = .PadRetina
        } else {
            resolution = .PadStandard
        }
    }
    return resolution
}
