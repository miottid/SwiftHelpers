//
//  DateHelper.swift
//  SwiftHelper
//
//  Created by David Miotti on 06/01/2015.
//  Copyright (c) 2015 Muxu.Muxu. All rights reserved.
//

import Foundation

// MARK: - Global vars

///This whole thing is using this calendar, use `setDateHelperCalendar:`
private var CurrentCalendar = Calendar.current

///Use this var when copying dates from components
private let CalendarAllUnits: NSCalendar.Unit =
    [NSCalendar.Unit.era, NSCalendar.Unit.year, NSCalendar.Unit.month, NSCalendar.Unit.day, NSCalendar.Unit.hour, NSCalendar.Unit.minute, NSCalendar.Unit.second, NSCalendar.Unit.calendar, NSCalendar.Unit.timeZone]

// MARK: - Private helpers

public extension Date {
    ///Create a date with specified day and month in the current year
    ///
    ///- parameter day: The day number in the month
    ///- parameter month: The month number starting from 1
    ///
    ///- returns: A Date starting at the beginning of the day
    init(day: Int, month: Int) {
        self.init()
        var comps = (CurrentCalendar as NSCalendar).components(CalendarAllUnits, from: self)
        comps.month = month
        comps.day = day
        comps.hour = 0
        comps.minute = 0
        comps.second = 0
        if let date = CurrentCalendar.date(from: comps) {
            self = date
        }
    }

}

public extension Date {
    var startOfWeek: Date {
        let date = Calendar.current.date(from: Calendar.current.dateComponents([.yearForWeekOfYear, .weekOfYear], from: self))!
        let dslTimeOffset = NSTimeZone.local.daylightSavingTimeOffset(for: date)
        return date.addingTimeInterval(dslTimeOffset)
    }
    
    var endOfWeek: Date {
        return Calendar.current.date(byAdding: .second, value: 604799, to: self.startOfWeek)!
    }
}

public extension TimeInterval {
    var seconds: SHTimeInterval {
        return SHTimeInterval(seconds: toInt)
    }
}

public extension Date {
    /// Convert a this Date object to an NSDate
    ///
    /// - Returns: the NSDate corresponding to the current Date instance
    func toNSDate() -> NSDate {
        return NSDate(timeIntervalSince1970: timeIntervalSince1970)
    }
}

public extension NSDate {
    /// Convert a this NSDate object to an Date
    ///
    /// - Returns: the Date corresponding to the current NSDate instance
    func toDate() -> Date {
        return Date(timeIntervalSince1970: timeIntervalSince1970)
    }
}

// MARK: - TimeInterval Class

///A TimeInterval is an abstract representation of a period
///Because month and year can't be represented directly in seconds
open class SHTimeInterval: Comparable, CustomStringConvertible {
    open var seconds: Int = 0
    open var minutes: Int = 0
    open var hours  : Int = 0
    open var months : Int = 0
    open var days   : Int = 0
    open var years  : Int = 0

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

    ///Prints a user friendly description of an SHTimeInterval
    open var description: String {
        return "\(self.years) years, \(self.months) months, \(self.days) days, \(self.hours) hours, \(self.minutes) minutes, \(self.seconds) seconds"
    }

    ///Create a new date by applying the TimeInterval
    ///
    ///- parameter fromNow: false when you want to remove the time interval from current, true otherwise
    ///- parameter date: the date you want to apply the time interval to. Defaults to the current time and date.
    ///
    ///- returns: A new NSDate by applying the time offset
    fileprivate func offsetDate(fromNow: Bool, date: Date = Date()) -> Date {
        let coef = fromNow ? 1 : -1
        var offsetComponents = DateComponents()
        offsetComponents.second = coef * seconds
        offsetComponents.minute = coef * minutes
        offsetComponents.hour   = coef * hours
        offsetComponents.day    = coef * days
        offsetComponents.month  = coef * months
        offsetComponents.year   = coef * years
        if let date = (CurrentCalendar as NSCalendar).date(byAdding: offsetComponents, to: date, options: NSCalendar.Options(rawValue: 0)) {
            return date
        }
        return Date()
    }

    ///Create a new date by applying the TimeInterval to now in the past
    ///
    ///- returns: A new NSDate by applying the time offset
    open var ago: Date {
        return offsetDate(fromNow: false)
    }

