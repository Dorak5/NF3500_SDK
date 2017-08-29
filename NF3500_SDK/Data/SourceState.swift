//
//  ZoneState.swift
//  NF3500_SDK
//
//  Created by Michael Dorak on 7/10/17.
//  Copyright © 2017 Michael Dorak. All rights reserved.
//

import AEXML

open class SourceState: NSObject {
    private var sourceElement: AEXMLElement
    private(set) open var id: Int
    private(set) open var nametag: String
    private(set) open var controlState: String
    
    override open var description: String{
        return sourceElement.xml
    }
    
    required public init(sourceState: AEXMLElement) {
        sourceElement = sourceState
        id = sourceState["id"].int!
        nametag = sourceState["nametag"].string
        controlState = sourceState["controlstate"].string
    }
}
