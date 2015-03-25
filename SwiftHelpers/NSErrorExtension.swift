//
//  NSErrorExtension.swift
//  SwiftHelpers
//
//  Created by David Miotti on 25/03/2015.
//  Copyright (c) 2015 Wopata. All rights reserved.
//

import UIKit

public extension NSError {
    public func show(inController controller: UIViewController) {
        let alertController = UIAlertController(
            title: self.localizedDescription,
            message: self.localizedRecoverySuggestion,
            preferredStyle: .Alert)
        controller.presentViewController(alertController, animated: true, completion: nil)
    }
}
