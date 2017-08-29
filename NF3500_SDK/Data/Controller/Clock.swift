//
//  Clock.swift
//  NF3500_SDK
//
//  Created by Michael Dorak on 7/17/17.
//  Copyright © 2017 Michael Dorak. All rights reserved.
//

import AEXML

open class Clock: NSObject {
    private var clockElement: AEXMLElement
    private(set) var format: TimeFormat
    private(set) var timeZone: TimeZone
    private(set) var latitude: String
    private(set) var longitude: String
    private(set) var dstEnabled: Bool
    private(set) var date: (month: String, day: String, year: String, dayOfWeek: String, weekOfMonth: String)
    private(set) var time: (hour: Int, minute: Int, second: Int)
    private(set) var dstBegin: DaylightSavingsTime
    private(set) var dstEnd: DaylightSavingsTime
    private(set) var sunRise: (hour: Int, minute: Int)
    private(set) var sunSet: (hour: Int, minute: Int)
    
    required public init(clockData: AEXMLElement) {
        clockElement = clockData
        
        format = TimeFormat(rawValue: clockElement["format"].string)!
        timeZone = TimeZone(rawValue: clockElement["timezone"].string)!
        
        latitude = clockElement["lat"].string
        longitude = clockElement["long"].string
        
        dstEnabled = clockElement["dst"].string == "Active"
        
        date = (clockElement["date"]["month"].string, clockElement["date"]["day"].string, clockElement["date"]["year"].string, clockElement["date"]["dayofweek"].string, clockElement["date"]["weekofmonth"].string)
        time = (clockElement["time"]["hr"].int!, clockElement["time"]["min"].int!, clockElement["time"]["sec"].int!)
        
        dstBegin = DaylightSavingsTime(dstData: clockElement["dstbegin"])
        dstEnd = DaylightSavingsTime(dstData: clockElement["dstend"])
        
        sunRise = (clockElement["sunrise"]["hr"].int!, clockElement["sunrise"]["min"].int!)
        sunSet = (clockElement["sunset"]["hr"].int!, clockElement["sunset"]["min"].int!)
    }
}
