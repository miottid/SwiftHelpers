//
//  SwiftHelpersTests.swift
//  SwiftHelpersTests
//
//  Created by David Miotti on 14/01/2015.
//  Copyright (c) 2015 Wopata. All rights reserved.
//

import UIKit
import XCTest
import SwiftHelpers

class NSDateExtensionTests: XCTestCase {
    
    // MARK: - Test NSDate comparisons
    
    func testGreaterThan() {
        let a = NSDate()
        let b = a.dateByAddingTimeInterval(10)
        XCTAssert(a < b, "a < b")
    }
    
    func testLessThan() {
        let a = NSDate()
        let b = a.dateByAddingTimeInterval(-10)
        XCTAssert(b < a, "b < a")
    }
    
    func testEqual() {
        let a = NSDate()
        let b = a.dateByAddingTimeInterval(0)
        XCTAssert(a == b, "a == b")
    }
    
    func testNotEqual() {
        let a = NSDate()
        let b = a.dateByAddingTimeInterval(1)
        XCTAssert(a != b, "a != b")
    }
    
    func testGreaterThanOrEqual() {
        let a = NSDate()
        let b = a.dateByAddingTimeInterval(0)
        XCTAssert(a >= b, "a >= b")
        let c = a.dateByAddingTimeInterval(10)
        XCTAssert(c >= a, "c >= a")
    }
    
    func testLessThanOrEqual() {
        let a = NSDate()
        let b = a.dateByAddingTimeInterval(0)
        XCTAssert(a <= b, "a <= b")
        let c = a.dateByAddingTimeInterval(-10)
        XCTAssert(c <= a, "c <= a")
    }
    
    // MARK: - Test TimeInterval Class
    
    func testTimeIntervalInitSeconds() {
        let interval = SHTimeInterval(seconds: 10)
        XCTAssert(interval.seconds == 10, "interval.seconds = 10")
        XCTAssert(interval.minutes == 0, "interval.minutes = 0")
        XCTAssert(interval.hours == 0, "interval.hours = 0")
        XCTAssert(interval.days == 0, "interval.days = 0")
        XCTAssert(interval.months == 0, "interval.months = 0")
        XCTAssert(interval.years == 0, "interval.years = 0")
    }
    
    func testTimeIntervalInitMinutes() {
        let interval = SHTimeInterval(minutes: 10)
        XCTAssert(interval.seconds == 0, "interval.seconds = 0")
        XCTAssert(interval.minutes == 10, "interval.minutes = 10")
        XCTAssert(interval.hours == 0, "interval.hours = 0")
        XCTAssert(interval.days == 0, "interval.days = 0")
        XCTAssert(interval.months == 0, "interval.months = 0")
        XCTAssert(interval.years == 0, "interval.years = 0")
    }
    
    func testTimeIntervalInitHours() {
        let interval = SHTimeInterval(hours: 10)
        XCTAssert(interval.seconds == 0, "interval.seconds = 0")
        XCTAssert(interval.minutes == 0, "interval.minutes = 0")
        XCTAssert(interval.hours == 10, "interval.hours = 10")
        XCTAssert(interval.days == 0, "interval.days = 0")
        XCTAssert(interval.months == 0, "interval.months = 0")
        XCTAssert(interval.years == 0, "interval.years = 0")
    }
    
    func testTimeIntervalInitDays() {
        let interval = SHTimeInterval(days: 10)
        XCTAssert(interval.seconds == 0, "interval.seconds = 0")
        XCTAssert(interval.minutes == 0, "interval.minutes = 0")
        XCTAssert(interval.hours == 0, "interval.hours = 0")
        XCTAssert(interval.days == 10, "interval.days = 10")
        XCTAssert(interval.months == 0, "interval.months = 0")
        XCTAssert(interval.years == 0, "interval.years = 0")
    }
    
