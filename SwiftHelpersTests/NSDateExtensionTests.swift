//
//  SwiftHelpersTests.swift
//  SwiftHelpersTests
//
//  Created by David Miotti on 14/01/2015.
//  Copyright (c) 2015 Muxu.Muxu. All rights reserved.
//

import Foundation
import XCTest
import SwiftHelpers

class NSDateExtensionTests: XCTestCase {
    
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
        let expectedSecondsInSeconds = TimeInterval(59)
        XCTAssert(secondsInSeconds == expectedSecondsInSeconds, "secondsInSeconds == expectedSecondsInSeconds")
        
        //minutes
        let twentyFourMinutes = 24.minutes
        let minutesInSeconds = twentyFourMinutes.inSeconds
        let expectedMinutesInSeconds = TimeInterval(24 * 60)
        XCTAssert(minutesInSeconds == expectedMinutesInSeconds, "minutesInSeconds == expectedMinutesInSeconds")
        
        //hours
        let tenHours = 10.hours
        let hoursInSeconds = tenHours.inSeconds
        let expectedHoursInSeconds = TimeInterval(10 * 60 * 60)
        XCTAssert(hoursInSeconds == expectedHoursInSeconds, "hoursInSeconds == expectedHoursInSeconds")
        
        //days
        let tenDays = 10.days
        let daysInSeconds = tenDays.inSeconds
        let expectedDaysInSeconds = TimeInterval(10 * 24 * 60 * 60)
        XCTAssert(daysInSeconds == expectedDaysInSeconds, "daysInSeconds == expectedDaysInSeconds")
        
        //months
        let oneMonth = 1.month
        let monthInSeconds = oneMonth.inSeconds
        // here we consider there is 31 days in a month
        let expectedMonthInSeconds = TimeInterval(1 * 31 * 24 * 60 * 60)
        XCTAssert(monthInSeconds == expectedMonthInSeconds, "monthInSeconds == expectedMonthInSeconds")
        
