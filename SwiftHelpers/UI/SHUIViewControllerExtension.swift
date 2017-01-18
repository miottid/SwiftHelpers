//
//  UIViewControllerExtension.swift
//  SwiftHelpers
//
//  Created by David Miotti on 10/04/2015.
//  Copyright (c) 2015 Wopata. All rights reserved.
//

#if os(iOS)

import UIKit

public extension UIViewController {
    public func isFirstInNavigationController() -> Bool {
        if let nav = navigationController {
            if let first = nav.viewControllers.first {
                return first == self
            }
        }
        return false
    }
}

#endif
