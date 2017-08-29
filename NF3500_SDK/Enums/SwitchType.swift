//
//  SwitchType.swift
//  NF3500_SDK
//
//  Created by Michael Dorak on 7/10/17.
//  Copyright © 2017 Michael Dorak. All rights reserved.
//

public enum SwitchType: String {
    case maintainNormalyOpen = "MAINTAINTED N/O"
    case maintainNormalyClosed = "MAINTAINTED N/C"
    case maintainToggle = "MAINTAINED TOGGLE"
    case momentaryToggle = "MOMENTARY TOGGLE"
    case momentaryOn = "MOMENTARY ON"
    case momentaryOff = "MOMENTARY OFF"
    case dualMomentary = "DUAL MOMEMTARY"
}
