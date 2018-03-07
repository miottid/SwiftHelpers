//
//  SHStatusBarNavigationController.swift
//  Boddy
//
//  Created by David Miotti on 02/09/2015.
//  Copyright (c) 2015 Muxu.Muxu. All rights reserved.
//

#if os(iOS)

import UIKit

open class SHStatusBarNavigationController: UINavigationController {
    
    open var statusBarStyle: UIStatusBarStyle = .lightContent {
        didSet {
            setNeedsStatusBarAppearanceUpdate()
        }
    }
    
    open var navigationBarStyle: UIBarStyle = .blackTranslucent
    
    override open func viewDidLoad() {
        super.viewDidLoad()
        
        navigationBar.barStyle = navigationBarStyle
    }
    
    override open var preferredStatusBarStyle : UIStatusBarStyle {
        return statusBarStyle
    }

}

#endif
