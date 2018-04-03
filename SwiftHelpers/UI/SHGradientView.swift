//
//  SHGradientView.swift
//  SwiftHelpers
//
//  Created by Maxime de Chalendar on 04/07/2016.
//  Copyright © 2016 Muxu.Muxu. All rights reserved.
//

#if os(iOS)

import UIKit

/**
 A class that allows to easily add gradients (and from Interface Builder too)
 It will create a gradient from the view's background colour to a clear colour
 */
@IBDesignable open class SHGradientView: UIView {

    /// Wether or not the view has a gradient at the top of the view
    @IBInspectable open var hasTopGradient: Bool = true
    /// The height of the top gradient, expressed as a ratio of the total view height
    @IBInspectable open  var topGradientHeightRatio: CGFloat = 0.3

    /// Wether or not the view has a gradient at the bottom of the view
    @IBInspectable open  var hasBottomGradient: Bool = true
    /// The height of the bottom gradient, expressed as a ratio of the total view height
    @IBInspectable open var bottomGradientHeightRatio: CGFloat = 0.3

    /// If true, the gradient will be horizontal (if so, top = left, right = bottom).
    @IBInspectable open var horizontal: Bool = false

    override open func layoutSubviews() {
        super.layoutSubviews()
        addMask(locations: locationForGradient(), colors: colorsForGradient())
    }

    fileprivate func locationForGradient() -> [CGFloat] {
        if hasTopGradient && hasBottomGradient {
            return [0, topGradientHeightRatio, 1 - bottomGradientHeightRatio, 1]
        } else if hasTopGradient {
            return [0, topGradientHeightRatio]
        } else if hasBottomGradient {
            return [1 - bottomGradientHeightRatio, 1]
        }
        return []
    }

    fileprivate func colorsForGradient() -> [CGColor] {
        let outerColor = UIColor(white: 1, alpha: 1).cgColor
        let innerColor = UIColor(white: 1, alpha: 0).cgColor

        if hasTopGradient && hasBottomGradient {
            return [outerColor, innerColor, innerColor, outerColor]
        } else if hasTopGradient {
            return [outerColor, innerColor]
        } else if hasBottomGradient {
            return [innerColor, outerColor]
        }
        return []
    }

    fileprivate func addMask(locations: [CGFloat], colors: [CGColor]) {
        let maskLayer = CAGradientLayer()
        maskLayer.locations = locations.compactMap {
            let d = Double($0)
            return NSNumber(floatLiteral: d)
        }
        maskLayer.colors = colors
        maskLayer.bounds = bounds
        maskLayer.anchorPoint = CGPoint.zero
        if horizontal {
            maskLayer.startPoint = CGPoint(x: 0.0, y: 0.5)
            maskLayer.endPoint = CGPoint(x: 1.0, y: 0.5)
        }
        self.layer.mask = maskLayer
    }
    
}

#endif
