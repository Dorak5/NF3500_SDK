//
//  ThreePoleBreaker.swift
//  NF3500_SDK
//
//  Created by Michael Dorak on 7/24/17.
//  Copyright © 2017 Michael Dorak. All rights reserved.
//

import AEXML

open class ThreePoleBreaker: Component {
    private(set) var breakerInfo: Breaker
    
    required public init(threePoleBreakerData: AEXMLElement) {
        breakerInfo = Breaker(breakerData: threePoleBreakerData["position"]["breaker"])
        
        super.init()
        
        type = ComponentType.threePoleBreaker
        
        for slot in threePoleBreakerData["position"].all! {
            let position = (slot["id"].int!, slot["alias"].int, slot["nametag"].string)
            positions.append(position)
        }
    }
}