        //years
        let twelveYears = 13.years
        let yearsInSeconds = twelveYears.inSeconds
        let expectedYearsInSeconds = TimeInterval(13 * 12 * 31 * 24 * 60 * 60)
        XCTAssert(yearsInSeconds == expectedYearsInSeconds, "yearsInSeconds == expectedYearsInSeconds")
    }
    
    func testTimeIntervalInMinutes() {
        //seconds
        let fiftyNineSeconds = 59.seconds
        let secondsInMinutes = fiftyNineSeconds.inMinutes
        let expectedSecondsInMinutes = TimeInterval(59.0 / 60.0)
        XCTAssert(secondsInMinutes == expectedSecondsInMinutes, "secondsInMinutes == expectedSecondsInMinutes")
        
        //minutes
        let twentyFourMinutes = 24.minutes
        let minutesInMinutes = twentyFourMinutes.inMinutes
        let expectedMinutesInMinutes = TimeInterval(24)
        XCTAssert(minutesInMinutes == expectedMinutesInMinutes, "minutesInMinutes == expectedMinutesInMinutes")
        
        //hours
        let tenHours = 10.hours
        let hoursInMinutes = tenHours.inMinutes
        let expectedHoursInMinutes = TimeInterval(10 * 60)
        XCTAssert(hoursInMinutes == expectedHoursInMinutes, "hoursInMinutes == expectedHoursInMinutes")
        
        //days
        let tenDays = 10.days
        let daysInMinutes = tenDays.inMinutes
        let expectedDaysInMinutes = TimeInterval(10 * 24 * 60)
        XCTAssert(daysInMinutes == expectedDaysInMinutes, "daysInMinutes == expectedDaysInMinutes")
        
        //months
        let oneMonth = 1.month
        let monthInMinutes = oneMonth.inMinutes
        // here we consider there is 31 days in a month
        let expectedMonthInMinutes = TimeInterval(1 * 31 * 24 * 60)
        XCTAssert(monthInMinutes == expectedMonthInMinutes, "monthInMinues == expectedMonthMinues")
        
        //years
        let twelveYears = 13.years
        let yearsInMinutes = twelveYears.inMinutes
        let expectedYearsInMinutes = TimeInterval(13 * 12 * 31 * 24 * 60)
        XCTAssert(yearsInMinutes == expectedYearsInMinutes, "yearsInMinues == expectedYearsInMinues")
    }
    
    func testTimeIntervalInHours() {
        //seconds
        let fiftyNineSeconds = 59.seconds
        let secondsInHours = fiftyNineSeconds.inHours
        let expectedSecondsInHours = TimeInterval(59.0 / 60.0 / 60.0)
        XCTAssert(secondsInHours == expectedSecondsInHours, "secondsInHours == expectedSecondsInHours")
        
        //minutes
        let twentyFourMinutes = 24.minutes
        let minutesInHours = twentyFourMinutes.inHours
        let expectedMinutesInHours = TimeInterval(24.0 / 60.0)
        XCTAssert(minutesInHours == expectedMinutesInHours, "minutesInHours == expectedMinutesInHours")
        
        //hours
        let tenHours = 10.hours
        let hoursInHours = tenHours.inHours
        let expectedHoursInHours = TimeInterval(10)
        XCTAssert(hoursInHours == expectedHoursInHours, "hoursInHours == expectedHoursInHours")
        
        //days
        let tenDays = 10.days
        let daysInHours = tenDays.inHours
        let expectedDaysInHours = TimeInterval(10 * 24)
        XCTAssert(daysInHours == expectedDaysInHours, "daysInHours == expectedDaysInHours")
        
        //months
        let oneMonth = 1.month
        let monthInHours = oneMonth.inHours
        // here we consider there is 31 days in a month
        let expectedMonthInHours = TimeInterval(1 * 31 * 24)
        XCTAssert(monthInHours == expectedMonthInHours, "monthInHours == expectedMonthInHours")
        
        //years
        let twelveYears = 13.years
        let yearsInHours = twelveYears.inHours
        let expectedYearsInHours = TimeInterval(13 * 12 * 31 * 24)
        XCTAssert(yearsInHours == expectedYearsInHours, "yearsInHours == expectedYearsInHours")
    }
    
    func testTimeIntervalInDays() {
        //seconds
        let fiftyNineSeconds = 59.seconds
        let secondsInDays = fiftyNineSeconds.inDays
        let expectedSecondsInDays = TimeInterval(59.0 / 60.0 / 60.0 / 24.0)
        XCTAssert(secondsInDays == expectedSecondsInDays, "secondsInDays == expectedSecondsInDays")
        
        //minutes
        let twentyFourMinutes = 24.minutes
        let minutesInDays = twentyFourMinutes.inDays
        let expectedMinutesInDays = TimeInterval(24.0 / 60.0 / 24.0)
        XCTAssert(minutesInDays == expectedMinutesInDays, "minutesInDays == expectedMinutesInDays")
        
        //hours
        let tenHours = 10.hours
        let hoursInDays = tenHours.inDays
        let expectedHoursInDays = TimeInterval(10.0 / 24.0)
        XCTAssert(hoursInDays == expectedHoursInDays, "hoursInDays == expectedHoursInDays")
        
        //days
        let tenDays = 10.days
        let daysInDays = tenDays.inDays
        let expectedDaysInDays = TimeInterval(10.0)
        XCTAssert(daysInDays == expectedDaysInDays, "daysInDays == expectedDaysInDays")
        
        //months
        let oneMonth = 1.month
        let monthInDays = oneMonth.inDays
        // here we consider there is 31 days in a month
        let expectedMonthInDays = TimeInterval(31.0)
        XCTAssert(monthInDays == expectedMonthInDays, "monthInDays == expectedMonthInDays")
        
        //years
        let twelveYears = 13.years
        let yearsInDays = twelveYears.inDays
        let expectedYearsInDays = TimeInterval(13 * 12 * 31)
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
    fileprivate var CurrentCalendar = Calendar.current
    
    ///Use this var when copying dates from components
    fileprivate let CalendarAllUnits: Set<Calendar.Component> = Set<Calendar.Component>([.era, .year, .month, .day, .hour, .minute, .second, .calendar, .timeZone])
    
    func testDateOfYear() {
        let date = 16.october.of(1986)
        let comps = CurrentCalendar.dateComponents(CalendarAllUnits, from: date)
        XCTAssert(comps.day == 16, "comps.day == 16")
        XCTAssert(comps.month == 10, "comps.month == 10")
        XCTAssert(comps.year == 1986, "comps.year == 1986")
        let of2014 = date.of(2014)
        let compsOf2014 = CurrentCalendar.dateComponents(CalendarAllUnits, from: of2014)
        XCTAssert(compsOf2014.year == 2014, "comps.year == 2014")
    }
    
    func testIsToday() {
        let now = Date()
        XCTAssert(now.isToday, "now.isToday")
    }
    
    func testBeginningOfDay() {
        let now = Date()
        let begin = now.beginningOfDay
        let comps = CurrentCalendar.dateComponents(CalendarAllUnits, from: begin)
        XCTAssert(comps.hour == 0, "\(String(describing: comps.hour)) == 0")
        XCTAssert(comps.minute == 0, "\(String(describing: comps.minute)) == 0")
        XCTAssert(comps.second == 0, "\(String(describing: comps.second)) == 0")
    }
    
    func testEndOfDay() {
        let now = Date()
        let begin = now.endOfDay
        let comps = CurrentCalendar.dateComponents(CalendarAllUnits, from: begin)
        XCTAssert(comps.hour == 23, "\(String(describing: comps.hour)) = 23")
        XCTAssert(comps.minute == 59, "\(String(describing: comps.minute)) == 59")
        XCTAssert(comps.second == 59, "\(String(describing: comps.second)) == 59")
    }
    
    func testNextHour() {
        let testedDate = Date()
        let nextHour = testedDate.nextHour
        let calendar = Calendar.current
        
        var testedComps = calendar.dateComponents(CalendarAllUnits, from: testedDate)
        testedComps.hour = (testedComps.hour ?? 0) + 1
        testedComps.minute = 0
        testedComps.second = 0
        
        let nextHourComps = calendar.dateComponents(CalendarAllUnits, from: nextHour)
        
        XCTAssertTrue(testedComps.date == nextHourComps.date, "(\(String(describing: testedComps.date)) == \(String(describing: nextHourComps.date))")
    }
    
    func testAddingTimeIntervalToDate() {
        let testedDate = Date()
        let testedComponents = CurrentCalendar.dateComponents(CalendarAllUnits, from: testedDate)
        
        let interval = 2.months
        let newDate = testedDate + interval
        let newComponents = CurrentCalendar.dateComponents(CalendarAllUnits, from: newDate)
        
        XCTAssert(testedComponents.year == newComponents.year, "year should match")
        XCTAssert((testedComponents.month ?? 0) + 2 == newComponents.month, "month should have 2 more than the other")
        XCTAssert(testedComponents.second == newComponents.second, "second should match")
        XCTAssert(testedComponents.day == newComponents.day, "day should match")
    }
    
    func testRemovingTimeIntervalToDate() {
        let testedDate = Date()
        let testedComponents = CurrentCalendar.dateComponents(CalendarAllUnits, from: testedDate)
        
        let interval = 1.year
        let newDate = testedDate - interval
        let newComponents = CurrentCalendar.dateComponents(CalendarAllUnits, from: newDate)
        
        XCTAssert((testedComponents.year ?? 0) - 1 == newComponents.year, "year should match")
        XCTAssert(testedComponents.month == newComponents.month, "month should have 2 more than the other")
        XCTAssert(testedComponents.second == newComponents.second, "second should match")
        XCTAssert(testedComponents.day == newComponents.day, "day should match")
    }
    
    func testSameDay() {
        let date = Date().beginningOfDay
        let nextDate = date.addingTimeInterval(5000)
        let isSameDay = date.isSameDay(nextDate)
        XCTAssert(isSameDay == true, "should be the same day")
        
        let previousDate = date.addingTimeInterval(-5000)
        let prevIsSameDay = date.isSameDay(previousDate)
        XCTAssert(prevIsSameDay == false, "should not be the same day")
    }
    
}
