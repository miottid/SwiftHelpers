//
//  SHTextField.swift
//  SwiftHelpers
//
//  Created by David Miotti on 14/12/15.
//  Copyright © 2015 Wopata. All rights reserved.
//

#if os(iOS)

import UIKit

public class SHTextField: UITextField {
    
    var placeholderInsets: UIEdgeInsets = UIEdgeInsetsZero
    var textInsets: UIEdgeInsets = UIEdgeInsetsZero
    
    override public func textRectForBounds(bounds: CGRect) -> CGRect {
        return UIEdgeInsetsInsetRect(bounds, placeholderInsets)
    }
    
    override public func editingRectForBounds(bounds: CGRect) -> CGRect {
        return UIEdgeInsetsInsetRect(bounds, textInsets)
    }

}

#endif
