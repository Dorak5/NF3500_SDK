//
//  Communications.swift
//  NF3500_SDK
//
//  Created by Michael Dorak on 7/17/17.
//  Copyright © 2017 Michael Dorak. All rights reserved.
//

import AEXML

open class Communications: NSObject {
    private var commsElement: AEXMLElement
    private(set) var rs232: (baud: BaudRate, parity: Parity, mode: Mode)
    private(set) var rs485: (baud: BaudRate, parity: Parity, mode: Mode)
    private(set) var net: (ip: String, subnet: String, gateway: String, mac: String)
    private(set) var modbusAddress: Int
    private(set) var bacnet: (address: String, port: String, deviceId: String, mode: String, bbmdIp: String, bbmdPort: String)
    
    required public init( commsData: AEXMLElement) {
        commsElement = commsData
        
        rs232 = (BaudRate(rawValue: commsElement["rs232"]["baud"].string)!, Parity(rawValue: commsElement["rs232"]["parity"].string)!, Mode(rawValue: commsElement["rs232"]["mode"].string)!)
        rs485 = (BaudRate(rawValue: commsElement["rs485"]["baud"].string)!, Parity(rawValue: commsElement["rs485"]["parity"].string)!, Mode(rawValue: commsElement["rs485"]["mode"].string)!)
        net = (commsElement["net"]["ip"].string, commsElement["net"]["subnet"].string, commsElement["net"]["gateway"].string, commsElement["net"]["mac"].string)
        modbusAddress = commsElement["modbus"]["addr"].int!
        bacnet = (commsElement["bacnet"]["addr"].string, commsElement["bacnet"]["port"].string, commsElement["bacnet"]["deviceid"].string, commsElement["bacnet"]["mode"].string, commsElement["bacnet"]["bbmd"]["ip"].string, commsElement["bacnet"]["bbmd"]["port"].string)
    }
}