    func testTimeIntervalInitMonths() {
        let interval = SHTimeInterval(months: 10)
        XCTAssert(interval.seconds == 0, "interval.seconds = 0")
        XCTAssert(interval.minutes == 0, "interval.minutes = 0")
        XCTAssert(interval.hours == 0, "interval.hours = 0")
        XCTAssert(interval.days == 0, "interval.days = 0")
        XCTAssert(interval.months == 10, "interval.months = 10")
        XCTAssert(interval.years == 0, "interval.years = 0")
    }
    
    func testTimeIntervalInitYears() {
        let interval = SHTimeInterval(years: 10)
        XCTAssert(interval.seconds == 0, "interval.seconds = 0")
        XCTAssert(interval.minutes == 0, "interval.minutes = 0")
        XCTAssert(interval.hours == 0, "interval.hours = 0")
        XCTAssert(interval.days == 0, "interval.days = 0")
        XCTAssert(interval.months == 0, "interval.months = 0")
        XCTAssert(interval.years == 10, "interval.years = 10")
    }
    
    func testTimeIntervalInitCustom() {
        let interval = SHTimeInterval()
        interval.seconds = 1
        interval.minutes = 2
        interval.hours = 3
        interval.days = 4
        interval.months = 5
        interval.years = 6
        XCTAssert(interval.seconds == 1, "interval.seconds = 1")
        XCTAssert(interval.minutes == 2, "interval.minutes = 2")
        XCTAssert(interval.hours == 3, "interval.hours = 3")
        XCTAssert(interval.days == 4, "interval.days = 4")
        XCTAssert(interval.months == 5, "interval.months = 5")
        XCTAssert(interval.years == 6, "interval.years = 6")
    }
    
    func testTimeIntervalInSeconds() {
        //seconds
        let fiftyNineSeconds = 59.seconds
        let secondsInSeconds = fiftyNineSeconds.inSeconds
        let expectedSecondsInSeconds = NSTimeInterval(59)
        XCTAssert(secondsInSeconds == expectedSecondsInSeconds, "secondsInSeconds == expectedSecondsInSeconds")
        
        //minutes
        let twentyFourMinutes = 24.minutes
        let minutesInSeconds = twentyFourMinutes.inSeconds
        let expectedMinutesInSeconds = NSTimeInterval(24 * 60)
        XCTAssert(minutesInSeconds == expectedMinutesInSeconds, "minutesInSeconds == expectedMinutesInSeconds")
        
        //hours
        let tenHours = 10.hours
        let hoursInSeconds = tenHours.inSeconds
        let expectedHoursInSeconds = NSTimeInterval(10 * 60 * 60)
        XCTAssert(hoursInSeconds == expectedHoursInSeconds, "hoursInSeconds == expectedHoursInSeconds")
        
        //days
        let tenDays = 10.days
        let daysInSeconds = tenDays.inSeconds
        let expectedDaysInSeconds = NSTimeInterval(10 * 24 * 60 * 60)
        XCTAssert(daysInSeconds == expectedDaysInSeconds, "daysInSeconds == expectedDaysInSeconds")
        
        //months
        let oneMonth = 1.month
        let monthInSeconds = oneMonth.inSeconds
        // here we consider there is 31 days in a month
        let expectedMonthInSeconds = NSTimeInterval(1 * 31 * 24 * 60 * 60)
        XCTAssert(monthInSeconds == expectedMonthInSeconds, "monthInSeconds == expectedMonthInSeconds")
        
        //years
        let twelveYears = 13.years
        let yearsInSeconds = twelveYears.inSeconds
        let expectedYearsInSeconds = NSTimeInterval(13 * 12 * 31 * 24 * 60 * 60)
        XCTAssert(yearsInSeconds == expectedYearsInSeconds, "yearsInSeconds == expectedYearsInSeconds")
    }
    
