//
//  ZoneOverride.swift
//  3500_SDK
//
//  Created by Michael Dorak on 7/7/17.
//  Copyright © 2017 Michael Dorak. All rights reserved.
//

import AEXML

open class ZoneOverride: NSObject {
    private(set) open var state: ZoneOverrideState?
    private(set) open var timer: String
    private(set) open var timerValue: String
    
    required public init(override: AEXMLElement) {
        if let state = ZoneOverrideState(rawValue: override["state"].string) {
            self.state = state
        }
        
        timer = override["timerset"].string
        timerValue = override["timervalue"].string
    }
}
