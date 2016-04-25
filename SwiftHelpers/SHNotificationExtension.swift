//
//  SHNotificationExtension.swift
//  SwiftHelpers
//
//  Created by David Miotti on 25/04/16.
//  Copyright © 2016 Wopata. All rights reserved.
//

import Foundation

private var registeredNotificationsAssociationKey: UInt8 = 0

public extension NSObject {
    public func on(notificationName: String, block: (NSNotification) -> Void) -> NSObjectProtocol {
        return NSNotificationCenter.defaultCenter().addObserverForName(notificationName, object: nil, queue: nil) { n in
            block(n)
        }
    }
}