//
//  DaylightSavingsTime.swift
//  NF3500_SDK
//
//  Created by Michael Dorak on 7/17/17.
//  Copyright © 2017 Michael Dorak. All rights reserved.
//

import AEXML

open class DaylightSavingsTime: NSObject {
    private var dstElement: AEXMLElement
    private(set) var dayOfWeek: DayOfWeek
    private(set) var weekOfMonth: WeekOfMonth
    private(set) var day: Int
    private(set) var month: MonthOfYear
    
    required public init(dstData: AEXMLElement) {
        dstElement = dstData
        
        dayOfWeek = DayOfWeek(rawValue: dstElement["dayofweek"].string)!
        weekOfMonth = WeekOfMonth(rawValue: dstElement["weekofmonth"].string)!
        
        day = dstElement["day"].int!
        month = MonthOfYear(rawValue: dstElement["month"].string)!
    }
}
