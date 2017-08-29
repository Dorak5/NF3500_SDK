//
//  Schedule.swift
//  NF3500_SDK
//
//  Created by Michael Dorak on 7/19/17.
//  Copyright © 2017 Michael Dorak. All rights reserved.
//

import AEXML

open class Schedule: Source {
    private var scheduleElement: AEXMLElement
    private(set) var periods: [Period]?
    
    override open var description: String {
        return scheduleElement.xml
    }
    
    required public init(scheduleData: AEXMLElement) {
        scheduleElement = scheduleData
        
        if scheduleElement["periods"].children.count > 0 {
            periods = [Period]()
            
            for period in scheduleElement["periods"]["period"].all! {
                periods?.append(Period(periodData: period))
            }
        }
        
        super.init()
        
        id = Int(scheduleElement["id"].string)!
        nametag = scheduleElement["nametag"].string
        defined = (scheduleElement["defined"].string == "YES" ? true : false)
        active = (scheduleElement["active"].string == "YES" ? true : false)
        state = scheduleElement["state"].string
    }
}
