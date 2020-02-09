//
//  UIButtonExtension.swift
//  AddMedica
//
//  Created by Remi Santos on 18/02/15.
//  Copyright (c) 2015 Muxu.Muxu. All rights reserved.
//

#if os(iOS)

import UIKit

public extension UIButton {
    func centerLabelVertically(with padding:CGFloat) {
        // update positioning of image and title
        let imageSize = self.imageView!.frame.size
        self.titleEdgeInsets = UIEdgeInsets(top:0,
            left:-imageSize.width,
            bottom:-(imageSize.height + padding),
            right:0)
        let titleSize = self.titleLabel!.frame.size
        self.imageEdgeInsets = UIEdgeInsets(top:-(titleSize.height + padding),
            left:0,
            bottom: 0,
            right:-titleSize.width)
        
        // reset contentInset, so intrinsicContentSize() is still accurate
        let trueContentSize = self.titleLabel!.frame.union(self.imageView!.frame).size
        let oldContentSize = self.intrinsicContentSize
        let heightDelta = trueContentSize.height - oldContentSize.height
        let widthDelta = trueContentSize.width - oldContentSize.width
        self.contentEdgeInsets = UIEdgeInsets(top:heightDelta/2.0,
            left:widthDelta/2.0,
            bottom:heightDelta/2.0,
            right:widthDelta/2.0)
    }
    
    func setBackgroundColor(color: UIColor?, for state: UIControl.State) {
        guard let color = color else { return }
        setBackgroundImage(UIImage(color: color), for: state)
    }
    
}

#endif
