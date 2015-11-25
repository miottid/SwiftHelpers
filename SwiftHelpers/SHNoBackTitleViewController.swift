//
//  SHNoBackTitleViewController.swift
//  SwiftHelpers
//
//  Created by David Miotti on 25/11/15.
//  Copyright © 2015 Wopata. All rights reserved.
//

import UIKit

public class SHNoBackButtonTitleViewController: UIViewController {
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .Plain, target: nil, action: nil)
    }
    
}

public class SHNoBackButtonTitleTableViewController: UITableViewController {
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .Plain, target: nil, action: nil)
    }
    
}