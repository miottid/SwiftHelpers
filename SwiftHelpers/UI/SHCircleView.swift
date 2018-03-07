//
//  SHCircleView.swift
//  SwiftHelpers
//
//  Created by Maxime de Chalendar on 04/07/2016.
//  Copyright © 2016 Muxu.Muxu. All rights reserved.
//

#if os(iOS)

import UIKit

/// A UIView subclass that updates its corner radius on layoutSubviews to make it look like a circle
class SHCircleView: UIView {

    override func layoutSubviews() {
        super.layoutSubviews()

        layer.cornerRadius = max(bounds.width, bounds.height) / 2
        layer.masksToBounds = true
    }
    
}

/// A UIImageView subclass that updates its corner radius on layoutSubviews to make it look like a circle
class SHCircleImageView: UIImageView {

    override func layoutSubviews() {
        super.layoutSubviews()

        layer.cornerRadius = max(bounds.width, bounds.height) / 2
        layer.masksToBounds = true
    }
    
}

/// A UIButton subclass that updates its corner radius on layoutSubviews to make it look like a circle
class SHCircleButton: UIButton {

    override func layoutSubviews() {
        super.layoutSubviews()

        layer.cornerRadius = max(bounds.width, bounds.height) / 2
        layer.masksToBounds = true
    }
    
}

#endif
