//
//  SHUIAlertController.swift
//  SwiftHelpers
//
//  Created by David Miotti on 05/03/16.
//  Copyright © 2016 Wopata. All rights reserved.
//

import Foundation

public extension UIAlertController {
    
    public class func presentAlertWithTitle(_ title: String?, message: String?, inController controller: UIViewController, completionHandler: ((UIAlertAction) -> Void)? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: L("OK"), style: .default, handler: completionHandler)
        alert.addAction(okAction)
        controller.present(alert, animated: true, completion: nil)
    }
    
    public class func presentError(_ error: NSError, inController controller: UIViewController) {
        presentAlertWithTitle(error.localizedDescription, message: error.localizedRecoverySuggestion, inController: controller)
    }
    
}
