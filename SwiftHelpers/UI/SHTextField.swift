//
//  SHTextField.swift
//  SwiftHelpers
//
//  Created by David Miotti on 14/12/15.
//  Copyright © 2015 Muxu.Muxu. All rights reserved.
//

#if os(iOS)

import UIKit

open class SHTextField: UITextField {
    
    open var placeholderInsets: UIEdgeInsets = UIEdgeInsets.zero
    open var textInsets: UIEdgeInsets = UIEdgeInsets.zero
    
    override open func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: placeholderInsets)
    }
    
    override open func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: textInsets)
    }

}

#endif
