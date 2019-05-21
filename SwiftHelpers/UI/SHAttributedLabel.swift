//
//  SHAttributedLabel.swift
//  SwiftHelpers
//
//  Created by Maxime de Chalendar on 04/07/2016.
//  Copyright © 2016 Muxu.Muxu. All rights reserved.
//

#if os(iOS)

import UIKit

/// A class that allows you to edit the line spacing and kerning of labels without having to deal with NSAttributedString
@IBDesignable open class AttributedLabel: UILabel {

    /// The kerning (characters spacing) of the label
    @IBInspectable open var kerning: CGFloat = 0 {
        didSet {
            refreshAttributes()
        }
    }

    /// The interline spacing (vertical spacing) of the label
    @IBInspectable open var interlineSpacing: CGFloat = 0 {
        didSet {
            refreshAttributes()
        }
    }

    override open var text: String? {
        didSet {
            refreshAttributes()
        }
    }

    override open var font: UIFont? {
        didSet {
            refreshAttributes()
        }
    }

    override open func awakeFromNib() {
        super.awakeFromNib()
        refreshAttributes()
    }

    fileprivate func refreshAttributes() {
        var attributes: [NSAttributedString.Key: AnyObject] = [:]
        attributes[.font] = font
        if kerning > 0 {
            attributes[.kern] = kerning as AnyObject?
        }
        if interlineSpacing > 0 {
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.alignment = textAlignment
            paragraphStyle.lineSpacing = CGFloat(interlineSpacing)
            attributes[.paragraphStyle] = paragraphStyle
        }
        attributedText = NSAttributedString(string: text ?? "", attributes: attributes)
    }
    
}

#endif
