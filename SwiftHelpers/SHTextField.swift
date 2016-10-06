//
//  SHTextField.swift
//  SwiftHelpers
//
//  Created by David Miotti on 14/12/15.
//  Copyright © 2015 Wopata. All rights reserved.
//

#if os(iOS)

import UIKit

open class SHTextField: UITextField {
    
    var placeholderInsets: UIEdgeInsets = UIEdgeInsets.zero
    var textInsets: UIEdgeInsets = UIEdgeInsets.zero
    
    override open func textRect(forBounds bounds: CGRect) -> CGRect {
        return UIEdgeInsetsInsetRect(bounds, placeholderInsets)
    }
    
    override open func editingRect(forBounds bounds: CGRect) -> CGRect {
        return UIEdgeInsetsInsetRect(bounds, textInsets)
    }

}

#endif
