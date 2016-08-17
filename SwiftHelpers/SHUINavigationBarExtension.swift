//
//  UINavigationBarExtension.swift
//  Boddy
//
//  Created by Remi Santos on 13/03/15.
//  Copyright (c) 2015 Wopata. All rights reserved.
//

#if os(iOS)

import UIKit

extension UINavigationBar {
    
    public func hideBackgroundImageView() {
        let background = backgroundImageViewInNavigationBar(self)
        background?.alpha = 0
    }
    
    public func showBackgroundImageView() {
        let background = backgroundImageViewInNavigationBar(self)
        background?.alpha = 1
    }

    public func setBackgroundImageViewAlpha(alpha:CGFloat) {
        let background = backgroundImageViewInNavigationBar(self)
        UIView.animateWithDuration(0.2, animations: { () -> Void in
            background!.alpha = alpha
        })
    }
    
    public func setBottomHairLineAlpha(alpha:CGFloat) {
        let navigationBarImageView = hairlineImageViewInNavigationBar(self)
        UIView.animateWithDuration(0.2, animations: { () -> Void in
            navigationBarImageView!.alpha = alpha
        })
    }

    public func hideBottomHairline() {
        let navigationBarImageView = hairlineImageViewInNavigationBar(self)
        navigationBarImageView?.alpha = 0
    }
    
    public func showBottomHairline() {
        let navigationBarImageView = hairlineImageViewInNavigationBar(self)
        navigationBarImageView?.alpha = 0.5
    }
    
    private func hairlineImageViewInNavigationBar(view: UIView) -> UIImageView? {
        if view.isKindOfClass(UIImageView) && view.bounds.height <= 1.0 {
            return (view as! UIImageView)
        }
        
        let subviews = (view.subviews )
        for subview: UIView in subviews {
            if let imageView = hairlineImageViewInNavigationBar(subview) {
                return imageView
            }
        }
        
        return nil
    }
    
    private func backgroundImageViewInNavigationBar(view: UIView) -> UIView? {
        return view.subviews.first
    }
    
}

#endif
