//
//  Sync.swift
//  NF3500_SDK
//
//  Created by Michael Dorak on 7/10/17.
//  Copyright © 2017 Michael Dorak. All rights reserved.
//

import AEXML

open class Sync: NSObject {
    private var syncElement: AEXMLElement
    private(set) open var source: SourceType?
    private(set) open var sourceNumber: Int?
    private(set) open var sourceBus: Int?
    private(set) open var syncType: SyncType
    private(set) open var invert: Bool?
    private(set) open var state: String?
    
    required public init(syncData: AEXMLElement) {
        syncElement = syncData
        
        if let sourceType = SourceType(rawValue: syncElement["source"].string) {
            source = sourceType
        }
        else {
            source = SourceType.undefined
        }
        
        sourceNumber = syncElement["srcnumber"].int
        sourceBus = syncElement["srcBus"].int
        
        if let syncType = SyncType(rawValue: syncElement["filter"].string) {
            self.syncType = syncType
        }
        else {
            syncType = SyncType.noSync
        }
        
        invert = syncElement["invert"].string == "INVERT"
        state = syncElement["state"].string
    }
}
