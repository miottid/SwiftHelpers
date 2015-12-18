//
//  SHImageExtension.swift
//  SwiftHelpers
//
//  Created by David Miotti on 18/12/15.
//  Copyright © 2015 Wopata. All rights reserved.
//

import Foundation

public extension UIImage {
    public func grayScale() -> UIImage {
        let imageRect = CGRectMake(0, 0, self.size.width, self.size.height)
        let colorSpace = CGColorSpaceCreateDeviceGray();
        
        let width = Int(self.size.width)
        let height = Int(self.size.height)
        let context = CGBitmapContextCreate(nil, width, height, 8, 0, colorSpace, .allZeros);
        CGContextDrawImage(context, imageRect, CGImage)
        
        if let imageRef = CGBitmapContextCreateImage(context) {
            let newImage = UIImage(CGImage: imageRef)
            return newImage
        }
        return self
    }
}