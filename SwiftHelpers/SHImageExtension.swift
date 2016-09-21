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
        let imageRect = CGRect(x: 0, y: 0, width: self.size.width, height: self.size.height)
        let colorSpace = CGColorSpaceCreateDeviceGray();
        
        let width = Int(self.size.width)
        let height = Int(self.size.height)
        let context = CGContext(data: nil, width: width, height: height, bitsPerComponent: 8, bytesPerRow: 0, space: colorSpace, bitmapInfo: .allZeros);
        context?.draw(cgImage!, in: imageRect)
        
        if let imageRef = context?.makeImage() {
            let newImage = UIImage(cgImage: imageRef)
            return newImage
        }
        return self
    }
    
    public static func imageWithColor(_ color: UIColor) -> UIImage {
        let rect = CGRect(x: 0.0, y: 0.0, width: 1.0, height: 1.0)
        
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()
        context?.setFillColor(color.cgColor)
        context?.fill(rect)
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image!
    }
}
