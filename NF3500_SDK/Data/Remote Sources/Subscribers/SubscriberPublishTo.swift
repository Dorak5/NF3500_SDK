//
//  SubscriberPublishTo.swift
//  NF3500_SDK
//
//  Created by Michael Dorak on 7/31/17.
//  Copyright © 2017 Michael Dorak. All rights reserved.
//

import AEXML

open class SubscriberPublishTo: NSObject {
    private(set) open var sourceAddress: (state: Int?, flag: Int?)
    private(set) open var subscriptionRate: Int?
    private(set) open var periodic: Int?
    
    required public init(publishToData: AEXMLElement) {
        sourceAddress = (publishToData["address"]["state"].int, publishToData["address"]["flag"].int)
        subscriptionRate = publishToData["heartbeat"].int
        periodic = publishToData["periodic"].int
    }
}
