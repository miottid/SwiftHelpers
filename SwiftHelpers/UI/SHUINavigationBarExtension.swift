//
//  UINavigationBarExtension.swift
//  Boddy
//
//  Created by Remi Santos on 13/03/15.
//  Copyright (c) 2015 Muxu.Muxu. All rights reserved.
//

#if os(iOS)

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

    func setBackgroundImageViewAlpha(_ alpha:CGFloat) {
        let background = backgroundImageViewInNavigationBar(self)
        UIView.animate(withDuration: 0.2, animations: { () -> Void in
            background!.alpha = alpha
        })
    }
    
    func setBottomHairLineAlpha(_ alpha:CGFloat) {
        let navigationBarImageView = hairlineImageViewInNavigationBar(self)
        UIView.animate(withDuration: 0.2, animations: { () -> Void in
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
    
    fileprivate func hairlineImageViewInNavigationBar(_ view: UIView) -> UIImageView? {
        if view.isKind(of: UIImageView.self) && view.bounds.height <= 1.0 {
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
    
    fileprivate func backgroundImageViewInNavigationBar(_ view: UIView) -> UIView? {
        return view.subviews.first
    }
    
}

#endif
