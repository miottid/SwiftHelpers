//
//  SHDateProximity.swift
//  SwiftHelpers
//
//  Created by David Miotti on 30/06/2015.
//  Copyright (c) 2015 Wopata. All rights reserved.
//

// Inspired from Atlas-iOS

import UIKit

public enum SHDateProximity {
    case Today, Yesterday, Week, Year, Other
}

public func SHDateProximityToDate(date: NSDate) -> SHDateProximity {
    
    let calendar = NSCalendar.currentCalendar()
    let now = NSDate()
    let calendarUnits: NSCalendarUnit = .CalendarUnitEra | .CalendarUnitYear | .CalendarUnitWeekOfMonth | .CalendarUnitMonth | .CalendarUnitDay
    let dateComponents = calendar.components(calendarUnits, fromDate: date)
    let todayComponents = calendar.components(calendarUnits, fromDate: now)
    if dateComponents.day == todayComponents.day &&
        dateComponents.month == todayComponents.month &&
        dateComponents.year == todayComponents.year &&
        dateComponents.era == todayComponents.era {
            return .Today
    }
    
    let componentsToYesterDay = NSDateComponents()
    componentsToYesterDay.day = -1
    if let yesterday = calendar.dateByAddingComponents(componentsToYesterDay, toDate: now, options: .allZeros) {
        let yesterdayComponents = calendar.components(calendarUnits, fromDate: yesterday)
        if dateComponents.day == yesterdayComponents.day &&
            dateComponents.month == yesterdayComponents.month &&
            dateComponents.year == yesterdayComponents.year &&
            dateComponents.era == yesterdayComponents.era {
                return .Yesterday
        }
    }
    
    if dateComponents.weekOfMonth == todayComponents.weekOfMonth &&
        dateComponents.month == todayComponents.month &&
        dateComponents.year == todayComponents.year &&
        dateComponents.era == todayComponents.era {
            return .Week
    }
    
    if dateComponents.year == todayComponents.year &&
        dateComponents.era == todayComponents.era {
            return .Year
    }
    
    return .Other;
}

public var SHShortTimeFormatter: NSDateFormatter {
    struct Static {
        static var onceToken: dispatch_once_t = 0
        static var instance: NSDateFormatter? = nil
    }
    dispatch_once(&Static.onceToken) {
        Static.instance = NSDateFormatter()
        Static.instance!.timeStyle = .ShortStyle
    }
    return Static.instance!
}

public var SHDayOfWeekDateFormatter: NSDateFormatter {
    struct Static {
        static var onceToken: dispatch_once_t = 0
        static var instance: NSDateFormatter? = nil
    }
    dispatch_once(&Static.onceToken) {
        Static.instance = NSDateFormatter()
        Static.instance!.dateFormat = "EEEE"
    }
    return Static.instance!
}

public var SHRelativeDateFormatter: NSDateFormatter {
    struct Static {
        static var onceToken: dispatch_once_t = 0
        static var instance: NSDateFormatter? = nil
    }
    dispatch_once(&Static.onceToken) {
        Static.instance = NSDateFormatter()
        Static.instance!.dateStyle = .MediumStyle
        Static.instance!.doesRelativeDateFormatting = true
    }
    return Static.instance!
}

public var SHThisYearDateFormatter: NSDateFormatter {
    struct Static {
        static var onceToken: dispatch_once_t = 0
        static var instance: NSDateFormatter? = nil
    }
    dispatch_once(&Static.onceToken) {
        Static.instance = NSDateFormatter()
        Static.instance!.dateFormat = "E, MMM dd,"
    }
    return Static.instance!
}

public var SHDefaultDateFormatter: NSDateFormatter {
    struct Static {
        static var onceToken: dispatch_once_t = 0
        static var instance: NSDateFormatter? = nil
    }
    dispatch_once(&Static.onceToken) {
        Static.instance = NSDateFormatter()
        Static.instance!.dateFormat = "MMM dd, yyyy,"
    }
    return Static.instance!
}
