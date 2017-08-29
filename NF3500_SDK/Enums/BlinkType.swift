//
//  BlinkType.swift
//  NF3500_SDK
//
//  Created by Michael Dorak on 7/19/17.
//  Copyright © 2017 Michael Dorak. All rights reserved.
//

public enum BlinkType: String {
    case none = "NONE"
    case single = "SINGLE"
    case double = "DOUBLE"
    case tripple = "TRIPLE"
    case delayOnly = "DELAY ONLY"
    case pulseOff = "SENTRY"
    case pulseOffWithRepeat = "SENTRY WITH REPEAT"
}
