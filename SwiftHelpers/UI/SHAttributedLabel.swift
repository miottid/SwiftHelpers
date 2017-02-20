//
//  SHAttributedLabel.swift
//  SwiftHelpers
//
//  Created by Maxime de Chalendar on 04/07/2016.
//  Copyright © 2016 Wopata. All rights reserved.
//

#if os(iOS)

import UIKit

/// A class that allows you to edit the line spacing and kerning of labels without having to deal with NSAttributedString
@IBDesignable class AttributedLabel: UILabel {

    /// The kerning (characters spacing) of the label
    @IBInspectable var kerning: CGFloat = 0 {
        didSet {
            refreshAttributes()
        }
    }

    /// The interline spacing (vertical spacing) of the label
    @IBInspectable var interlineSpacing: CGFloat = 0 {
        didSet {
            refreshAttributes()
        }
    }

    override var text: String? {
        didSet {
            refreshAttributes()
        }
    }

    override var font: UIFont? {
        didSet {
            refreshAttributes()
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        refreshAttributes()
    }

    fileprivate func refreshAttributes() {
        var attributes: [String: AnyObject] = [:]
        attributes[NSFontAttributeName] = font
        if kerning > 0 {
            attributes[NSKernAttributeName] = kerning as AnyObject?
        }
        if interlineSpacing > 0 {
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.alignment = textAlignment
            paragraphStyle.lineSpacing = CGFloat(interlineSpacing)
            attributes[NSParagraphStyleAttributeName] = paragraphStyle
        }
        attributedText = NSAttributedString(string: text ?? "", attributes: attributes)
    }
    
}

#endif
