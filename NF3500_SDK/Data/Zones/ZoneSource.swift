//
//  ZoneSource.swift
//  3500_SDK
//
//  Created by Michael Dorak on 7/7/17.
//  Copyright © 2017 Michael Dorak. All rights reserved.
//

import AEXML

open class ZoneSource: NSObject {
    private(set) public var type: SourceType
    private(set) public var bus: Int?
    private(set) public var id: Int?
    private(set) public var nametag: String
    private(set) public var state: String
    
    required public init(source: AEXMLElement) {
        if let type = SourceType(rawValue: source["type"].string){
            self.type = type
        }
        else {
            type = SourceType.undefined
        }
        
        if let bus = source["bus"].int {
            self.bus = bus
        }
        
        id = source["id"].int
        nametag = source["nametag"].string
        state = source["state"].string
    }
}
