//
//  Breaker.swift
//  NF3500_SDK
//
//  Created by Michael Dorak on 7/19/17.
//  Copyright © 2017 Michael Dorak. All rights reserved.
//

import AEXML

open class Breaker: NSObject {
    private var breakerElement: AEXMLElement
    private(set) var nametag: String
    private(set) var elType: Bool
    private(set) var blinkType: BlinkType
    private(set) var blinkTimer: Int
    private(set) var onTime: Int
    private(set) var state: Bool
    private(set) var strikeCount: Int
    private(set) var nonResponding: Bool
    private(set) var busIndex: Int
    
    required public init(breakerData: AEXMLElement) {
        breakerElement = breakerData
        
        nametag = breakerElement["nametag"].string
        elType = breakerElement["eltype"].string == "YES"
        blinkType = BlinkType(rawValue: breakerElement["blinktype"].string)!
        blinkTimer = breakerElement["blinktimer"].int!
        onTime = breakerElement["ontime"].int!
        state = breakerElement["state"].string == "YES"
        strikeCount = breakerElement["strikecnt"].int!
        nonResponding = breakerElement["brkrnonrep"].string == "YES"
        busIndex = breakerElement["bus"].int!
    }
}
