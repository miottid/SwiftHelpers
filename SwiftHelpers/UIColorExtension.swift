//
//  UIColorExtension.swift
//  SwiftHelpers
//
//  Created by David Miotti on 14/01/2015.
//  Copyright (c) 2015 Wopata. All rights reserved.
//

import UIKit

///Mix two colors
public func blendColor(firstColor: UIColor, secondColor: UIColor, alpha: Float) -> UIColor {
    return firstColor.blendWithColor(secondColor, alpha: alpha)
}

///Create a color from hexa
///:returns: UIColor created with the hexa
public func UIColorFromHex(rgbValue: UInt32) -> UIColor {
    return UIColor(rgbValue: rgbValue)
}

public extension UIColor {
    
    public convenience init(rgbValue: UInt32) {
        let red = CGFloat((rgbValue & 0xFF0000) >> 16)/256.0
        let green = CGFloat((rgbValue & 0xFF00) >> 8)/256.0
        let blue = CGFloat(rgbValue & 0xFF)/256.0
        self.init(red:red, green:green, blue:blue, alpha:1.0)
    }
    
    public convenience init(r: CGFloat, g: CGFloat, b: CGFloat, a: CGFloat) {
        self.init(red:r/255.0, green:g/255.0, blue:b/255.0, alpha:a)
    }
    
    public func blendWithColor(color: UIColor, alpha: Float) -> UIColor {
        let boundAlpha = min(1.0, max(0.0, alpha))
        let beta = 1.0 - boundAlpha
        var r1: CGFloat = 0; var g1: CGFloat = 0; var b1: CGFloat = 0; var a1: CGFloat = 0
        self.getRed(&r1, green: &g1, blue: &b1, alpha: &a1)
        var r2: CGFloat = 0; var g2: CGFloat = 0; var b2: CGFloat = 0; var a2: CGFloat = 0
        color.getRed(&r2, green: &g2, blue: &b2, alpha: &a2)
        let r = Float(r1) * beta + Float(r2) * boundAlpha
        let g = Float(g1) * beta + Float(g2) * boundAlpha
        let b = Float(b1) * beta + Float(b2) * boundAlpha
        return UIColor(red: CGFloat(r), green: CGFloat(g), blue: CGFloat(b), alpha: 1.0)
    }
    
    typealias RGBComponents = (red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat)
    typealias HSBComponents = (hue: CGFloat, saturation: CGFloat, brightness: CGFloat, alpha: CGFloat)
    
    var rgbComponents:RGBComponents {
        var c:RGBComponents = (0,0,0,0)
        
        if getRed(&c.red, green: &c.green, blue: &c.blue, alpha: &c.alpha) {
            return c
        }
        
        return (0,0,0,0)
    }
    
    var cssRGBA:String {
        return String(format: "rgba(%d,%d,%d, %.02f)", Int(rgbComponents.red * 255), Int(rgbComponents.green * 255), Int(rgbComponents.blue * 255), Float(rgbComponents.alpha))
    }
    var hexRGB:String {
        return String(format: "#%02x%02x%02x", Int(rgbComponents.red * 255), Int(rgbComponents.green * 255), Int(rgbComponents.blue * 255))
    }
    var hexRGBA:String {
        return String(format: "#%02x%02x%02x%02x", Int(rgbComponents.red * 255), Int(rgbComponents.green * 255), Int(rgbComponents.blue * 255), Int(rgbComponents.alpha * 255) )
    }
    
    var hsbComponents:HSBComponents {
        var c:HSBComponents = (0,0,0,0)
        
        if getHue(&c.hue, saturation: &c.saturation, brightness: &c.brightness, alpha: &c.alpha) {
            return c
        }
        
        return (0,0,0,0)
    }
    
}
