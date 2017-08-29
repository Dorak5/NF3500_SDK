//
//  MonthlyDay.swift
//  NF3500_SDK
//
//  Created by Michael Dorak on 7/18/17.
//  Copyright © 2017 Michael Dorak. All rights reserved.
//

import AEXML

open class MonthlyDay: RepeatType {
    private var monthlyDayElement: AEXMLElement
    private(set) var dayOfWeek: DayOfWeek
    private(set) var weekOfMonth: WeekOfMonth
    private(set) var duration: Int
    
    required public init(monthlyDayData: AEXMLElement) {
        monthlyDayElement = monthlyDayData
        
        dayOfWeek = DayOfWeek(rawValue: monthlyDayElement["dayweek"].string)!
        weekOfMonth = WeekOfMonth(rawValue: monthlyDayElement["weekmonth"].string)!
        duration = monthlyDayElement["duration"].int!
        
        super.init()
        
        if let startDay = monthlyDayElement["startday"].int {
            self.startDay = startDay
        }
        
        if let startMonth = MonthOfYear(rawValue: monthlyDayElement["startmonth"].string) {
            self.startMonth = startMonth
        }
        
        if let startYear = monthlyDayElement["startyear"].int {
            self.startYear = startYear
        }
        
        if let endDay = monthlyDayElement["endday"].int {
            self.endDay = endDay
        }
        
        if let endMonth = MonthOfYear(rawValue: monthlyDayElement["endmonth"].string) {
            self.endMonth = endMonth
        }
        
        if let endYear = monthlyDayElement["endyear"].int {
            self.endYear = endYear
        }
    }
}
