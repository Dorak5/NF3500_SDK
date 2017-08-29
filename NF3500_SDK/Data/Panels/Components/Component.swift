//
//  Component.swift
//  NF3500_SDK
//
//  Created by Michael Dorak on 7/24/17.
//  Copyright © 2017 Michael Dorak. All rights reserved.
//

open class Component: NSObject {
    internal(set) var type: ComponentType
    internal(set) var positions: [(id: Int, alias: Int?, nametag: String)]
    
    override init() {
        type = ComponentType.emptySlot
        positions = [(id: Int, alias: Int?, nametag: String)]()
        
        super.init()
    }
}
