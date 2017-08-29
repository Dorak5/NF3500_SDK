//
//  EmptySlot.swift
//  NF3500_SDK
//
//  Created by Michael Dorak on 7/24/17.
//  Copyright © 2017 Michael Dorak. All rights reserved.
//

import AEXML

open class EmptySlot: Component {
    private(set) var emptySlotData: AEXMLElement
    
    required public init(emptySlotData: AEXMLElement) {
        self.emptySlotData = emptySlotData
        
        super.init()
        
        type = ComponentType.emptySlot
        positions.append((emptySlotData["position"]["id"].int!, emptySlotData["position"]["alias"].int, emptySlotData["position"]["nametag"].string))
    }
}
