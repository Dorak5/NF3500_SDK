//
//  YearlyDay.swift
//  NF3500_SDK
//
//  Created by Michael Dorak on 7/18/17.
//  Copyright © 2017 Michael Dorak. All rights reserved.
//

import AEXML

open class YearlyDay: RepeatType {
    private var yearlyDayElement: AEXMLElement
    private(set) var dayOfWeek: DayOfWeek
    private(set) var weekOfMonth: WeekOfMonth
    private(set) var monthOfYear: MonthOfYear
    private(set) var duration: Int
    
    required public init(yearlyDayData: AEXMLElement) {
        yearlyDayElement = yearlyDayData
        
        dayOfWeek = DayOfWeek(rawValue: yearlyDayElement["dayweek"].string)!
        weekOfMonth = WeekOfMonth(rawValue: yearlyDayElement["weekmonth"].string)!
        monthOfYear = MonthOfYear(rawValue: yearlyDayElement["monthyear"].string)!
        duration = yearlyDayElement["duration"].int!
        
        super.init()
        
        if let startDay = yearlyDayElement["startday"].int {
            self.startDay = startDay
        }
        
        if let startMonth = MonthOfYear(rawValue: yearlyDayElement["startmonth"].string) {
            self.startMonth = startMonth
        }
        
        if let startYear = yearlyDayElement["startyear"].int {
            self.startYear = startYear
        }
        
        if let endDay = yearlyDayElement["endday"].int {
            self.endDay = endDay
        }
        
        if let endMonth = MonthOfYear(rawValue: yearlyDayElement["endmonth"].string) {
            self.endMonth = endMonth
        }
        
        if let endYear = yearlyDayElement["endyear"].int {
            self.endYear = endYear
        }
    }
}