    ///Create a new date by applying the TimeInterval to now in the future
    ///
    ///- returns: A new NSDate by applying the time offset
    open var fromNow: Date {
        return offsetDate(fromNow: true)
    }

    ///Translate the TimeInterval in seconds
    ///
    ///- returns: The total number of seconds this interval contains
    open var inSeconds: TimeInterval {
        var interval: TimeInterval = 0
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
    ///- returns: The total number of minutes this interval contains
    open var inMinutes: TimeInterval {
        var interval: TimeInterval = 0
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
    ///- returns: The total number of hours this interval contains
    open var inHours: TimeInterval {
        var interval: TimeInterval = 0
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
    ///- returns: The total number of days this interval contains
    open var inDays: TimeInterval {
        var interval: TimeInterval = 0
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
public func + (lhs: Date, rhs: TimeInterval) -> Date {
    return lhs.addingTimeInterval(rhs)
}

public func - (lhs: Date, rhs: TimeInterval) -> Date {
    return lhs.addingTimeInterval(-rhs)
}

// Allow operation between NSDate and TimeInterval
public func + (lhs: Date, rhs: SHTimeInterval) -> Date {
    return rhs.offsetDate(fromNow: true, date: lhs)
}

public func - (lhs: Date, rhs: SHTimeInterval) -> Date {
    return rhs.offsetDate(fromNow: false, date: lhs)
}

public func += (lhs: inout Date, rhs: SHTimeInterval) {
    lhs = lhs + rhs
}

public func -= (lhs: inout Date, rhs: SHTimeInterval) {
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

public func += (lhs: inout SHTimeInterval, rhs: SHTimeInterval) {
    lhs = lhs + rhs
}

public func -= (lhs: inout SHTimeInterval, rhs: SHTimeInterval) {
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

public func * (lhs: Int, rhs: SHTimeInterval) -> SHTimeInterval {
    return (lhs * Int(rhs.inSeconds)).seconds
}

// MARK: - Int Extension

public extension Int {
    ///Create a TimeInterval with specified second
    var second : SHTimeInterval { return SHTimeInterval(seconds: self) }
    ///Create a TimeInterval with specified seconds
    var seconds: SHTimeInterval { return second }
    ///Create a TimeInterval with specified minute
    var minute : SHTimeInterval { return SHTimeInterval(minutes: self) }
    ///Create a TimeInterval with specified minutes
    var minutes: SHTimeInterval { return minute }
    ///Create a TimeInterval with specified hour
    var hour   : SHTimeInterval { return SHTimeInterval(hours: self) }
    ///Create a TimeInterval with specified hours
    var hours  : SHTimeInterval { return hour }
    ///Create a TimeInterval with specified day
    var day    : SHTimeInterval { return SHTimeInterval(days: self) }
    ///Create a TimeInterval with specified days
    var days   : SHTimeInterval { return day }
    ///Create a TimeInterval with specified month
    var month  : SHTimeInterval { return SHTimeInterval(months: self) }
    ///Create a TimeInterval with specified months
    var months : SHTimeInterval { return month }
    ///Create a TimeInterval with specified year
    var year   : SHTimeInterval { return SHTimeInterval(years: self) }
    ///Create a TimeInterval with specified years
    var years  : SHTimeInterval { return year }

    ///Create a NSDate with the specified day of january in the current year
    var january  : Date { return Date(day: self, month: 1) }
    ///Create a NSDate with the specified day of febuary in the current year
    var febuary  : Date { return Date(day: self, month: 2) }
    ///Create a NSDate with the specified day of march in the current year
    var march    : Date { return Date(day: self, month: 3) }
    ///Create a NSDate with the specified day of april in the current year
    var april    : Date { return Date(day: self, month: 4) }
    ///Create a NSDate with the specified day of may in the current year
    var may      : Date { return Date(day: self, month: 5) }
    ///Create a NSDate with the specified day of june in the current year
    var june     : Date { return Date(day: self, month: 6) }
    ///Create a NSDate with the specified day of july in the current year
    var july     : Date { return Date(day: self, month: 7) }
    ///Create a NSDate with the specified day of august in the current year
    var august   : Date { return Date(day: self, month: 8) }
    ///Create a NSDate with the specified day of september in the current year
    var september: Date { return Date(day: self, month: 9) }
    ///Create a NSDate with the specified day of october in the current year
    var october  : Date { return Date(day: self, month: 10) }
    ///Create a NSDate with the specified day of november in the current year
    var november : Date { return Date(day: self, month: 11) }
    ///Create a NSDate with the specified day of december in the current year
    var december : Date { return Date(day: self, month: 12) }
}

// MARK: - Date Extension

public extension Date {
    ///Create a new date representing the middle of the day (12:00 PM)
    ///
    ///- returns: A new NSDate representing the middle of the day
    var midday: Date {
        var comps = (CurrentCalendar as NSCalendar).components(CalendarAllUnits, from: self)
        comps.hour = 12
        comps.minute = 0
        comps.second = 0
        return self
    }

    ///Get the weekday
    ///
    ///- returns: The day index of the week, 1 = Sunday
    var weekday: Int {
        let comps = (CurrentCalendar as NSCalendar).components(.weekday, from: self)
        return comps.weekday!
    }

    ///Create a new date representing the end of the current hour
    ///
    ///- returns: A new NSDate representing the end of the current hour
    var endOfHour: Date {
        var comps = (CurrentCalendar as NSCalendar).components(CalendarAllUnits, from: self)
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
    ///- returns: A new NSDate representing the nearest day/month
    var next: Date {
        if Date() <= self {
            return self
        }
        let nowComps = (CurrentCalendar as NSCalendar).components(.year, from: Date())
        var comps = (CurrentCalendar as NSCalendar).components(CalendarAllUnits, from: self)
        comps.year = nowComps.year! + 1
        if let date = CurrentCalendar.date(from: comps) {
            return date
        }
        return Date()
    }

    /// Return a new date representing the nearest hour
    var nearestHour: Date {
        let currentHour = self.hour
        let currentMinutes = self.minute

        var comps = (CurrentCalendar as NSCalendar).components(CalendarAllUnits, from: self)
        if currentMinutes < 30 {
            comps.minute = 0
            if let date = CurrentCalendar.date(from: comps) {
                return date
            }
            return self
        }

        comps.hour = currentHour + 1
        if let date = CurrentCalendar.date(from: comps) {
            return date
        }
        return self
    }

    ///Create a new date 7 days later than the current, in the current calendar
    ///
    ///- returns: A new NSDate by adding 7 days.
    var nextWeek: Date {
        if Date() >= self  {
            return self
        }
        var comps = (CurrentCalendar as NSCalendar).components(CalendarAllUnits, from: self)
        if let days = comps.day {
            comps.day = days + 7
            if let date = CurrentCalendar.date(from: comps) {
                return date
            }
        }
        return self
    }

    ///Create a new date at the beginning of the day, in the current calendar
    ///
    ///- returns: A NSDate with hour, minute and second set to 0
    var beginningOfDay: Date {
        var comps = (CurrentCalendar as NSCalendar).components(CalendarAllUnits, from: self)
        comps.hour = 0
        comps.minute = 0
        comps.second = 0
        if let date = CurrentCalendar.date(from: comps) {
            return date
        }
        return self
    }

    ///Create a new at the begining of the month, in the current calendar
    ///
    ///- returns: A NSDate with day to 1 and hour, minute, second set to 0. If it fail, return the current date
    var beginningOfMonth: Date {
        var comps = (CurrentCalendar as NSCalendar).components([.month, .year], from: self)
        comps.day = 1
        if let date = CurrentCalendar.date(from: comps) {
            return date
        }
        return self
    }

    ///Create a new at the end of the month, in the current calendar
    ///
    ///- returns: A NSDate with day to last day in month and hour, minute, second set to 23:59:59. If it fail, return the current date
    var endOfMonth: Date {
        var comps = (CurrentCalendar as NSCalendar).components([.month, .year], from: self)
        comps.day = self.numberOfDaysInMonth
        comps.hour = 23
        comps.minute = 59
        comps.second = 59
        if let date = CurrentCalendar.date(from: comps) {
            return date
        }
        return self
    }

    ///Returns the day in the current month, using the current calendar
    var day: Int {
        let comps = (CurrentCalendar as NSCalendar).components(.day, from: self)
        return comps.day!
    }

    ///Returns the hour in the current day, using the current calendar
    var hour: Int {
        let comps = (CurrentCalendar as NSCalendar).components(.hour, from: self)
        return comps.hour!
    }

    ///Returns the minute in the current day, using the current calendar
    var minute: Int {
        let comps = (CurrentCalendar as NSCalendar).components(.minute, from: self)
        return comps.minute!
    }

    ///Returns the number of days in the current month
    var numberOfDaysInMonth: Int {
        let days = (CurrentCalendar as NSCalendar).range(of: .day, in: .month, for: self)
        return days.length
    }

    ///Create a new date at the end of the day, in the current calendar
    ///
    ///- returns: A NSDate with hour, minute and second set to 23:59:59
    var endOfDay: Date {
        var comps = (CurrentCalendar as NSCalendar).components(CalendarAllUnits, from: self)
        comps.hour = 23
        comps.minute = 59
        comps.second = 59
        if let date = CurrentCalendar.date(from: comps) {
            return date
        }
        return Date()
    }

    ///Create a new NSDate at the next hour, in the current calendar (ceil)
    ///
    ///- returns: The new created date with 0 minutes and 0 seconds, returns the same date if a fail occur
    var nextHour: Date {
        let unitFlags: NSCalendar.Unit =
            [NSCalendar.Unit.era, NSCalendar.Unit.year, NSCalendar.Unit.month, NSCalendar.Unit.day, NSCalendar.Unit.hour]
        let calendar = Calendar.current
        var comps = (calendar as NSCalendar).components(unitFlags, from: self)
        if let hours = comps.hour {
            comps.hour = hours + 1
        } else {
            comps.hour = 1
        }
        if let date = calendar.date(from: comps) {
            return date
        }
        return self
    }

    ///Check if the current date is in today time range
    ///
    ///- returns: True is the date is in today range
    var isToday: Bool {
        let calendar = Calendar.current
        let components = (calendar as NSCalendar).components([.era, .year, .month, .day], from: Date())
        let otherComponents = (calendar as NSCalendar).components([.era, .year, .month, .day], from: self)
        if let today = calendar.date(from: components) {
            if let other = calendar.date(from: otherComponents) {
                return today.compare(other) == .orderedSame
            }
        }
        return false
    }

    ///Get the day of the beginning of the week starting from Monday
    ///
    ///- returns: The new date representing the first day of the date week
    var beginningOfWeek: Date {
        let calendar = Calendar.current
        var comps = (calendar as NSCalendar).components([.yearForWeekOfYear, .year, .month, .weekOfYear, .weekday], from: self)
        comps.weekday = 2
        return calendar.date(from: comps)!
    }

    ///Create a date with the specified year, in the current calendar
    ///
    ///- parameter year: The year the new date should be of
    ///
    ///- returns: A NSDate with the newly specifed year
    func of(_ year: Int) -> Date {
        var comps = (CurrentCalendar as NSCalendar).components(CalendarAllUnits, from: self)
        comps.year = year
        if let date = CurrentCalendar.date(from: comps) {
            return date
        }
        return Date()
    }

    ///The number of days between the current and provided date
    ///This method return the number of real days between the current
    ///date and the provided one. It does not use 24 hours period to check.
    ///
    ///- parameter the: date to compare
    ///
    ///- returns: The number of days
    func numberOfDays(until nextDate: Date) -> Int? {
        let calendar = Calendar.current as NSCalendar

        var fromDate: NSDate?
        var toDate: NSDate?

        calendar.range(of: .day, start: &fromDate, interval: nil, for: self)
        calendar.range(of: .day, start: &toDate, interval: nil, for: nextDate)

        if let fd = fromDate as Date?, let td = toDate as Date? {
            let fcomps = calendar.components(CalendarAllUnits, from: fd)
            let tcomps = calendar.components(CalendarAllUnits, from: td)
            let comps = calendar.components(NSCalendar.Unit.day, from: fcomps, to: tcomps, options: [])
            return comps.day
        }

        return nil
    }

    ///Check if the provided day is a date in the same day of the current date
    ///This method return true if it's the same day
    ///
    ///- parameter the: date to compare
    ///
    ///- returns: true if it's the same day otherwise returns false
    func isSameDay(_ nextDate: Date) -> Bool {
        return numberOfDays(until: nextDate) == 0
    }

}
