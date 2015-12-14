//
//  SHTextField.swift
//  SwiftHelpers
//
//  Created by David Miotti on 14/12/15.
//  Copyright © 2015 Wopata. All rights reserved.
//

import UIKit

final class SHTextField: UITextField {
    
    var placeholderInsets: UIEdgeInsets = UIEdgeInsetsZero
    var textInsets: UIEdgeInsets = UIEdgeInsetsZero
    
    override func textRectForBounds(bounds: CGRect) -> CGRect {
        return UIEdgeInsetsInsetRect(bounds, placeholderInsets)
    }
    
    override func editingRectForBounds(bounds: CGRect) -> CGRect {
        return UIEdgeInsetsInsetRect(bounds, textInsets)
    }

}
