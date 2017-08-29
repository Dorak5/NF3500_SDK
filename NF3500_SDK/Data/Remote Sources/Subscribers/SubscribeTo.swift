//
//  SubscribeTo.swift
//  NF3500_SDK
//
//  Created by Michael Dorak on 7/31/17.
//  Copyright © 2017 Michael Dorak. All rights reserved.
//

import AEXML

open class SubscribeTo: NSObject {
    private var subscribeToElement: AEXMLElement
    private(set) open var ipAddress: String
    private(set) open var modbusAddress: Int?
    private(set) open var type: String
    private(set) open var sourceAddress: (state: Int?, flag: Int?)
    
    required public init(subscribeTo: AEXMLElement) {
        subscribeToElement = subscribeTo
        
        ipAddress = subscribeToElement["ip"].string
        modbusAddress = subscribeToElement["devid"].int
        type = subscribeToElement["type"].string
        sourceAddress = (subscribeToElement["address"]["state"].int, subscribeToElement["address"]["flag"].int)
    }
}
