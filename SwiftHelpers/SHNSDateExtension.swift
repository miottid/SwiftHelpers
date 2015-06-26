//
//  DateHelper.swift
//  SwiftHelper
//
//  Created by David Miotti on 06/01/2015.
//  Copyright (c) 2015 Wopata. All rights reserved.
//

import UIKit

// MARK: - NSDate comparison

public func > (lhs: NSDate, rhs: NSDate) -> Bool {
    return lhs.compare(rhs) == .OrderedDescending
}

public func < (lhs: NSDate, rhs: NSDate) -> Bool {
    return lhs.compare(rhs) == .OrderedAscending
}

public func == (lhs: NSDate, rhs: NSDate) -> Bool {
    return lhs.compare(rhs) == .OrderedSame
}

public func != (lhs: NSDate, rhs: NSDate) -> Bool {
    return lhs.compare(rhs) != .OrderedSame
}

public func >= (lhs: NSDate, rhs: NSDate) -> Bool {
    return lhs > rhs || lhs == rhs
}

public func <= (lhs: NSDate, rhs: NSDate) -> Bool {
    return lhs < rhs || lhs == rhs
}

// MARK: - Global vars

///This whole thing is using this calendar, use `setDateHelperCalendar:`
private var CurrentCalendar = NSCalendar.currentCalendar()

///Use this var when copying dates from components
private let CalendarAllUnits =
    NSCalendarUnit.CalendarUnitEra      |
    NSCalendarUnit.CalendarUnitYear     |
    NSCalendarUnit.CalendarUnitMonth    |
    NSCalendarUnit.CalendarUnitDay      |
    NSCalendarUnit.CalendarUnitHour     |
    NSCalendarUnit.CalendarUnitMinute   |
    NSCalendarUnit.CalendarUnitSecond   |
    NSCalendarUnit.CalendarUnitCalendar |
    NSCalendarUnit.CalendarUnitTimeZone

// MARK: - Private helpers

///Create a date with specified day and month in the current year
///
///:param: day The day number in the month
///:param: month The month number starting from 1
///
///:returns: A NSDate starting at the beginning of the day
private func dateWithDayAndMonth(day: Int, month: Int) -> NSDate {
    let comps = CurrentCalendar.components(CalendarAllUnits, fromDate: NSDate())
    comps.month = month
    comps.day = day
    comps.hour = 0
    comps.minute = 0
    comps.second = 0
    if let date = CurrentCalendar.dateFromComponents(comps) {
        return date
    }
    return NSDate()
}

// MARK: - TimeInterval Class

///A TimeInterval is an abstract representation of a period
///Because month and year can't be represented directly in seconds
public class SHTimeInterval {
    public var seconds: Int = 0
    public var minutes: Int = 0
    public var hours  : Int = 0
    public var months : Int = 0
    public var days   : Int = 0
    public var years  : Int = 0
    
    ///Create an empty TimeInterval
    public init(){}
    
    ///Create a TimeInterval with the specified seconds
    public init(seconds: Int) { self.seconds = seconds }
    
    ///Create a TimeInterval with the specified minutes
    public init(minutes: Int) { self.minutes = minutes }
    
    ///Create a TimeInterval with the specified hours
    public init(hours: Int) { self.hours = hours }
    
    ///Create a TimeInterval with the specified days
    public init(days: Int) { self.days = days }
    
    ///Create a TimeInterval with the specified months
    public init(months: Int) { self.months = months }
    
    ///Create a TimeInterval with the specified years
    public init(years: Int) { self.years = years }
    
    ///Create a new date by applying the TimeInterval
    ///
    ///:param: fromNow false when you want to remove the time interval from current, true otherwise
    ///
    ///:returns: A new NSDate by applying the time offset
    private func offsetDate(fromNow: Bool) -> NSDate {
        let coef = fromNow ? 1 : -1
        let offsetComponents = NSDateComponents()
        offsetComponents.second = coef * seconds
        offsetComponents.minute = coef * minutes
        offsetComponents.hour   = coef * hours
        offsetComponents.day    = coef * days
        offsetComponents.month  = coef * months
        offsetComponents.year   = coef * years
        if let date = CurrentCalendar.dateByAddingComponents(offsetComponents, toDate: NSDate(), options: NSCalendarOptions(0)) {
            return date
        }
        return NSDate()
    }
    
