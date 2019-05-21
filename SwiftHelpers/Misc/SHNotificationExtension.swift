//
//  SHNotificationExtension.swift
//  SwiftHelpers
//
//  Created by David Miotti on 25/04/16.
//  Copyright © 2016 Muxu.Muxu. All rights reserved.
//

import Foundation

private var registeredNotificationsAssociationKey: UInt8 = 0

public extension NSObject {
    func on(_ notificationName: String, block: @escaping (Foundation.Notification) -> Void) -> NSObjectProtocol {
        return NotificationCenter.default.addObserver(forName: NSNotification.Name(rawValue: notificationName), object: nil, queue: nil) { n in
            block(n)
        }
    }
}
