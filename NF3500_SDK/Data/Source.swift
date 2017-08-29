//
//  Source.swift
//  NF3500_SDK
//
//  Created by Michael Dorak on 7/7/17.
//  Copyright © 2017 Michael Dorak. All rights reserved.
//

open class Source: NSObject {
    internal(set) open var id: Int
    internal(set) open var nametag: String
    internal(set) open var defined: Bool
    internal(set) open var active: Bool
    internal(set) open var state: String
    
    override init() {
        id = 1
        nametag = "Source 1"
        defined = true
        active = true
        state = "Not set"
        
        super.init()
    }
}
