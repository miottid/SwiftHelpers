//
//  UIScreenExtension.swift
//  SwiftHelpers
//
//  Created by David Miotti on 14/01/2015.
//  Copyright (c) 2015 Wopata. All rights reserved.
//

import UIKit

public enum DeviceResolution {
    case Unknown //Handle future iOS screen devices
    case PhoneStandard
    case PhoneRetina4
    case PhoneRetina5
    case PadStandard
    case PadRetina
}

///Helper for accessing the device resolution, it may also help checking the kind of device
public func deviceResolution() -> DeviceResolution {
    return UIScreen.mainScreen().deviceResolution()
}

extension UIScreen {
    
    public func deviceResolution() -> DeviceResolution {
        var resolution: DeviceResolution = .Unknown
        let scale = self.scale
        let pixelHeight = CGRectGetHeight(self.bounds) * scale
        if UIDevice.currentDevice().userInterfaceIdiom == .Phone {
            if scale == 2.0 {
                if pixelHeight == 960.0 {
                    resolution = .PhoneRetina4
                } else if pixelHeight == 1136.0 {
                    resolution = .PhoneRetina5
                }
            } else if scale == 1.0 && pixelHeight == 480.0 {
                resolution = .PhoneStandard
            }
        } else {
            if scale == 2.0 && pixelHeight == 2048.0 {
                resolution = .PadRetina
            } else {
                resolution = .PadStandard
            }
        }
        return resolution
    }
    
}
