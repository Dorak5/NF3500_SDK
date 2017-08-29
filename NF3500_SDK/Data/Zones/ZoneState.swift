//
//  ZoneState.swift
//  NF3500_SDK
//
//  Created by Michael Dorak on 7/10/17.
//  Copyright © 2017 Michael Dorak. All rights reserved.
//

class ZoneState: NSObject {
    private(set) open var id: Int
    private(set) open var nameTag: String
    private(set) open var controlState: String
    
    override init() {
        id = 1
        nameTag = "Zone Object 1"
        controlState = "ON"
        
        super.init()
    }
}
