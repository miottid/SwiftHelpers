//
//  UIScreenExtension.swift
//  SwiftHelpers
//
//  Created by David Miotti on 14/01/2015.
//  Copyright (c) 2015 Muxu.Muxu. All rights reserved.
//

#if os(iOS)

import UIKit

public enum DeviceResolution {
    case unknown //Handle future iOS screen devices
    case phoneStandard
    case phoneRetina4
    case phoneRetina5
    case padStandard
    case padRetina
}

///Helper for accessing the device resolution, it may also help checking the kind of device
func deviceResolution() -> DeviceResolution {
    return UIScreen.main.deviceResolution()
}

public extension UIScreen {
    
    func deviceResolution() -> DeviceResolution {
        var resolution: DeviceResolution = .unknown
        let scale = self.scale
        let pixelHeight = self.bounds.height * scale
        if UIDevice.current.userInterfaceIdiom == .phone {
            if scale == 2.0 {
                if pixelHeight == 960.0 {
                    resolution = .phoneRetina4
                } else if pixelHeight == 1136.0 {
                    resolution = .phoneRetina5
                }
            } else if scale == 1.0 && pixelHeight == 480.0 {
                resolution = .phoneStandard
            }
        } else {
            if scale == 2.0 && pixelHeight == 2048.0 {
                resolution = .padRetina
            } else {
                resolution = .padStandard
            }
        }
        return resolution
    }
    
}

#endif
