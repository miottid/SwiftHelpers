//
//  StringExtension.swift
//  Boddy
//
//  Created by Remi Santos on 12/03/15.
//  Copyright (c) 2015 Wopata. All rights reserved.
//

import UIKit

public extension NSAttributedString {
    public func replaceHTMLTag(tag: String, withAttributes attributes: [String: AnyObject]) -> NSAttributedString {
        let openTag = "<\(tag)>"
        let closeTag = "</\(tag)>"
        let resultingText: NSMutableAttributedString = self.mutableCopy() as NSMutableAttributedString
        while true {
            let plainString = resultingText.string as NSString
            let openTagRange = plainString.rangeOfString(openTag)
            if openTagRange.length == 0 {
                break
            }
            
            let affectedLocation = openTagRange.location + openTagRange.length
            
            var searchRange = NSMakeRange(affectedLocation, plainString.length - affectedLocation)
            
            let closeTagRange = plainString.rangeOfString(closeTag, options: NSStringCompareOptions(0), range: searchRange)
            
            resultingText.setAttributes(attributes, range: NSMakeRange(affectedLocation, closeTagRange.location - affectedLocation))
            resultingText.deleteCharactersInRange(closeTagRange)
            resultingText.deleteCharactersInRange(openTagRange)
        }
        return resultingText as NSAttributedString
    }
}

public extension String {
    public var floatValue: Float {
        return (self as NSString).floatValue
    }
}