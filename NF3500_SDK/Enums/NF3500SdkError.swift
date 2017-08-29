//
//  NF3500SdkError.swift
//  NF3500_SDK
//
//  Created by Michael Dorak on 7/7/17.
//  Copyright © 2017 Michael Dorak. All rights reserved.
//

public enum NF3500SdkError: Error {
    case badBaseURL
    case analogStateOutOfRange
    case zoneIndexOutOfRange
    case inputIndexOutOfRange
    case terminalIndexOutOfRange
    case scheduleIndexOutOfRange
    case panelIndexOutOfRange
}