    ///Create a new date by applying the TimeInterval to now in the past
    ///
    ///:returns: A new NSDate by applying the time offset
    public var ago: NSDate {
        return offsetDate(false)
    }
    
    ///Create a new date by applying the TimeInterval to now in the future
    ///
    ///:returns: A new NSDate by applying the time offset
    public var fromNow: NSDate {
        return offsetDate(true)
    }
    
    ///Translate the TimeInterval in seconds
    ///
    ///:returns: The total number of seconds this interval contains
    public var inSeconds: NSTimeInterval {
        var interval: NSTimeInterval = 0
        interval += Double(seconds)
        interval += Double(minutes) * 60.0
        interval += Double(hours)   * 60.0 * 60.0
        interval += Double(days)    * 60.0 * 60.0 * 24.0
        interval += Double(months)  * 60.0 * 60.0 * 24.0 * 31.0
        interval += Double(years)   * 60.0 * 60.0 * 24.0 * 31.0 * 12.0
        return interval
    }
    
    ///Translate the TimeInterval in minutes
    ///
    ///:returns: The total number of minutes this interval contains
    public var inMinutes: NSTimeInterval {
        var interval: NSTimeInterval = 0
        interval += Double(seconds) / 60.0
        interval += Double(minutes)
        interval += Double(hours)   * 60.0
        interval += Double(days)    * 60.0 * 24.0
        interval += Double(months)  * 60.0 * 24.0 * 31.0
        interval += Double(years)   * 60.0 * 24.0 * 31.0 * 12.0
        return interval
    }
    
    ///Translate the TimeInterval in hours
    ///
    ///:returns: The total number of hours this interval contains
    public var inHours: NSTimeInterval {
        var interval: NSTimeInterval = 0
        interval += Double(seconds) / 60.0 / 60.0
        interval += Double(minutes) / 60.0
        interval += Double(hours)
        interval += Double(days)    * 24.0
        interval += Double(months)  * 24.0 * 31.0
        interval += Double(years)   * 24.0 * 31.0 * 12.0
        return interval
    }
    
    ///Translate the TimeInterval in hours
    ///
    ///:returns: The total number of days this interval contains
    public var inDays: NSTimeInterval {
        var interval: NSTimeInterval = 0
        interval += Double(seconds) / 60.0 / 60.0 / 24.0
        interval += Double(minutes) / 60.0 / 24.0
        interval += Double(hours)   / 24.0
        interval += Double(days)
        interval += Double(months)  * 31.0
        interval += Double(years)   * 31.0 * 12.0
        return interval
    }
    
}

// MARK: TimeInterval Operators

// Allow operations between NSDate with NSTimeInterval
public func + (lhs: NSDate, rhs: NSTimeInterval) -> NSDate {
    return lhs.dateByAddingTimeInterval(rhs)
}

public func - (lhs: NSDate, rhs: NSTimeInterval) -> NSDate {
    return lhs.dateByAddingTimeInterval(-rhs)
}

public func += (inout lhs: NSDate, rhs: NSTimeInterval) {
    lhs = NSDate(timeIntervalSince1970: lhs.timeIntervalSince1970 + rhs)
}

public func -= (inout lhs: NSDate, rhs: NSTimeInterval) {
    lhs = NSDate(timeIntervalSince1970: lhs.timeIntervalSince1970 - rhs)
}

// Allow operation between NSDate and TimeInterval
public func + (lhs: NSDate, rhs: SHTimeInterval) -> NSDate {
    return lhs + rhs.inSeconds
}

public func - (lhs: NSDate, rhs: SHTimeInterval) -> NSDate {
    return lhs - rhs.inSeconds
}

public func += (inout lhs: NSDate, rhs: SHTimeInterval) {
    lhs = lhs + rhs
}

public func -= (inout lhs: NSDate, rhs: SHTimeInterval) {
    lhs = lhs - rhs
}

