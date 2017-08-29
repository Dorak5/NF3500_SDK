//
//  InputTimer.swift
//  NF3500_SDK
//
//  Created by Michael Dorak on 7/10/17.
//  Copyright © 2017 Michael Dorak. All rights reserved.
//

import AEXML

open class InputTimer: NSObject {
    private var timerElement: AEXMLElement
    private(set) open var type: TimerType!
    private(set) open var setpoint: Int!
    private(set) open var state: Int!
    
    required public init(timerData: AEXMLElement) {
        timerElement = timerData
        
        if let timerType = TimerType(rawValue: timerElement["type"].string) {
            type = timerType
        }
        
        setpoint = timerElement["setpoint"].int
        state = timerElement["state"].int
    }
}
