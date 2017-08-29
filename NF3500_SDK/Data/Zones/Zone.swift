//
//  Zone.swift
//  3500_SDK
//
//  Created by Michael Dorak on 7/7/17.
//  Copyright © 2017 Michael Dorak. All rights reserved.
//

import AEXML

open class Zone: Source {
    private var zoneElement: AEXMLElement
    private(set) open var logicType: LogicType
    private(set) open var priority: PriorityType
    private(set) open var source1: ZoneSource
    private(set) open var source2: ZoneSource
    private(set) open var source3: ZoneSource
    private(set) open var source4: ZoneSource
    private(set) open var breakerMembers: BreakerMembers?
    private(set) open var zoneOverride: ZoneOverride
    
    override open var description: String {
        return zoneElement.xml
    }
    
    required public init(zoneData: AEXMLElement) {
        zoneElement = zoneData
        
        if let logicType = LogicType(rawValue: zoneElement["logictype"].string) {
            self.logicType = logicType
        }
        else {
            logicType = LogicType.noValue
        }
        
        if let priority = PriorityType(rawValue: zoneElement["priority"].string) {
            self.priority = priority
        }
        else {
            priority = PriorityType.noPriority
        }
        
        if let priority = PriorityType(rawValue: zoneElement["priority"].string) {
            self.priority = priority
        }
        else {
            priority = PriorityType.noPriority
        }
        
        source1 = ZoneSource(source: zoneElement["sources"].children[0])
        source2 = ZoneSource(source: zoneElement["sources"].children[1])
        source3 = ZoneSource(source: zoneElement["sources"].children[2])
        source4 = ZoneSource(source: zoneElement["sources"].children[3])
        
        if !zoneElement["zonemember"]["panels"].children.isEmpty {
            breakerMembers = BreakerMembers(breakerMembersData: zoneElement["zonemember"])
        }
        
        zoneOverride = ZoneOverride(override: zoneElement["override"])
        
        super.init()
        
        id = Int(zoneElement["id"].string)!
        nametag = zoneElement["nametag"].string
        defined = (zoneElement["defined"].string == "YES" ? true : false)
        active = (zoneElement["active"].string == "YES" ? true : false)
        state = zoneElement["state"].string
    }
}




