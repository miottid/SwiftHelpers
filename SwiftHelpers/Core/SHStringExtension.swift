//
//  StringExtension.swift
//  Boddy
//
//  Created by Remi Santos on 12/03/15.
//  Copyright (c) 2015 Muxu.Muxu. All rights reserved.
//

import Foundation
import UIKit

public extension NSAttributedString {
    func replace(HTMLTag tag: String, with attributes: [NSAttributedString.Key: AnyObject]) -> NSAttributedString {
        let openTag = "<\(tag)>"
        let closeTag = "</\(tag)>"
        let resultingText: NSMutableAttributedString = self.mutableCopy() as! NSMutableAttributedString
        while true {
            let plainString = resultingText.string as NSString
            let openTagRange = plainString.range(of: openTag)
            if openTagRange.length == 0 {
                break
            }
            
            let affectedLocation = openTagRange.location + openTagRange.length
            
            let searchRange = NSMakeRange(affectedLocation, plainString.length - affectedLocation)
            
            let closeTagRange = plainString.range(of: closeTag, options: NSString.CompareOptions(rawValue: 0), range: searchRange)
            
            resultingText.setAttributes(attributes, range: NSMakeRange(affectedLocation, closeTagRange.location - affectedLocation))
            resultingText.deleteCharacters(in: closeTagRange)
            resultingText.deleteCharacters(in: openTagRange)
        }
        return resultingText as NSAttributedString
    }
}

public extension String {
    var floatValue: Float {
        return (self as NSString).floatValue
    }
    
    func isNumeric() -> Bool {
        return Int(self) != nil
    }
    
    func rangeString(_ string: String) -> NSRange {
        return NSString(string: self).range(of: string)
    }

    func ranges(of string: String) -> [NSRange] {
        let pattern = NSRegularExpression.escapedPattern(for: string)
        guard let re = try? NSRegularExpression(pattern: pattern, options: []) else {
            return []
        }
        let range = NSRange(location: 0, length: self.count)
        return re.matches(in: self, options: [], range: range).compactMap { $0.range }
    }
}

public extension String {
    
    var CGColor: CGColor {
        return self.CGColor(1)
    }
    
    var UIColor: UIKit.UIColor {
        return self.UIColor(1)
    }
    
    func CGColor (_ alpha: CGFloat) -> CGColor {
        return self.UIColor(alpha).cgColor
    }
    
    func UIColor (_ alpha: CGFloat) -> UIKit.UIColor {
        var hex = self
        
        if hex.hasPrefix("#") { // Strip leading "#" if it exists
            hex = String(hex[hex.index(after: hex.startIndex)...])
        }
        
        switch hex.count {
        case 1: // Turn "f" into "ffffff"
            hex = hex.`repeat`(6)
        case 2: // Turn "ff" into "ffffff"
            hex = hex.`repeat`(3)
        case 3: // Turn "123" into "112233"
            hex = hex[0].`repeat`(2) + hex[1].`repeat`(2) + hex[2].`repeat`(2)
        default:
            break
        }
        
        assert(hex.count == 6, "Invalid hex value")
        
        var r: UInt32 = 0
        var g: UInt32 = 0
        var b: UInt32 = 0

        let h = NSString(string: hex)

        let R = h.substring(with: NSRange(location: 0, length: 2))
        let G = h.substring(with: NSRange(location: 2, length: 2))
        let B = h.substring(with: NSRange(location: 4, length: 2))

        Scanner(string: "0x\(R)").scanHexInt32(&r)
        Scanner(string: "0x\(G)").scanHexInt32(&g)
        Scanner(string: "0x\(B)").scanHexInt32(&b)
        
        let red = CGFloat(Int(r)) / CGFloat(255.0)
        let green = CGFloat(Int(g)) / CGFloat(255.0)
        let blue = CGFloat(Int(b)) / CGFloat(255.0)
        
        return UIKit.UIColor(red: red, green: green, blue: blue, alpha: alpha)
    }
    
    var firstLetterCapitalization: String {
        var str = self
        str.replaceSubrange(str.startIndex...str.startIndex, with: String(str[str.startIndex]).uppercased())
        return str
    }
}

public extension String {
    
    func `repeat` (_ count: Int) -> String {
        return "".padding(toLength: (self as NSString).length * count, withPad: self, startingAt:0)
    }
}

public extension String {
    
    subscript (i: Int) -> Character {
        return self[self.index(self.startIndex, offsetBy: i)]
    }
    
    subscript (i: Int) -> String {
        return String(self[i] as Character)
    }
    
    subscript (r: Range<Int>) -> String {
        let substring = self[index(startIndex, offsetBy: r.lowerBound)..<index(startIndex, offsetBy: r.upperBound)]
        return String(substring)
    }
}

public extension String {
    func fontSizeThatFits(_ font: UIFont, attributes: [NSAttributedString.Key: AnyObject]?, size: CGSize) -> UIFont {
        let txt = NSString(string: self)
        var fntSize = font.pointSize + 1
        var width = CGFloat(Float.infinity)
        var height = CGFloat(Float.infinity)
        repeat {
            fntSize -= 1
            let fnt = UIFont(name: font.fontName, size: fntSize)
            var attrs = attributes ?? [NSAttributedString.Key: AnyObject]()
            attrs[.font] = fnt
            let size = txt.size(withAttributes: attrs)
            width = size.width
            height = size.height
        } while ((width > size.width || height > size.height) && fntSize > 0)
        return UIFont(name: font.fontName, size: fntSize)!
    }
}

public extension String {

    init?(numerator: Int, denominator: Int) {
        var result = ""
        
        // build numerator
        let one = "\(numerator)"
        for char in one {
            if let num = Int(String(char)), let val = superScript(from: num) {
                result.append(val)
            }
        }
        
        // build denominator
        let two = "\(denominator)"
        result.append("/")
        for char in two {
            if let num = Int(String(char)), let val = subScript(from: num) {
                result.append(val)
            }
        }

        self.init(result)
    }
}

private func superScript(from num: Int) -> String? {
    let superscriptDigits: [Int: String] = [
        0: "\u{2070}",
        1: "\u{00B9}",
        2: "\u{00B2}",
        3: "\u{00B3}",
        4: "\u{2074}",
        5: "\u{2075}",
        6: "\u{2076}",
        7: "\u{2077}",
        8: "\u{2078}",
        9: "\u{2079}" ]
    return superscriptDigits[num]
}

private func subScript(from num: Int) -> String? {
    let subscriptDigits: [Int: String] = [
        0: "\u{2080}",
        1: "\u{2081}",
        2: "\u{2082}",
        3: "\u{2083}",
        4: "\u{2084}",
        5: "\u{2085}",
        6: "\u{2086}",
        7: "\u{2087}",
        8: "\u{2088}",
        9: "\u{2089}" ]
    return subscriptDigits[num]
}
