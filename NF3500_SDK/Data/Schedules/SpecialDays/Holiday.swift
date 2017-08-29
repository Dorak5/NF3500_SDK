//
//  Holiday.swift
//  NF3500_SDK
//
//  Created by Michael Dorak on 7/18/17.
//  Copyright © 2017 Michael Dorak. All rights reserved.
//

import AEXML

open class Holiday: NSObject {
    private var holidayElement: AEXMLElement
    private(set) var holidayType: HolidayType
    private(set) var duration: Int
    
    required public init(holidayData: AEXMLElement) {
        holidayElement = holidayData
        
        holidayType = HolidayType(rawValue: holidayElement["name"].string)!
        duration = holidayElement["duration"].int!
    }
}
