//
//  MonthlyDate.swift
//  NF3500_SDK
//
//  Created by Michael Dorak on 7/18/17.
//  Copyright © 2017 Michael Dorak. All rights reserved.
//

import AEXML

open class MonthlyDate: RepeatType {
    private var monthlyDateElement: AEXMLElement
    private(set) var dayMonth: Int
    private(set) var thrudate: Int
    
    required public init(monthlyDateData: AEXMLElement) {
        monthlyDateElement = monthlyDateData
        
        dayMonth = monthlyDateElement["daymonth"].int!
        thrudate = monthlyDateElement["thruday"].int!
        
        super.init()
        
        if let startDay = monthlyDateElement["startday"].int {
            self.startDay = startDay
        }
        
        if let startMonth = MonthOfYear(rawValue: monthlyDateElement["startmonth"].string) {
            self.startMonth = startMonth
        }
        
        if let startYear = monthlyDateElement["startyear"].int {
            self.startYear = startYear
        }
        
        if let endDay = monthlyDateElement["endday"].int {
            self.endDay = endDay
        }
        
        if let endMonth = MonthOfYear(rawValue: monthlyDateElement["endmonth"].string) {
            self.endMonth = endMonth
        }
        
        if let endYear = monthlyDateElement["endyear"].int {
            self.endYear = endYear
        }
    }
}
