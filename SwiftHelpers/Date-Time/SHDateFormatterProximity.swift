//
//  SHDateProximity.swift
//  SwiftHelpers
//
//  Created by David Miotti on 30/06/2015.
//  Copyright (c) 2015 Muxu.Muxu. All rights reserved.
//

// Inspired from Atlas-iOS

import Foundation

public enum SHDateProximity {
    case tomorrow, today, yesterday, twoDaysAgo, week, year, other
}

public func SHDateProximityToDate(_ date: Date) -> SHDateProximity {
    
    let calendar = Calendar.current
    let now = Date()
    let calendarUnits: NSCalendar.Unit = [.era, .year, .weekOfMonth, .month, .day]
    let dateComponents = (calendar as NSCalendar).components(calendarUnits, from: date)
    let todayComponents = (calendar as NSCalendar).components(calendarUnits, from: now)
    if dateComponents.day == todayComponents.day &&
        dateComponents.month == todayComponents.month &&
        dateComponents.year == todayComponents.year &&
        dateComponents.era == todayComponents.era {
            return .today
    }
    
    var componentsToYesterDay = DateComponents()
    componentsToYesterDay.day = -1
    if let yesterday = (calendar as NSCalendar).date(byAdding: componentsToYesterDay, to: now, options: []) {
        let yesterdayComponents = (calendar as NSCalendar).components(calendarUnits, from: yesterday)
        if dateComponents.day == yesterdayComponents.day &&
            dateComponents.month == yesterdayComponents.month &&
            dateComponents.year == yesterdayComponents.year &&
            dateComponents.era == yesterdayComponents.era {
                return .yesterday
        }
    }
    
    var componentsToTomorrow = DateComponents()
    componentsToTomorrow.day = 1
    if let tomorrow = (calendar as NSCalendar).date(byAdding: componentsToTomorrow, to: now, options: []) {
        let tomorrowComponents = (calendar as NSCalendar).components(calendarUnits, from: tomorrow)
        if dateComponents.day == tomorrowComponents.day &&
            dateComponents.month == tomorrowComponents.month &&
            dateComponents.year == tomorrowComponents.year &&
            dateComponents.era == tomorrowComponents.era {
            return .tomorrow
        }
    }
    
    var componentsToTwoDaysAgo = DateComponents()
    componentsToTwoDaysAgo.day = -2
    if let yesterday = (calendar as NSCalendar).date(byAdding: componentsToTwoDaysAgo, to: now, options: []) {
        let twoDaysAgoComponents = (calendar as NSCalendar).components(calendarUnits, from: yesterday)
        if dateComponents.day == twoDaysAgoComponents.day &&
            dateComponents.month == twoDaysAgoComponents.month &&
            dateComponents.year == twoDaysAgoComponents.year &&
            dateComponents.era == twoDaysAgoComponents.era {
            return .twoDaysAgo
        }
    }
    
    if dateComponents.weekOfMonth == todayComponents.weekOfMonth &&
        dateComponents.month == todayComponents.month &&
        dateComponents.year == todayComponents.year &&
        dateComponents.era == todayComponents.era {
            return .week
    }
    
    if dateComponents.year == todayComponents.year &&
        dateComponents.era == todayComponents.era {
            return .year
    }
    
    return .other;
}

public var SHShortTimeFormatter: DateFormatter {
    let df = DateFormatter()
    df.timeStyle = .short
    return df
}

public var SHDayOfWeekDateFormatter: DateFormatter {
    let df = DateFormatter()
    df.dateFormat = "EEEE"
    return df
}

public var SHRelativeDateFormatter: DateFormatter {
    let df = DateFormatter()
    df.timeStyle = .medium
    return df
}

public var SHThisYearDateFormatter: DateFormatter {
    let df = DateFormatter()
    df.dateFormat = "E, MMM dd,"
    return df
}

public var SHDefaultDateFormatter: DateFormatter {
    let df = DateFormatter()
    df.dateFormat = "MMM dd, yyyy,"
    return df
}
