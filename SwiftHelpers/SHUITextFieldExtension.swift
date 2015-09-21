//
//  UITextFieldExtension.swift
//  SwiftHelpers
//
//  Created by David Miotti on 23/03/2015.
//  Copyright (c) 2015 Wopata. All rights reserved.
//

import UIKit

public extension UITextField {
    public func selectTextAtRange(range: NSRange) {
        if let start = positionFromPosition(beginningOfDocument, offset: range.location) {
            if let end = positionFromPosition(start, offset: range.length) {
                selectedTextRange = textRangeFromPosition(start, toPosition: end)
            }
        }
    }
}