public func + (lhs: SHTimeInterval, rhs: SHTimeInterval) -> SHTimeInterval {
    let timeInterval = SHTimeInterval()
    timeInterval.seconds = lhs.seconds + rhs.seconds
    timeInterval.minutes = lhs.minutes + rhs.minutes
    timeInterval.hours   = lhs.hours + rhs.hours
    timeInterval.days    = lhs.days + rhs.days
    timeInterval.months  = lhs.months + rhs.months
    timeInterval.years   = lhs.years + rhs.years
    return timeInterval
}

public func - (lhs: SHTimeInterval, rhs: SHTimeInterval) -> SHTimeInterval {
    let timeInterval = SHTimeInterval()
    timeInterval.seconds = lhs.seconds - rhs.seconds
    timeInterval.minutes = lhs.minutes - rhs.minutes
    timeInterval.hours   = lhs.hours - rhs.hours
    timeInterval.days    = lhs.days - rhs.days
    timeInterval.months  = lhs.months - rhs.months
    timeInterval.years   = lhs.years - rhs.years
    return timeInterval
}

public func += (inout lhs: SHTimeInterval, rhs: SHTimeInterval) {
    lhs = lhs + rhs
}

public func -= (inout lhs: SHTimeInterval, rhs: SHTimeInterval) {
    lhs = lhs - rhs
}

public func == (lhs: SHTimeInterval, rhs: SHTimeInterval) -> Bool {
    return lhs.inSeconds == rhs.inSeconds
}

public func > (lhs: SHTimeInterval, rhs: SHTimeInterval) -> Bool {
    return lhs.inSeconds > rhs.inSeconds
}

public func < (lhs: SHTimeInterval, rhs: SHTimeInterval) -> Bool {
    return lhs.inSeconds < rhs.inSeconds
}

public func >= (lhs: SHTimeInterval, rhs: SHTimeInterval) -> Bool {
    return lhs.inSeconds >= rhs.inSeconds
}

public func <= (lhs: SHTimeInterval, rhs: SHTimeInterval) -> Bool {
    return lhs.inSeconds <= rhs.inSeconds
}

// MARK: - Int Extension

public extension Int {
    ///Create a TimeInterval with specified second
    public var second : SHTimeInterval { return SHTimeInterval(seconds: self) }
    ///Create a TimeInterval with specified seconds
    public var seconds: SHTimeInterval { return second }
    ///Create a TimeInterval with specified minute
    public var minute : SHTimeInterval { return SHTimeInterval(minutes: self) }
    ///Create a TimeInterval with specified minutes
    public var minutes: SHTimeInterval { return minute }
    ///Create a TimeInterval with specified hour
    public var hour   : SHTimeInterval { return SHTimeInterval(hours: self) }
    ///Create a TimeInterval with specified hours
    public var hours  : SHTimeInterval { return hour }
    ///Create a TimeInterval with specified day
    public var day    : SHTimeInterval { return SHTimeInterval(days: self) }
    ///Create a TimeInterval with specified days
    public var days   : SHTimeInterval { return day }
    ///Create a TimeInterval with specified month
    public var month  : SHTimeInterval { return SHTimeInterval(months: self) }
    ///Create a TimeInterval with specified months
    public var months : SHTimeInterval { return month }
    ///Create a TimeInterval with specified year
    public var year   : SHTimeInterval { return SHTimeInterval(years: self) }
    ///Create a TimeInterval with specified years
    public var years  : SHTimeInterval { return year }
    
