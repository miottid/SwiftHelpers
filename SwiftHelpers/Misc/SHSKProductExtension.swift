//
//  SHSKProductExtension.swift
//  SwiftHelpers
//
//  Created by David Miotti on 08/11/2016.
//  Copyright © 2016 Muxu.Muxu. All rights reserved.
//

import Foundation
import StoreKit

public extension SKProduct {
    var localizedPrice: String? {
        let priceFormatter = NumberFormatter()
        priceFormatter.numberStyle = .currency
        priceFormatter.locale = priceLocale
        return priceFormatter.string(from: price)
    }
}
