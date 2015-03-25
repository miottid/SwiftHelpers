//
//  NSErrorExtension.swift
//  SwiftHelpers
//
//  Created by David Miotti on 25/03/2015.
//  Copyright (c) 2015 Wopata. All rights reserved.
//

import UIKit

public extension NSError {
    public func show() {
        UIAlertView(
            title: self.localizedDescription,
            message: self.localizedRecoverySuggestion,
            delegate: nil,
            cancelButtonTitle: "OK").show()
    }
}