    ///Create a NSDate with the specified day of january in the current year
    public var january  : NSDate { return dateWithDayAndMonth(self, 1) }
    ///Create a NSDate with the specified day of febuary in the current year
    public var febuary  : NSDate { return dateWithDayAndMonth(self, 2) }
    ///Create a NSDate with the specified day of march in the current year
    public var march    : NSDate { return dateWithDayAndMonth(self, 3) }
    ///Create a NSDate with the specified day of april in the current year
    public var april    : NSDate { return dateWithDayAndMonth(self, 4) }
    ///Create a NSDate with the specified day of may in the current year
    public var may      : NSDate { return dateWithDayAndMonth(self, 5) }
    ///Create a NSDate with the specified day of june in the current year
    public var june     : NSDate { return dateWithDayAndMonth(self, 6) }
    ///Create a NSDate with the specified day of july in the current year
    public var july     : NSDate { return dateWithDayAndMonth(self, 7) }
    ///Create a NSDate with the specified day of august in the current year
    public var august   : NSDate { return dateWithDayAndMonth(self, 8) }
    ///Create a NSDate with the specified day of september in the current year
    public var september: NSDate { return dateWithDayAndMonth(self, 9) }
    ///Create a NSDate with the specified day of october in the current year
    public var october  : NSDate { return dateWithDayAndMonth(self, 10) }
    ///Create a NSDate with the specified day of november in the current year
    public var november : NSDate { return dateWithDayAndMonth(self, 11) }
    ///Create a NSDate with the specified day of december in the current year
    public var december : NSDate { return dateWithDayAndMonth(self, 12) }
}

// MARK: - Date Extension

public extension NSDate {
    ///Create a new date representing the middle of the day (12:00 PM)
    ///
    ///:returns: A new NSDate representing the middle of the day
    public var midday: NSDate {
        let comps = CurrentCalendar.components(CalendarAllUnits, fromDate: self)
        comps.hour = 12
        comps.minute = 0
        comps.second = 0
        return self
    }
    
    ///Get the weekday
    ///
    ///:returns: The day index of the week, 1 = Sunday
    public var weekday: Int {
        let comps = CurrentCalendar.components(.CalendarUnitWeekday, fromDate: self)
        return comps.weekday
    }
    
    ///Create a new date representing the end of the current hour
    ///
    ///:returns: A new NSDate representing the end of the current hour
    public var endOfHour: NSDate {
        let comps = CurrentCalendar.components(CalendarAllUnits, fromDate: self)
        comps.minute = 59
        comps.second = 59
        return self
    }
    
    ///Create a new date representing the next day/month of the
    ///current date
    ///For exemple:
    /// let dateOfBirth = 16.october.of(1986)
    /// let nextBirthday = dateOfBirth.next
    ///
    ///:returns: A new NSDate representing the nearest day/month
    public var next: NSDate {
        if self > NSDate() {
            return self
        }
        let nowComps = CurrentCalendar.components(.CalendarUnitYear, fromDate: NSDate())
        let comps = CurrentCalendar.components(CalendarAllUnits, fromDate: self)
        comps.year = nowComps.year + 1
        if let date = CurrentCalendar.dateFromComponents(comps) {
            return date
        }
        return NSDate()
    }
    
    ///Create a new date 7 days later than the current, in the current calendar
    ///
    ///:returns: A new NSDate by adding 7 days.
    public var nextWeek: NSDate {
        if self > NSDate() {
            return self
        }
        let comps = CurrentCalendar.components(CalendarAllUnits, fromDate: self)
        comps.day += 7
        if let date = CurrentCalendar.dateFromComponents(comps) {
            return date
        }
        return self
    }
    
    ///Create a new date at the beginning of the day, in the current calendar
    ///
    ///:returns: A NSDate with hour, minute and second set to 0
    public var beginningOfDay: NSDate {
        let comps = CurrentCalendar.components(CalendarAllUnits, fromDate: self)
        comps.hour = 0
        comps.minute = 0
        comps.second = 0
        if let date = CurrentCalendar.dateFromComponents(comps) {
            return date
        }
        return self
    }
    
    ///Create a new at the begining of the month, in the current calendar
    ///
    ///:returns: A NSDate with day to 1 and hour, minute, second set to 0. If it fail, return the current date
    public var beginningOfMonth: NSDate {
        let comps = CurrentCalendar.components(.CalendarUnitMonth | .CalendarUnitYear, fromDate: self)
        comps.day = 1
        if let date = CurrentCalendar.dateFromComponents(comps) {
            return date
        }
        return self
    }
    
    ///Create a new at the end of the month, in the current calendar
    ///
    ///:returns: A NSDate with day to last day in month and hour, minute, second set to 23:59:59. If it fail, return the current date
    public var endOfMonth: NSDate {
        let comps = CurrentCalendar.components(.CalendarUnitMonth | .CalendarUnitYear, fromDate: self)
        comps.day = self.numberOfDaysInMonth
        comps.hour = 23
        comps.minute = 59
        comps.second = 59
        if let date = CurrentCalendar.dateFromComponents(comps) {
            return date
        }
        return self
    }
    
