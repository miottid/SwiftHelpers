//
//  SwiftHelper.swift
//  SwiftHelper
//
//  Created by David Miotti on 06/01/2015.
//  Copyright (c) 2015 Muxu.Muxu. All rights reserved.
//

import Foundation

///Returns a localized string, using the main bundle if one is not specified.
public func L(_ key: String, nb: Int? = nil, bundle: Bundle = Bundle.main) -> String {
    guard let nb = nb else { return NSLocalizedString(key, bundle: bundle, comment: "") }

    let key = pluralize(key, count: nb as NSNumber)
    return String(format: NSLocalizedString(key, bundle: bundle, comment: ""), nb)
}

private func pluralize(_ key: String, count: NSNumber?) -> String {
    guard let count = count else { return key }

    let prefix: String
    switch count.doubleValue {
    case 0: prefix = "zero"
    case 1: prefix = "one"
    default: prefix = "other"
    }
    return "\(key)_\(prefix)"
}

///Get the current version of the app
///- returns: A string representing the version of the app {CFBundleShortVersionString}.{CFBundleVersion}
public func appVersion() -> String {
    let mainBundle = Bundle.main
    if let bundleDictionary = mainBundle.infoDictionary {
        if let shortVersion = bundleDictionary["CFBundleShortVersionString"] as? String {
            if let bundleVersion = bundleDictionary["CFBundleVersion"] as? String {
                return NSString(format: "%@ (#%@)", shortVersion, bundleVersion) as String
            }
        }
    }
    
    return ""
}

public extension String {
    func localize(arguments: [String: Any] = [:], bundle: Bundle = Bundle.main) -> String {
        let key = pluralize(self, count: arguments["count"] as? NSNumber)
        var str = NSLocalizedString(key, bundle: bundle, comment: "")
        arguments.forEach { key, val in
            str = str.replacingOccurrences(of: "{\(key)}", with: "\(val)")
        }
        return str
    }
}
