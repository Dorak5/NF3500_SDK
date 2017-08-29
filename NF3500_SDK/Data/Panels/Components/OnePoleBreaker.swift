//
//  OnePoleBreaker.swift
//  NF3500_SDK
//
//  Created by Michael Dorak on 7/24/17.
//  Copyright © 2017 Michael Dorak. All rights reserved.
//

import AEXML

open class OnePoleBreaker: Component {
    private(set) var breakerInfo: Breaker
    
    required public init(onePoleBreakerData: AEXMLElement) {
        breakerInfo = Breaker(breakerData: onePoleBreakerData["position"]["breaker"])
        
        super.init()
        
        type = ComponentType.onePoleBreaker
        positions.append((onePoleBreakerData["position"]["id"].int!, onePoleBreakerData["position"]["alias"].int, onePoleBreakerData["position"]["nametag"].string))
    }
}