    func testTimeIntervalInMinutes() {
        //seconds
        let fiftyNineSeconds = 59.seconds
        let secondsInMinutes = fiftyNineSeconds.inMinutes
        let expectedSecondsInMinutes = NSTimeInterval(59.0 / 60.0)
        XCTAssert(secondsInMinutes == expectedSecondsInMinutes, "secondsInMinutes == expectedSecondsInMinutes")
        
        //minutes
        let twentyFourMinutes = 24.minutes
        let minutesInMinutes = twentyFourMinutes.inMinutes
        let expectedMinutesInMinutes = NSTimeInterval(24)
        XCTAssert(minutesInMinutes == expectedMinutesInMinutes, "minutesInMinutes == expectedMinutesInMinutes")
        
        //hours
        let tenHours = 10.hours
        let hoursInMinutes = tenHours.inMinutes
        let expectedHoursInMinutes = NSTimeInterval(10 * 60)
        XCTAssert(hoursInMinutes == expectedHoursInMinutes, "hoursInMinutes == expectedHoursInMinutes")
        
        //days
        let tenDays = 10.days
        let daysInMinutes = tenDays.inMinutes
        let expectedDaysInMinutes = NSTimeInterval(10 * 24 * 60)
        XCTAssert(daysInMinutes == expectedDaysInMinutes, "daysInMinutes == expectedDaysInMinutes")
        
        //months
        let oneMonth = 1.month
        let monthInMinutes = oneMonth.inMinutes
        // here we consider there is 31 days in a month
        let expectedMonthInMinutes = NSTimeInterval(1 * 31 * 24 * 60)
        XCTAssert(monthInMinutes == expectedMonthInMinutes, "monthInMinues == expectedMonthMinues")
        
        //years
        let twelveYears = 13.years
        let yearsInMinutes = twelveYears.inMinutes
        let expectedYearsInMinutes = NSTimeInterval(13 * 12 * 31 * 24 * 60)
        XCTAssert(yearsInMinutes == expectedYearsInMinutes, "yearsInMinues == expectedYearsInMinues")
    }
    
    func testTimeIntervalInHours() {
        //seconds
        let fiftyNineSeconds = 59.seconds
        let secondsInHours = fiftyNineSeconds.inHours
        let expectedSecondsInHours = NSTimeInterval(59.0 / 60.0 / 60.0)
        XCTAssert(secondsInHours == expectedSecondsInHours, "secondsInHours == expectedSecondsInHours")
        
        //minutes
        let twentyFourMinutes = 24.minutes
        let minutesInHours = twentyFourMinutes.inHours
        let expectedMinutesInHours = NSTimeInterval(24.0 / 60.0)
        XCTAssert(minutesInHours == expectedMinutesInHours, "minutesInHours == expectedMinutesInHours")
        
        //hours
        let tenHours = 10.hours
        let hoursInHours = tenHours.inHours
        let expectedHoursInHours = NSTimeInterval(10)
        XCTAssert(hoursInHours == expectedHoursInHours, "hoursInHours == expectedHoursInHours")
        
        //days
        let tenDays = 10.days
        let daysInHours = tenDays.inHours
        let expectedDaysInHours = NSTimeInterval(10 * 24)
        XCTAssert(daysInHours == expectedDaysInHours, "daysInHours == expectedDaysInHours")
        
        //months
        let oneMonth = 1.month
        let monthInHours = oneMonth.inHours
        // here we consider there is 31 days in a month
        let expectedMonthInHours = NSTimeInterval(1 * 31 * 24)
        XCTAssert(monthInHours == expectedMonthInHours, "monthInHours == expectedMonthInHours")
        
        //years
        let twelveYears = 13.years
        let yearsInHours = twelveYears.inHours
        let expectedYearsInHours = NSTimeInterval(13 * 12 * 31 * 24)
        XCTAssert(yearsInHours == expectedYearsInHours, "yearsInHours == expectedYearsInHours")
    }
    
