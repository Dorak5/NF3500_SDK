//
//  Bus.swift
//  NF3500_SDK
//
//  Created by Michael Dorak on 7/19/17.
//  Copyright © 2017 Michael Dorak. All rights reserved.
//

import AEXML

open class Bus: NSObject {
    private var busElement: AEXMLElement
    private(set) var id: String
    private(set) var nametag: String
    private(set) var model: BusModel
    private(set) var firmware: String
    private(set) var location: String
    //private(set) var position: Int
    private(set) var notResponding: Bool
    
    required public init(busData: AEXMLElement) {
        busElement = busData
        
        id = busElement["id"].string
        nametag = busElement["nametag"].string
        model = BusModel(rawValue: busElement["model"].string)!
        firmware = busElement["firmware"].string
        location = busElement["panelloc"].string
        //position = busElement["position"].int!
        notResponding = busElement["busnonrep"].string == "YES"
    }
}
