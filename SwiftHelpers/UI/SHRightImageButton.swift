//
//  SHRightImageButton.swift
//  SwiftHelpers
//
//  Created by Maxime de Chalendar on 04/07/2016.
//  Copyright © 2016 Muxu.Muxu. All rights reserved.
//

#if os(iOS)

import UIKit

/// A UIButton subclass that puts the button's `imageView` on the right instead of the left.
public class RightImageButton: UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame)

        reverseImage()
    }

    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

        reverseImage()
    }

    fileprivate func reverseImage() {
        // Reverse the button. The label is on the left, the image on the right but they are shown as if you look a mirror.
        transform = CGAffineTransform(scaleX: -1.0, y: 1.0)
        // Reverse back the titleLabel and the imageView.
        // They stay at the same place and look nice again. TADA 🎉
        titleLabel?.transform = CGAffineTransform(scaleX: -1.0, y: 1.0)
        imageView?.transform = CGAffineTransform(scaleX: -1.0, y: 1.0)
    }
    
}

#endif
