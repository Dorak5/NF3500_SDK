//
//  Input.swift
//  NF3500_SDK
//
//  Created by Michael Dorak on 7/10/17.
//  Copyright © 2017 Michael Dorak. All rights reserved.
//

import AEXML

open class Input: Source {
    private var inputElement: AEXMLElement
    private(set) open var thresholdHigh: Int?
    private(set) open var thresholdLow: Int?
    private(set) open var timer: InputTimer?
    private(set) open var source: InputSource?
    private(set) open var inputSync: Sync?
    private(set) open var inhibitSync: Sync?
    private(set) open var timerSync: Sync?
    
    override open var description: String{
        return inputElement.xml
    }
    
    required public init(inputData: AEXMLElement) {
        inputElement = inputData
        
        thresholdHigh = inputElement["threshold"]["hi"].int
        thresholdLow = inputElement["threshold"]["lo"].int
        
        if inputElement["timer"]["type"].value != nil {
            timer = InputTimer(timerData: inputElement["timer"])
        }
        
        let hasTerminalSource = (self.inputElement["terminalsrc"].value != nil)
        let hasCbusSource = (self.inputElement["inputsrc"]["cbus"]["group"].value != nil)
        let hasDmxSource = (self.inputElement["inputsrc"]["dmx"]["slot"].value != nil)
        
        if (hasTerminalSource || hasCbusSource || hasDmxSource) {
            source = InputSource(terminalSource: inputElement["terminalsrc"].int, sourceData: inputElement["inputsrc"])
        }
            
        if inputElement["inputsync"]["source"].value != nil {
            inputSync = Sync(syncData: inputElement["inputsync"])
        }
        
        if inputElement["inhibitsync"]["source"].value != nil {
            inhibitSync = Sync(syncData: inputElement["inhibitsync"])
        }
        
        if inputElement["timersync"]["source"].value != nil {
            timerSync = Sync(syncData: inputElement["timersync"])
        }
        
        super.init()
        
        id = inputElement["id"].int!
        nametag = inputElement["nametag"].string
        defined = (inputElement["defined"].string == "YES" ? true : false)
        active = (inputElement["active"].string == "YES" ? true : false)
        state = inputElement["state"].string
    }
}
