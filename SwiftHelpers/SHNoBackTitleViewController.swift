//
//  SHNoBackTitleViewController.swift
//  SwiftHelpers
//
//  Created by David Miotti on 25/11/15.
//  Copyright © 2015 Wopata. All rights reserved.
//

#if os(iOS)

import UIKit

open class SHNoBackButtonTitleViewController: UIViewController {
    
    override open func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }
    
}

open class SHNoBackButtonTitleTableViewController: UITableViewController {
    
    override open func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }
    
}

#endif
