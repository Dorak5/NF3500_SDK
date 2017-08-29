//
//  ElBreakerRight.swift
//  NF3500_SDK
//
//  Created by Michael Dorak on 7/24/17.
//  Copyright © 2017 Michael Dorak. All rights reserved.
//

import AEXML

open class ElBreakerRight: Component {
    let isLeftSide = false
    private(set) var breakerInfo: Breaker
    
    required public init(elBreakerData: [AEXMLElement]) {
        breakerInfo = Breaker(breakerData: elBreakerData[0]["position"]["breaker"])
        
        super.init()
        
        type = ComponentType.elBreaker
        
        for slot in elBreakerData {
            let position = (slot["position"]["id"].int!, slot["position"]["alias"].int, slot["position"]["nametag"].string)
            positions.append(position)
        }
    }
}
