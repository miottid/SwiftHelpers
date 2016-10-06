//
//  SHKeyboardViewController.swift
//  SwiftHelpers
//
//  Created by David Miotti on 23/11/15.
//  Copyright © 2015 Wopata. All rights reserved.
//

#if os(iOS)

import UIKit

open class SHKeyboardViewController: UIViewController {
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    fileprivate var scrollableView: UIScrollView?

    open func registerKeyboardNotificationsForScrollableView(_ view: UIScrollView) {
        scrollableView = view
        NotificationCenter.default.addObserver(self, selector: #selector(SHKeyboardViewController.keyboardWillShow(_:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(SHKeyboardViewController.keyboardWillHide(_:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    func keyboardWillShow(_ notification: Notification) {
        if let scrollableView = scrollableView {
            let scrollViewRect = view.convert(scrollableView.frame, from: scrollableView.superview)
            
            if let rectValue = (notification as NSNotification).userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue {
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
    
    func keyboardWillHide(_ notification: Notification) {
        if let scrollableView = scrollableView {
            var contentInsets = scrollableView.contentInset
            contentInsets.bottom = 0
            scrollableView.contentInset = contentInsets
            scrollableView.scrollIndicatorInsets = contentInsets
        }
    }

}

#endif
