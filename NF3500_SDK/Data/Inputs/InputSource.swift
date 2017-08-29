//
//  InputSource.swift
//  NF3500_SDK
//
//  Created by Michael Dorak on 7/10/17.
//  Copyright © 2017 Michael Dorak. All rights reserved.
//

import AEXML

open class InputSource: NSObject {
    private var sourceElement: AEXMLElement
    private(set) open var terminalSource: Int?
    private(set) open var cbusGroup: Int?
    private(set) open var cbusApp: Int?
    private(set) open var dmxSlot: Int?
    
    required public init(terminalSource: Int?, sourceData: AEXMLElement) {
        sourceElement = sourceData
        self.terminalSource = terminalSource
        
        cbusGroup = sourceElement["cbus"]["group"].int
        cbusApp = sourceElement["cbus"]["app"].int
        dmxSlot = sourceElement["dmx"]["slot"].int
    }
}
