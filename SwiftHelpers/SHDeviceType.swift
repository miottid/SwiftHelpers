//
//  SHDeviceType.swift
//  Boddy
//
//  Created by David Miotti on 03/09/2015.
//  Copyright (c) 2015 Wopata. All rights reserved.
//

#if os(iOS)

import UIKit

public enum UIUserInterfaceIdiom : Int {
    case Unspecified
    case Phone
    case Pad
}

public struct ScreenSize {
    public static let SCREEN_WIDTH         = UIScreen.mainScreen().bounds.size.width
    public static let SCREEN_HEIGHT        = UIScreen.mainScreen().bounds.size.height
    public static let SCREEN_MAX_LENGTH    = max(ScreenSize.SCREEN_WIDTH, ScreenSize.SCREEN_HEIGHT)
    public static let SCREEN_MIN_LENGTH    = min(ScreenSize.SCREEN_WIDTH, ScreenSize.SCREEN_HEIGHT)
}

public struct DeviceType {
    public static let IS_IPHONE_4_OR_LESS  = UIDevice.currentDevice().userInterfaceIdiom == .Phone && ScreenSize.SCREEN_MAX_LENGTH < 568.0
    public static let IS_IPHONE_5          = UIDevice.currentDevice().userInterfaceIdiom == .Phone && ScreenSize.SCREEN_MAX_LENGTH == 568.0
    public static let IS_IPHONE_6          = UIDevice.currentDevice().userInterfaceIdiom == .Phone && ScreenSize.SCREEN_MAX_LENGTH == 667.0
    public static let IS_IPHONE_6P         = UIDevice.currentDevice().userInterfaceIdiom == .Phone && ScreenSize.SCREEN_MAX_LENGTH == 736.0
    public static let IS_IPAD              = UIDevice.currentDevice().userInterfaceIdiom == .Pad && ScreenSize.SCREEN_MAX_LENGTH == 1024.0

    public static var isSimulator: Bool {
        var isSim = false
        #if arch(i386) || arch(x86_64)
            isSim = true
        #endif
        return isSim
    }
}

#endif
