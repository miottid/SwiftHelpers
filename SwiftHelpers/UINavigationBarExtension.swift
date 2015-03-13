//
//  UINavigationBarExtension.swift
//  Boddy
//
//  Created by Remi Santos on 13/03/15.
//  Copyright (c) 2015 Wopata. All rights reserved.
//

import UIKit

extension UINavigationBar {
    
    func hideBackgroundImageView() {
        let background = backgroundImageViewInNavigationBar(self)
        background?.alpha = 0
    }
    
    func showBackgroundImageView() {
        let background = backgroundImageViewInNavigationBar(self)
        background?.alpha = 1
    }
    func setBackgroundImageViewAlpha(alpha:CGFloat) {
        let background = backgroundImageViewInNavigationBar(self)
        UIView.animateWithDuration(0.2, animations: { () -> Void in
            background!.alpha = alpha
        })
    }
    
    func setBottomHairLineAlpha(alpha:CGFloat) {
        let navigationBarImageView = hairlineImageViewInNavigationBar(self)
        UIView.animateWithDuration(0.2, animations: { () -> Void in
            navigationBarImageView!.alpha = alpha
        })
    }
    func hideBottomHairline() {
        let navigationBarImageView = hairlineImageViewInNavigationBar(self)
        navigationBarImageView?.alpha = 0
    }
    
    func showBottomHairline() {
        let navigationBarImageView = hairlineImageViewInNavigationBar(self)
        navigationBarImageView?.alpha = 0.5
    }
    
    private func hairlineImageViewInNavigationBar(view: UIView) -> UIImageView? {
        if view.isKindOfClass(UIImageView) && view.bounds.height <= 1.0 {
            return (view as UIImageView)
        }
        
        let subviews = (view.subviews as [UIView])
        for subview: UIView in subviews {
            if let imageView: UIImageView = hairlineImageViewInNavigationBar(subview)? {
                return imageView
            }
        }
        
        return nil
    }
    
    private func backgroundImageViewInNavigationBar(view: UIView) -> UIView? {
        
        let subviews = (view.subviews as [UIView])
        var i = 0
        return subviews[0] as UIView
    }
    
}