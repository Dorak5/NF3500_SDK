//
//  TwoPoleBreakerLeft.swift
//  NF3500_SDK
//
//  Created by Michael Dorak on 7/24/17.
//  Copyright © 2017 Michael Dorak. All rights reserved.
//

import AEXML

open class TwoPoleBreakerLeft: Component {
    let isLeftSide = true
    private(set) var breakerInfo: Breaker
    
    required public init(twoPoleBreakerData: AEXMLElement) {
        breakerInfo = Breaker(breakerData: twoPoleBreakerData["position"]["breaker"])
        
        super.init()
        
        type = ComponentType.twoPoleBreaker
        
        for slot in twoPoleBreakerData["position"].all! {
            let position = (slot["id"].int!, slot["alias"].int, slot["nametag"].string)
            positions.append(position)
        }
    }
}
