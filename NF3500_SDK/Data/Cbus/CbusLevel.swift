//
//  CbusLevel.swift
//  NF3500_SDK
//
//  Created by Michael Dorak on 7/17/17.
//  Copyright © 2017 Michael Dorak. All rights reserved.
//

import AEXML

open class CbusLevel: NSObject {
    private var cbusLevelElement: AEXMLElement
    private(set) var type: LevelSource
    private(set) var id: Int
    private(set) var level: Int
    private(set) var ramprate: RampRate
    
    required public init(cbusLevelData: AEXMLElement) {
        cbusLevelElement = cbusLevelData
        
        type = LevelSource(rawValue: cbusLevelElement["type"].string)!
        id = cbusLevelElement["id"].int!
        level = cbusLevelElement["level"].int!
        ramprate = RampRate(rawValue: cbusLevelElement["ramprate"].string)!
    }
}
