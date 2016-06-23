//
//  SwiftHelper.swift
//  SwiftHelper
//
//  Created by David Miotti on 06/01/2015.
//  Copyright (c) 2015 Wopata. All rights reserved.
//

import Foundation

///Returns a localized string, using the main bundle if one is not specified.
public func L(key: String) -> String {
    return NSLocalizedString(key, comment: "")
}

///Helper for `println` function with a filter for use in debug mode only
public func P(string: String) {
    #if RELEASE
    #else
        print(string)
    #endif
}

///Get the current version of the app
///- returns: A string representing the version of the app {CFBundleShortVersionString}.{CFBundleVersion}
public func appVersion() -> String {
    let mainBundle = NSBundle.mainBundle()
    if let bundleDictionary = mainBundle.infoDictionary {
        if let shortVersion = bundleDictionary["CFBundleShortVersionString"] as? String {
            if let bundleVersion = bundleDictionary["CFBundleVersion"] as? String {
                return NSString(format: "%@.%@", shortVersion, bundleVersion) as String
            }
        }
    }
    
    return ""
}
