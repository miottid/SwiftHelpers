//
//  SHStatusBarNavigationController.swift
//  Boddy
//
//  Created by David Miotti on 02/09/2015.
//  Copyright (c) 2015 Wopata. All rights reserved.
//

import UIKit

public class SHStatusBarNavigationController: UINavigationController {
    
    var preferedStatusBarStyle: UIStatusBarStyle = .LightContent {
        didSet {
            setNeedsStatusBarAppearanceUpdate()
        }
    }
    
    var navigationBarStyle: UIBarStyle = .BlackTranslucent
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        
        navigationBar.barStyle = navigationBarStyle
    }
    
    override public func preferredStatusBarStyle() -> UIStatusBarStyle {
        return preferedStatusBarStyle
    }

}
