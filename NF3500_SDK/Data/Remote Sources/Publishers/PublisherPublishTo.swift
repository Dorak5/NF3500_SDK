//
//  PublishTo.swift
//  NF3500_SDK
//
//  Created by Michael Dorak on 7/26/17.
//  Copyright © 2017 Michael Dorak. All rights reserved.
//

import AEXML

open class PublisherPublishTo: NSObject {
    private var publishToElement: AEXMLElement
    private(set) var ipAddress: String
    private(set) var modbusId: Int?
    private(set) var timeout: Int?
    private(set) var subscription: (subscriptionIndex: Int?, type: String, address: Int?, state: String)
    
    required public init(publishToData: AEXMLElement) {
        publishToElement = publishToData
        
        ipAddress = publishToElement["ip"].string
        modbusId = publishToElement["devid"].int
        timeout = publishToElement["timeout"].int
        subscription = (publishToElement["subscription"]["number"].int,
                        publishToElement["subscription"]["type"].string,
                        publishToElement["subscription"]["address"].int,
                        publishToElement["subscription"]["state"].string)
    }
}