    func testTimeIntervalInDays() {
        //seconds
        let fiftyNineSeconds = 59.seconds
        let secondsInDays = fiftyNineSeconds.inDays
        let expectedSecondsInDays = NSTimeInterval(59.0 / 60.0 / 60.0 / 24.0)
        XCTAssert(secondsInDays == expectedSecondsInDays, "secondsInDays == expectedSecondsInDays")
        
        //minutes
        let twentyFourMinutes = 24.minutes
        let minutesInDays = twentyFourMinutes.inDays
        let expectedMinutesInDays = NSTimeInterval(24.0 / 60.0 / 24.0)
        XCTAssert(minutesInDays == expectedMinutesInDays, "minutesInDays == expectedMinutesInDays")
        
        //hours
        let tenHours = 10.hours
        let hoursInDays = tenHours.inDays
        let expectedHoursInDays = NSTimeInterval(10.0 / 24.0)
        XCTAssert(hoursInDays == expectedHoursInDays, "hoursInDays == expectedHoursInDays")
        
        //days
        let tenDays = 10.days
        let daysInDays = tenDays.inDays
        let expectedDaysInDays = NSTimeInterval(10.0)
        XCTAssert(daysInDays == expectedDaysInDays, "daysInDays == expectedDaysInDays")
        
        //months
        let oneMonth = 1.month
        let monthInDays = oneMonth.inDays
        // here we consider there is 31 days in a month
        let expectedMonthInDays = NSTimeInterval(31.0)
        XCTAssert(monthInDays == expectedMonthInDays, "monthInDays == expectedMonthInDays")
        
        //years
        let twelveYears = 13.years
        let yearsInDays = twelveYears.inDays
        let expectedYearsInDays = NSTimeInterval(13 * 12 * 31)
        XCTAssert(yearsInDays == expectedYearsInDays, "yearsInDays == expectedYearsInDays")
    }
    
    func testTimeIntervalAdd() {
        let interval = 1.month + 10.days + 3.hours + 37.minutes + 5.seconds
        XCTAssert(interval.months == 1, "interval.months == 1")
        XCTAssert(interval.days == 10, "interval.days == 10")
        XCTAssert(interval.hours == 3, "interval.hours == 3")
        XCTAssert(interval.minutes == 37, "interval.minutes == 37")
        XCTAssert(interval.seconds == 5, "interval.seconds == 5")
        let anotherInterval = interval + 25.seconds
        XCTAssert(anotherInterval.months == 1, "anotherInterval.months == 1")
        XCTAssert(anotherInterval.days == 10, "anotherInterval.days == 10")
        XCTAssert(anotherInterval.hours == 3, "anotherInterval.hours == 3")
        XCTAssert(anotherInterval.minutes == 37, "anotherInterval.minutes == 37")
        XCTAssert(anotherInterval.seconds == 30, "anotherInterval.seconds == 30")
    }
    
    func testTimeIntervalMinus() {
        let interval = 1.month - 10.days - 3.hours - 37.minutes - 5.seconds
        XCTAssert(interval.months == 1, "interval.months == -1")
        XCTAssert(interval.days == -10, "interval.days == -10")
        XCTAssert(interval.hours == -3, "interval.hours == -3")
        XCTAssert(interval.minutes == -37, "interval.minutes == -37")
        XCTAssert(interval.seconds == -5, "interval.seconds == -5")
        let anotherInterval = interval - 25.seconds
        XCTAssert(anotherInterval.months == 1, "anotherInterval.months == -1")
        XCTAssert(anotherInterval.days == -10, "anotherInterval.days == -10")
        XCTAssert(anotherInterval.hours == -3, "anotherInterval.hours == -3")
        XCTAssert(anotherInterval.minutes == -37, "anotherInterval.minutes == -37")
        XCTAssert(anotherInterval.seconds == -30, "anotherInterval.seconds == -30")
    }
    
    ///This whole thing is using this calendar, use `setDateHelperCalendar:`
    private var CurrentCalendar = NSCalendar.currentCalendar()
    
    ///Use this var when copying dates from components
    private let CalendarAllUnits: NSCalendarUnit = [.Era, .Year, .Month, .Day, .Hour, .Minute, .Second, .Calendar, .TimeZone]
    
