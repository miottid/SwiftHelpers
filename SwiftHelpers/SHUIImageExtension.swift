//
//  UIImageExtension.swift
//  AddMedica
//
//  Created by Remi Santos on 18/02/15.
//  Copyright (c) 2015 Wopata. All rights reserved.
//

import UIKit

public extension UIImage {
    public convenience init?(localizedName:String) {
        let lang = NSLocale.preferredLanguages()[0] 
        var imageName = localizedName + "-" + lang
        if UIImage(named: imageName) == nil {
            imageName = localizedName + "-" + "en"
        }
        self.init(named:imageName)
    }

    public convenience init?(localizedName:String, ofLang lang: String) {
        var imageName = localizedName + "-" + lang
        if UIImage(named: imageName) == nil {
            imageName = localizedName + "-" + "en"
        }
        self.init(named:imageName)
    }
    
    public func tintWithColor(color:UIColor) -> UIImage {
        
        UIGraphicsBeginImageContextWithOptions(self.size, false, self.scale)
        let context = UIGraphicsGetCurrentContext()
        CGContextTranslateCTM(context, 0, self.size.height)
        CGContextScaleCTM(context, 1.0, -1.0)
        CGContextSetBlendMode(context, CGBlendMode.Normal)
        let rect = CGRectMake(0, 0, self.size.width, self.size.height)
        CGContextClipToMask(context, rect, self.CGImage)
        color.setFill()
        CGContextFillRect(context, rect)
        
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext();
        return newImage;
    }
    
    public class func imageWithColor(color: UIColor, size: CGSize) -> UIImage {
        let rect = CGRect(origin: CGPoint.zero, size: size)
        
        UIGraphicsBeginImageContext(rect.size)
        
        let context = UIGraphicsGetCurrentContext()
        
        CGContextSetFillColorWithColor(context, color.CGColor)
        CGContextFillRect(context, rect)
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        
        UIGraphicsEndImageContext()
        
        return image
    }
    
    // Pick color from a 1x1 pixel at a given location
    public func pickColor(atLocation point: CGPoint) -> UIColor {
        let pixelData = CGDataProviderCopyData(CGImageGetDataProvider(self.CGImage))
        let data = CFDataGetBytePtr(pixelData)
        
        let bytesPerRow = 4
        let pixelInfo: Int = ((Int(size.width * scale) * Int(point.y * scale)) + Int(point.x * scale)) * bytesPerRow
        
        let red = CGFloat(data[pixelInfo]) / 255.0
        let green = CGFloat(data[pixelInfo + 1]) / 255.0
        let blue = CGFloat(data[pixelInfo + 2]) / 255.0
        let alpha = CGFloat(data[pixelInfo + 3]) / 255.0
        
        return UIColor(red: red, green: green, blue: blue, alpha: alpha)
    }
    
}
