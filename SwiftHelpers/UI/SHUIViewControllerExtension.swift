//
//  UIViewControllerExtension.swift
//  SwiftHelpers
//
//  Created by David Miotti on 10/04/2015.
//  Copyright (c) 2015 Muxu.Muxu. All rights reserved.
//

#if os(iOS)

import UIKit

public extension UIViewController {
    func isFirstInNavigationController() -> Bool {
        if let nav = navigationController {
            if let first = nav.viewControllers.first {
                return first == self
            }
        }
        return false
    }

    func showMessage(title: String, message: String? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: NSLocalizedString("OK", comment: "OK"), style: .default, handler: nil)
        alert.addAction(okAction)
        present(alert, animated: true)
    }
}

#endif
