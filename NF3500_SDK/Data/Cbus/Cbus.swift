//
//  Cbus.swift
//  NF3500_SDK
//
//  Created by Michael Dorak on 7/17/17.
//  Copyright © 2017 Michael Dorak. All rights reserved.
//

import AEXML

open class Cbus: Source {
    private var cbusElement: AEXMLElement
    private(set) var source: CbusSource?
    private(set) var onLevel: CbusLevel?
    private(set) var offLevel: CbusLevel?
    private(set) var periodicTimer: RampRate?
    
    override open var description: String {
        return cbusElement.xml
    }

    required public init(cbusData: AEXMLElement) {
        cbusElement = cbusData
        
        if cbusElement["source"]["type"].value != nil {
            source = CbusSource(cbusSourceData: cbusElement["source"])
        }
        
        if cbusElement["onlevel"]["type"].value != nil {
            onLevel = CbusLevel(cbusLevelData: cbusElement["onlevel"])
        }
        
        if cbusElement["offlevel"]["type"].value != nil {
            offLevel = CbusLevel(cbusLevelData: cbusElement["offlevel"])
        }
        
        if cbusElement["periodictimer"].value != nil {
            periodicTimer = RampRate(rawValue: cbusElement["periodictimer"].string)!
        }
        
        super.init()
        
        id = cbusElement["id"].int!
        nametag = cbusElement["nametag"].string
        defined = (cbusElement["defined"].string == "YES" ? true : false)
        active = (cbusElement["active"].string == "YES" ? true : false)
    }
}
