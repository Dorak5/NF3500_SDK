//
//  Terminal.swift
//  NF3500_SDK
//
//  Created by Michael Dorak on 7/10/17.
//  Copyright © 2017 Michael Dorak. All rights reserved.
//

import AEXML

open class Terminal: Source {
    private var terminalElement: AEXMLElement
    private(set) open var type: TerminalType
    private(set) open var switchType: SwitchType?
    private(set) open var sensor: SensorType?
    private(set) open var source: TerminalSource?
    
    override open var description: String{
        return terminalElement.xml
    }
    
    required public init(terminalData: AEXMLElement) {
        terminalElement = terminalData
        
        if let type = TerminalType(rawValue: terminalElement["type"].string) {
            self.type = type
        }
        else {
            type = TerminalType.notype
        }
        
        if let switchType = SwitchType(rawValue: terminalElement["switch"].string) {
            self.switchType = switchType
        }
        
        if let sensorType = SensorType(rawValue: terminalElement["sensor"].string) {
            self.sensor = sensorType
        }
        
        if terminalElement["source"]["src"].value != nil {
            self.source = TerminalSource(sourceElement: terminalElement["source"])
        }
        
        super.init()
        
        id = terminalElement["id"].int!
        nametag = terminalElement["nametag"].string
        defined = (terminalElement["defined"].string == "YES" ? true : false)
        active = (terminalElement["active"].string == "YES" ? true : false)
        state = terminalElement["state"].string
    }
}
