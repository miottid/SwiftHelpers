//
//  SHUIAlertController.swift
//  SwiftHelpers
//
//  Created by David Miotti on 05/03/16.
//  Copyright © 2016 Wopata. All rights reserved.
//

import Foundation

public extension UIAlertController {
    
    public class func presentAlertWithTitle(title: String?, message: String?, inController controller: UIViewController, completionHandler: (UIAlertAction -> Void)? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .Alert)
        let okAction = UIAlertAction(title: L("OK"), style: .Default, handler: completionHandler)
        alert.addAction(okAction)
        controller.presentViewController(alert, animated: true, completion: nil)
    }
    
    public class func presentError(error: NSError, inController controller: UIViewController) {
        presentAlertWithTitle(error.localizedDescription, message: error.localizedRecoverySuggestion, inController: controller)
    }
    
}