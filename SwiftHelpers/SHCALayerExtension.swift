//
//  SHCALayerExtension.swift
//  SwiftHelpers
//
//  Created by David Miotti on 14/04/16.
//  Copyright © 2016 Wopata. All rights reserved.
//

#if os(iOS)

import UIKit

extension CAShapeLayer {
    func addRoundedCornerRadius(topLeft: CGFloat, topRight: CGFloat, bottomLeft: CGFloat, bottomRight: CGFloat, in frame: CGRect) {
        path = UIBezierPath(rect: frame, topLeft: topLeft, topRight: topRight, bottomLeft: bottomLeft, bottomRight: bottomRight).cgPath
    }
}

extension UIBezierPath {
    convenience init(rect: CGRect, topLeft: CGFloat, topRight: CGFloat, bottomLeft: CGFloat, bottomRight: CGFloat) {
        self.init()
        
        let circleCenters: (topLeft: CGPoint, topRight: CGPoint, bottomLeft: CGPoint, bottomRight: CGPoint) = (
            CGPoint(x: topLeft, y: topLeft),
            CGPoint(x: rect.size.width - topRight, y: topRight),
            CGPoint(x: bottomLeft, y: rect.size.height - bottomLeft),
            CGPoint(x: rect.size.width - bottomRight, y: rect.size.height - bottomRight)
        )
        
        let middleLeft = CGPoint(x: 0, y: rect.size.height / 2.0)
        move(to: middleLeft)
        
        addArc(withCenter: circleCenters.topLeft,
                         radius: topLeft,
                         startAngle: CGFloat(M_PI),
                         endAngle: CGFloat(3.0 * M_PI / 2.0),
                         clockwise: true)
        
        addArc(withCenter: circleCenters.topRight,
                         radius: topRight,
                         startAngle: CGFloat(3.0 * M_PI / 2.0),
                         endAngle: CGFloat(2.0 * M_PI),
                         clockwise: true)
        
        addArc(withCenter: circleCenters.bottomRight,
                         radius: bottomRight,
                         startAngle: CGFloat(2.0 * M_PI),
                         endAngle: CGFloat(M_PI / 2.0),
                         clockwise: true)
        
        addArc(withCenter: circleCenters.bottomLeft,
                         radius: bottomLeft,
                         startAngle: CGFloat(M_PI / 2.0),
                         endAngle: CGFloat(M_PI),
                         clockwise: true)
        
        close()
    }
}

#endif
