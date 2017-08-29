//
//  BreakerMembers.swift
//  NF3500_SDK
//
//  Created by Michael Dorak on 7/26/17.
//  Copyright © 2017 Michael Dorak. All rights reserved.
//

import AEXML

open class BreakerMembers: NSObject {
    private(set) open var panels: [BMPanel]
    
    required public init(breakerMembersData: AEXMLElement) {
        panels = [BMPanel]()
        
        for panel in breakerMembersData["panels"]["panel"].all! {
            panels.append(BMPanel(panelData: panel))
        }
    }
}
