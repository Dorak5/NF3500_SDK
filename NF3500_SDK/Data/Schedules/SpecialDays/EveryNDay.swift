//
//  EveryNDay.swift
//  NF3500_SDK
//
//  Created by Michael Dorak on 7/18/17.
//  Copyright © 2017 Michael Dorak. All rights reserved.
//

import AEXML

open class EveryNDay: RepeatType {
    private var everyNDayElement: AEXMLElement
    private(set) var nDays: Int
    
    required public init(everyNDayData: AEXMLElement) {
        everyNDayElement = everyNDayData
        
        nDays = everyNDayElement["repeat"].int!
        
        super.init()
        
        if let startDay = everyNDayElement["startday"].int {
            self.startDay = startDay
        }
        
        if let startMonth = MonthOfYear(rawValue: everyNDayElement["startmonth"].string) {
            self.startMonth = startMonth
        }
        
        if let startYear = everyNDayElement["startyear"].int {
            self.startYear = startYear
        }
        
        if let endDay = everyNDayElement["endday"].int {
            self.endDay = endDay
        }
        
        if let endMonth = MonthOfYear(rawValue: everyNDayElement["endmonth"].string) {
            self.endMonth = endMonth
        }
        
        if let endYear = everyNDayElement["endyear"].int {
            self.endYear = endYear
        }
    }
}
