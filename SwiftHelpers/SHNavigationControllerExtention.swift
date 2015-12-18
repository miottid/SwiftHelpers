//
//  SHNavigationControllerExtention.swift
//  SwiftHelpers
//
//  Created by David Miotti on 18/12/15.
//  Copyright © 2015 Wopata. All rights reserved.
//

import Foundation

public class PreferredStatusBarNavigationController: UINavigationController {
    public override func preferredStatusBarStyle() -> UIStatusBarStyle {
        if let top = self.topViewController {
            return top.preferredStatusBarStyle()
        }
        return super.preferredStatusBarStyle()
    }
}