//
//  YearDate.swift
//  NF3500_SDK
//
//  Created by Michael Dorak on 7/18/17.
//  Copyright © 2017 Michael Dorak. All rights reserved.
//

import AEXML

open class YearlyDate: RepeatType {
    private var yearlyDateElement: AEXMLElement
    private(set) var monthOfYear: MonthOfYear
    private(set) var dayOfMonth: Int
    private(set) var thruMonth: MonthOfYear
    private(set) var thruDay: Int
    
    required public init(yearlyDateData: AEXMLElement) {
        yearlyDateElement = yearlyDateData
        
        monthOfYear = MonthOfYear(rawValue: yearlyDateElement["monthyear"].string)!
        dayOfMonth = yearlyDateElement["daymonth"].int!
        thruMonth = MonthOfYear(rawValue: yearlyDateElement["thrumonth"].string)!
        thruDay = yearlyDateElement["thruday"].int!
        
        super.init()
        
        if let startDay = yearlyDateElement["startday"].int {
            self.startDay = startDay
        }
        
        if let startMonth = MonthOfYear(rawValue: yearlyDateElement["startmonth"].string) {
            self.startMonth = startMonth
        }
        
        if let startYear = yearlyDateElement["startyear"].int {
            self.startYear = startYear
        }
        
        if let endDay = yearlyDateElement["endday"].int {
            self.endDay = endDay
        }
        
        if let endMonth = MonthOfYear(rawValue: yearlyDateElement["endmonth"].string) {
            self.endMonth = endMonth
        }
        
        if let endYear = yearlyDateElement["endyear"].int {
            self.endYear = endYear
        }
    }
}
