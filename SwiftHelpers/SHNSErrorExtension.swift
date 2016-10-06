//
//  NSErrorExtension.swift
//  SwiftHelpers
//
//  Created by David Miotti on 25/03/2015.
//  Copyright (c) 2015 Wopata. All rights reserved.
//

#if os(iOS)

import UIKit

public extension NSError {
    public func show(inController controller: UIViewController) {
        let alertController = UIAlertController(
            title: self.localizedDescription,
            message: self.localizedRecoverySuggestion,
            preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(okAction)
        controller.present(alertController, animated: true, completion: nil)
    }
}

#endif
