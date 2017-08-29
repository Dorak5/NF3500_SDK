//
//  CbusSource.swift
//  NF3500_SDK
//
//  Created by Michael Dorak on 7/17/17.
//  Copyright © 2017 Michael Dorak. All rights reserved.
//

import AEXML

open class CbusSource: NSObject {
    private var cbusSourceElement: AEXMLElement
    private(set) var type: CbusSourceType
    private(set) var index: Int
    private(set) var bus: Int
    private(set) var groupNumber: Int
    private(set) var appNumber: Int
    
    required public init(cbusSourceData: AEXMLElement) {
        cbusSourceElement = cbusSourceData
        
        if let source = CbusSourceType(rawValue: cbusSourceElement["type"].string) {
            type = source
        }
        else {
            type = CbusSourceType.undefined
        }
        
        index = cbusSourceElement["id"].int!
        bus = cbusSourceElement["bus"].int!
        groupNumber = cbusSourceElement["groupnumber"].int!
        appNumber = cbusSourceElement["appnumber"].int!
    }
}
