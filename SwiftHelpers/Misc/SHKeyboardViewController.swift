//
//  SHKeyboardViewController.swift
//  SwiftHelpers
//
//  Created by David Miotti on 23/11/15.
//  Copyright © 2015 Muxu.Muxu. All rights reserved.
//

#if os(iOS)

import UIKit

open class SHKeyboardViewController: UIViewController {
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    private(set) var scrollableView: UIScrollView?

    open func registerKeyboardNotifications(for view: UIScrollView) {
        scrollableView = view
        NotificationCenter.default.addObserver(self, selector: #selector(SHKeyboardViewController.keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(SHKeyboardViewController.keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc open func keyboardWillShow(_ notification: Foundation.Notification) {
        if let scrollableView = scrollableView {
            let scrollViewRect = view.convert(scrollableView.frame, from: scrollableView.superview)
            
            if let rectValue = (notification as NSNotification).userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
                let kbRect = view.convert(rectValue.cgRectValue, from: nil)
                
                let hiddenScrollViewRect = scrollViewRect.intersection(kbRect)
                if !hiddenScrollViewRect.isNull {
                    var contentInsets = scrollableView.contentInset
                    contentInsets.bottom = hiddenScrollViewRect.size.height
                    scrollableView.contentInset = contentInsets
                    scrollableView.scrollIndicatorInsets = contentInsets
                }
            }
        }
    }
    
    @objc open func keyboardWillHide(_ notification: Foundation.Notification) {
        if let scrollableView = scrollableView {
            var contentInsets = scrollableView.contentInset
            contentInsets.bottom = 0
            scrollableView.contentInset = contentInsets
            scrollableView.scrollIndicatorInsets = contentInsets
        }
    }

}

#endif