    ///Returns the day in the current month, using the current calendar
    public var day: Int {
        let comps = CurrentCalendar.components(.CalendarUnitDay, fromDate: self)
        return comps.day
    }
    
    ///Returns the hour in the current day, using the current calendar
    public var hour: Int {
        let comps = CurrentCalendar.components(.CalendarUnitHour, fromDate: self)
        return comps.hour
    }
    
    ///Returns the number of days in the current month
    public var numberOfDaysInMonth: Int {
        let days = CurrentCalendar.rangeOfUnit(.CalendarUnitDay, inUnit: .CalendarUnitMonth, forDate: self)
        return days.length
    }
    
    ///Create a new date at the end of the day, in the current calendar
    ///
    ///:returns: A NSDate with hour, minute and second set to 23:59:59
    public var endOfDay: NSDate {
        let comps = CurrentCalendar.components(CalendarAllUnits, fromDate: self)
        comps.hour = 23
        comps.minute = 59
        comps.second = 59
        if let date = CurrentCalendar.dateFromComponents(comps) {
            return date
        }
        return NSDate()
    }
    
    ///Create a new NSDate at the next hour, in the current calendar (ceil)
    ///
    ///:returns: The new created date with 0 minutes and 0 seconds, returns the same date if a fail occur
    public var nextHour: NSDate {
        let unitFlags =
            NSCalendarUnit.CalendarUnitEra      |
            NSCalendarUnit.CalendarUnitYear     |
            NSCalendarUnit.CalendarUnitMonth    |
            NSCalendarUnit.CalendarUnitDay      |
            NSCalendarUnit.CalendarUnitHour
        let calendar = NSCalendar.currentCalendar()
        let comps = calendar.components(unitFlags, fromDate: self)
        comps.hour += 1
        if let date = calendar.dateFromComponents(comps) {
            return date
        }
        return self
    }
    
    ///Check if the current date is in today time range
    ///
    ///:returns: True is the date is in today range
    public var isToday: Bool {
        let calendar = NSCalendar.currentCalendar()
        let components = calendar.components(.CalendarUnitEra | .CalendarUnitYear | .CalendarUnitMonth | .CalendarUnitDay, fromDate: NSDate())
        let otherComponents = calendar.components(.CalendarUnitEra | .CalendarUnitYear | .CalendarUnitMonth | .CalendarUnitDay, fromDate: self)
        if let today = calendar.dateFromComponents(components) {
            if let other = calendar.dateFromComponents(otherComponents) {
                return today.isEqualToDate(other)
            }
        }
        return false
    }
    
    ///Create a date with the specified year, in the current calendar
    ///
    ///:param: year The year the new date should be of
    ///
    ///:returns: A NSDate with the newly specifed year
    public func of(year: Int) -> NSDate {
        let comps = CurrentCalendar.components(CalendarAllUnits, fromDate: self)
        comps.year = year
        if let date = CurrentCalendar.dateFromComponents(comps) {
            return date
        }
        return NSDate()
    }
    
    ///The number of days between the current and provided date
    ///This method return the number of real days between the current
    ///date and the provided one. It does not use 24 hours period to check.
    ///
    ///:param: the date to compare
    ///
    ///:returns: The number of days
    public func numberOfDays(nextDate: NSDate) -> Int? {
        let calendar = NSCalendar.currentCalendar()
        
        var fromDate: NSDate?
        var toDate: NSDate?
        
        calendar.rangeOfUnit(.CalendarUnitDay, startDate: &fromDate, interval: nil, forDate: self)
        calendar.rangeOfUnit(.CalendarUnitDay, startDate: &toDate, interval: nil, forDate: nextDate)
    
        if let fd = fromDate {
            if let td = toDate {
                let components = calendar.components(.CalendarUnitDay, fromDate: fd, toDate: td, options: nil)
                return components.day
            }
        }
        
        return nil
    }
    
}