    func testDateOfYear() {
        let date = 16.october.of(1986)
        let comps = CurrentCalendar.components(CalendarAllUnits, fromDate: date)
        XCTAssert(comps.day == 16, "comps.day == 16")
        XCTAssert(comps.month == 10, "comps.month == 10")
        XCTAssert(comps.year == 1986, "comps.year == 1986")
        let of2014 = date.of(2014)
        let compsOf2014 = CurrentCalendar.components(CalendarAllUnits, fromDate: of2014)
        XCTAssert(compsOf2014.year == 2014, "comps.year == 2014")
    }
    
    func testIsToday() {
        let now = NSDate()
        XCTAssert(now.isToday, "now.isToday")
    }
    
    func testBeginningOfDay() {
        let now = NSDate()
        let begin = now.beginningOfDay
        let comps = CurrentCalendar.components(CalendarAllUnits, fromDate: begin)
        XCTAssert(comps.hour == 0, "\(comps.hour) == 0")
        XCTAssert(comps.minute == 0, "\(comps.minute) == 0")
        XCTAssert(comps.second == 0, "\(comps.second) == 0")
    }
    
    func testEndOfDay() {
        let now = NSDate()
        let begin = now.endOfDay
        let comps = CurrentCalendar.components(CalendarAllUnits, fromDate: begin)
        XCTAssert(comps.hour == 23, "\(comps.hour) = 23")
        XCTAssert(comps.minute == 59, "\(comps.minute) == 59")
        XCTAssert(comps.second == 59, "\(comps.second) == 59")
    }
    
    func testNextHour() {
        let testedDate = NSDate()
        let nextHour = testedDate.nextHour
        let calendar = NSCalendar.currentCalendar()
        
        let testedComps = calendar.components(CalendarAllUnits, fromDate: testedDate)
        testedComps.hour += 1
        testedComps.minute = 0
        testedComps.second = 0
        
        let nextHourComps = calendar.components(CalendarAllUnits, fromDate: nextHour)
        
        XCTAssertTrue(testedComps.date == nextHourComps.date, "(\(testedComps.date)) == \(nextHourComps.date)")
    }
    
    func testAddingTimeIntervalToDate() {
        let testedDate = NSDate()
        let testedComponents = CurrentCalendar.components(CalendarAllUnits, fromDate: testedDate)
        
        let interval = 2.months
        let newDate = testedDate + interval
        let newComponents = CurrentCalendar.components(CalendarAllUnits, fromDate: newDate)
        
        XCTAssert(testedComponents.year == newComponents.year, "year should match")
        XCTAssert(testedComponents.month + 2 == newComponents.month, "month should have 2 more than the other")
        XCTAssert(testedComponents.second == newComponents.second, "second should match")
        XCTAssert(testedComponents.day == newComponents.day, "day should match")
    }
    
    func testRemovingTimeIntervalToDate() {
        let testedDate = NSDate()
        let testedComponents = CurrentCalendar.components(CalendarAllUnits, fromDate: testedDate)
        
        let interval = 1.year
        let newDate = testedDate - interval
        let newComponents = CurrentCalendar.components(CalendarAllUnits, fromDate: newDate)
        
        XCTAssert(testedComponents.year - 1 == newComponents.year, "year should match")
        XCTAssert(testedComponents.month == newComponents.month, "month should have 2 more than the other")
        XCTAssert(testedComponents.second == newComponents.second, "second should match")
        XCTAssert(testedComponents.day == newComponents.day, "day should match")
    }
    
    func testSameDay() {
        let date = NSDate().beginningOfDay
        let nextDate = date.dateByAddingTimeInterval(5000)
        let isSameDay = date.isSameDay(nextDate)
        XCTAssert(isSameDay == true, "should be the same day")
        
        let previousDate = date.dateByAddingTimeInterval(-5000)
        let prevIsSameDay = date.isSameDay(previousDate)
        XCTAssert(prevIsSameDay == false, "should not be the same day")
    }
    
}
