//
//  SHUIAlertController.swift
//  SwiftHelpers
//
//  Created by David Miotti on 05/03/16.
//  Copyright © 2016 Muxu.Muxu. All rights reserved.
//

import Foundation
import UIKit

public extension UIAlertController {
    
    class func presentAlert(title: String?, message: String?, in controller: UIViewController, completionHandler: ((UIAlertAction) -> Void)? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: NSLocalizedString("OK", comment: ""), style: .default, handler: completionHandler)
        alert.addAction(okAction)
        controller.present(alert, animated: true, completion: nil)
    }
    
    class func present(error: NSError, in controller: UIViewController) {
        presentAlert(title: error.localizedDescription, message: error.localizedRecoverySuggestion, in: controller)
    }
    
}

public extension NSError {
    func present(in controller: UIViewController) {
        UIAlertController.present(error: self, in: controller)
    }
}
