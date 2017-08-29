//
//  CbusSourceType.swift
//  NF3500_SDK
//
//  Created by Michael Dorak on 7/20/17.
//  Copyright © 2017 Michael Dorak. All rights reserved.
//

public enum CbusSourceType: String {
    case terminal = "TERMINAL"
    case input = "INPUT"
    case schedule = "SCHEDULE"
    case zone = "ZONE"
    case breaker = "BREAKER"
    case remoteSource = "REMOTE SOURCE"
    case periodic = "PERIODIC"
    case undefined = "UNDEFINED"
}
