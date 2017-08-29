//
//  Period.swift
//  NF3500_SDK
//
//  Created by Michael Dorak on 7/15/17.
//  Copyright © 2017 Michael Dorak. All rights reserved.
//

import AEXML

open class Period: Source {
    private var periodElement: AEXMLElement
    private(set) var startTimeHour: Int
    private(set) var startTimeMinute: Int
    private(set) var endTimeHour: Int
    private(set) var endTimeMinute: Int
    private(set) var sunday: Bool
    private(set) var monday: Bool
    private(set) var tuesday: Bool
    private(set) var wednesday: Bool
    private(set) var thursday: Bool
    private(set) var friday: Bool
    private(set) var saturday: Bool
    private(set) var specialdays: [SpecialDay]?
    
    override open var description: String{
        return periodElement.xml
    }
    
    required public init(periodData: AEXMLElement) {
        periodElement = periodData
        
        startTimeHour = periodElement["starttime"]["hour"].int!
        startTimeMinute = periodElement["starttime"]["min"].int!
        endTimeHour = periodElement["endtime"]["hour"].int!
        endTimeMinute = periodElement["endtime"]["min"].int!
        
        sunday = periodElement["days"]["sun"].string == "YES"
        monday = periodElement["days"]["mon"].string == "YES"
        tuesday = periodElement["days"]["tues"].string == "YES"
        wednesday = periodElement["days"]["wed"].string == "YES"
        thursday = periodElement["days"]["thurs"].string == "YES"
        friday = periodElement["days"]["fri"].string == "YES"
        saturday = periodElement["days"]["sat"].string == "YES"
        
        if periodElement["days"]["specdays"]["specday"].all!.count > 0 {
            specialdays = [SpecialDay]()
            
            //for dog in xmlDoc.root["dogs"]["dog"].all! {
            for specialday in periodElement["days"]["specdays"]["specday"].all! {
                specialdays?.append(SpecialDay(specialDayData: specialday))
            }
        }
        
        super.init()
        
        id = Int(periodElement["id"].string)!
        nametag = periodElement["nametag"].string
        defined = (periodElement["defined"].string == "YES" ? true : false)
        active = (periodElement["active"].string == "YES" ? true : false)
        state = periodElement["state"].string
    }
}
