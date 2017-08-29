//
//  Controller.swift
//  NF3500_SDK
//
//  Created by Michael Dorak on 7/24/17.
//  Copyright © 2017 Michael Dorak. All rights reserved.
//

import AEXML

open class ControllerComponent: Component {
    
    required public init(controllerData: [AEXMLElement]) {
        super.init()
        
        type = ComponentType.controller
        
        for slot in controllerData {
            let position = (slot["position"]["id"].int!, slot["position"]["alias"].int, slot["position"]["nametag"].string)
            positions.append(position)
        }
    }
}
