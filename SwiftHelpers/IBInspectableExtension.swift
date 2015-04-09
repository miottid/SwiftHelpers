//
//  IBInspectableExtension.swift
//  SwiftHelpers
//
//  Created by David Miotti on 09/04/2015.
//  Copyright (c) 2015 Wopata. All rights reserved.
//

import UIKit

extension UIView {
    @IBInspectable var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
            layer.masksToBounds = newValue > 0
        }
    }
    @IBInspectable var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }
    @IBInspectable var borderColor: UIColor {
        get {
            return UIColor(CGColor: layer.borderColor!)!
        }
        set {
            layer.borderColor = newValue.CGColor
        }
    }
    @IBInspectable var shadowColor: UIColor {
        get {
            return UIColor(CGColor: layer.shadowColor!)!
        }
        set {
            layer.shadowColor = newValue.CGColor
        }
    }
    @IBInspectable var shadowOpacity: Float {
        get {
            return layer.shadowOpacity
        }
        set {
            layer.shadowOpacity = newValue
        }
    }
    @IBInspectable var shadowOffset: CGSize {
        get {
            return layer.shadowOffset
        }
        set {
            layer.shadowOffset = newValue
        }
    }
    @IBInspectable var shadowRadius: CGFloat {
        get {
            return layer.shadowRadius
        }
        set {
            layer.shadowRadius = newValue
        }
    }
}

extension UILabel {
    @IBInspectable var localizedText: String {
        set (key) {
            text = NSLocalizedString(key, comment: "")
        }
        get {
            return text!
        }
    }
}
extension UIButton {
    @IBInspectable var localizedText: String {
        set (key) {
            setTitle(NSLocalizedString(key, comment: ""), forState: .Normal)
        }
        get {
            return titleForState(.Normal)!
        }
    }
}
extension UITextField {
    @IBInspectable var localizedPlaceholder: String {
        set (key) {
            placeholder = NSLocalizedString(key, comment: "")
        }
        get {
            return placeholder!
        }
    }
}