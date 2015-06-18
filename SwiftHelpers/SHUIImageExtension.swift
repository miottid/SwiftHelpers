//
//  UIImageExtension.swift
//  AddMedica
//
//  Created by Remi Santos on 18/02/15.
//  Copyright (c) 2015 Wopata. All rights reserved.
//

import UIKit

extension UIImage {
    convenience init?(localizedName:String) {
        let lang = NSLocale.preferredLanguages()[0] as! String
        var imageName = localizedName + "-" + lang
        if UIImage(named: imageName) == nil {
            imageName = localizedName + "-" + "en"
        }
        self.init(named:imageName)
    }

    convenience init?(localizedName:String, ofLang lang: String) {
        var imageName = localizedName + "-" + lang
        if UIImage(named: imageName) == nil {
            imageName = localizedName + "-" + "en"
        }
        self.init(named:imageName)
    }
    
    func tintWithColor(color:UIColor) -> UIImage {
        
        UIGraphicsBeginImageContextWithOptions(self.size, false, self.scale)
        let context = UIGraphicsGetCurrentContext()
        CGContextTranslateCTM(context, 0, self.size.height)
        CGContextScaleCTM(context, 1.0, -1.0)
        CGContextSetBlendMode(context, kCGBlendModeNormal)
        let rect = CGRectMake(0, 0, self.size.width, self.size.height)
        CGContextClipToMask(context, rect, self.CGImage)
        color.setFill()
        CGContextFillRect(context, rect)
        
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext();
        return newImage;
    }
    
    class func imageWithColor(color: UIColor, size: CGSize) -> UIImage {
        let rect = CGRect(origin: CGPoint.zeroPoint, size: size)
        
        UIGraphicsBeginImageContext(rect.size)
        
        let context = UIGraphicsGetCurrentContext()
        
        CGContextSetFillColorWithColor(context, color.CGColor)
        CGContextFillRect(context, rect)
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        
        UIGraphicsEndImageContext()
        
        return image

    }
    
}
