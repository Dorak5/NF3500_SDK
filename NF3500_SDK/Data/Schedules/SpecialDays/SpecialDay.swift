//
//  SpecialDay.swift
//  NF3500_SDK
//
//  Created by Michael Dorak on 7/17/17.
//  Copyright © 2017 Michael Dorak. All rights reserved.
//

import AEXML

open class SpecialDay: Source{
    private var specialDayElement: AEXMLElement
    private(set) var global: Bool
    private(set) var priority: SpecialDayPriority
    
    private(set) var weekly: Weekly?
    private(set) var weeklyStartStop: Weekly?
    private(set) var monthlyDate: MonthlyDate?
    private(set) var monthlyDateStartStop: MonthlyDate?
    private(set) var monthlyDay: MonthlyDay?
    private(set) var monthlyDayStartStop: MonthlyDay?
    private(set) var yearlyDate: YearlyDate?
    private(set) var yearlyDateStartStop: YearlyDate?
    private(set) var yearlyDay: YearlyDay?
    private(set) var yearlyDayStartStop: YearlyDay?
    private(set) var everyNDay: EveryNDay?
    private(set) var everyNDayStartStop: EveryNDay?
    private(set) var holiday: Holiday?
    
    override open var description: String{
        return specialDayElement.xml
    }
    
    required public init(specialDayData: AEXMLElement){
        specialDayElement = specialDayData
        
        global = specialDayElement["global"].string == "YES"
        priority = SpecialDayPriority(rawValue: specialDayElement["priority"].string)!
        
        if specialDayElement["weekly"].children.count > 0 {
            weekly = Weekly(weeklyData: specialDayElement["weekly"])
        }
        
        if specialDayElement["weeklystartstop"].children.count > 0 {
            weeklyStartStop = Weekly(weeklyData: specialDayElement["weeklystartstop"])
        }
        
        if specialDayElement["monthlydate"].children.count > 0 {
            monthlyDate = MonthlyDate(monthlyDateData: specialDayElement["monthlydate"])
        }
        
        if specialDayElement["monthlydatestartstop"].children.count > 0 {
            monthlyDateStartStop = MonthlyDate(monthlyDateData: specialDayElement["monthlydatestartstop"])
        }
        
        if specialDayElement["monthlyday"].children.count > 0 {
            monthlyDay = MonthlyDay(monthlyDayData: specialDayElement["monthlyday"])
        }
        
        if specialDayElement["monthlydaystartstop"].children.count > 0 {
            monthlyDayStartStop = MonthlyDay(monthlyDayData: specialDayElement["monthlydaystartstop"])
        }
        
        if specialDayElement["yearlydate"].children.count > 0 {
            yearlyDate = YearlyDate(yearlyDateData: specialDayElement["yearlydate"])
        }
        
        if specialDayElement["yearlydatestartstop"].children.count > 0 {
            yearlyDateStartStop = YearlyDate(yearlyDateData: specialDayElement["yearlydatestartstop"])
        }
        
        if specialDayElement["yearlyday"].children.count > 0 {
            yearlyDay = YearlyDay(yearlyDayData: specialDayElement["yearlyday"])
        }
        
        if specialDayElement["yearlydaystartstop"].children.count > 0 {
            yearlyDayStartStop = YearlyDay(yearlyDayData: specialDayElement["yearlydaystartstop"])
        }
        
        if specialDayElement["everynday"].children.count > 0 {
            everyNDay = EveryNDay(everyNDayData: specialDayElement["everynday"])
        }
        
        if specialDayElement["everyndaystartstop"].children.count > 0 {
            everyNDayStartStop = EveryNDay(everyNDayData: specialDayElement["everyndaystartstop"])
        }
        
        if specialDayElement["holiday"].children.count > 0 {
            holiday = Holiday(holidayData: specialDayElement["holiday"])
        }
        
        super.init()
        
        id = specialDayElement["id"].int!
        nametag = specialDayElement["nametag"].string
        defined = (specialDayElement["defined"].string == "YES" ? true : false)
        active = (specialDayElement["active"].string == "YES" ? true : false)
        state = specialDayElement["state"].string
    }
}
