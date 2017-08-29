//
//  Weekly.swift
//  NF3500_SDK
//
//  Created by Michael Dorak on 7/18/17.
//  Copyright © 2017 Michael Dorak. All rights reserved.
//

import AEXML

open class Weekly: RepeatType {
    private var weeklyElement: AEXMLElement
    private(set) var dayWeek: DayOfWeek
    private(set) var duration: Int
    
    required public init(weeklyData: AEXMLElement) {
        weeklyElement = weeklyData
        
        dayWeek = DayOfWeek(rawValue: weeklyElement["dayweek"].string)!
        duration = weeklyElement["duration"].int!
        
        super.init()
        
        if let startDay = weeklyElement["startday"].int {
            self.startDay = startDay
        }
        
        if let startMonth = MonthOfYear(rawValue: weeklyElement["startmonth"].string) {
            self.startMonth = startMonth
        }
        
        if let startYear = weeklyElement["startyear"].int {
            self.startYear = startYear
        }
        
        if let endDay = weeklyElement["endday"].int {
            self.endDay = endDay
        }
        
        if let endMonth = MonthOfYear(rawValue: weeklyElement["endmonth"].string) {
            self.endMonth = endMonth
        }
        
        if let endYear = weeklyElement["endyear"].int {
            self.endYear = endYear
        }
    }
}
