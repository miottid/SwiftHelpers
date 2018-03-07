//
//  IBInspectableExtension.swift
//  SwiftHelpers
//
//  Created by David Miotti on 09/04/2015.
//  Copyright (c) 2015 Muxu.Muxu. All rights reserved.
//

#if os(iOS)

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
            return UIColor(cgColor: layer.borderColor!)
        }
        set {
            layer.borderColor = newValue.cgColor
        }
    }
    @IBInspectable var shadowColor: UIColor {
        get {
            return UIColor(cgColor: layer.shadowColor!)
        }
        set {
            layer.shadowColor = newValue.cgColor
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
    @IBInspectable var layerMasksToBounds: Bool {
        get {
            return layer.masksToBounds
        }
        set {
            layer.masksToBounds = newValue
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
            setTitle(NSLocalizedString(key, comment: ""), for: .normal)
        }
        get {
            return title(for: .normal)!
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
extension UIBarItem {
    @IBInspectable var localizedText: String {
        set(key) {
            title = NSLocalizedString(key, comment: "")
        }
        get {
            return title!
        }
    }
}
extension UIViewController {
    @IBInspectable var localizedTitle: String {
        set(key) {
            title = NSLocalizedString(key, comment: "")
        }
        get {
            return title!
        }
    }
}
#endif
