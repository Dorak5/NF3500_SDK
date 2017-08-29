//
//  Publisher.swift
//  NF3500_SDK
//
//  Created by Michael Dorak on 7/26/17.
//  Copyright © 2017 Michael Dorak. All rights reserved.
//

import AEXML

open class Publisher: NSObject {
    private var publisherElement: AEXMLElement
    private(set) var id: Int
    private(set) var state: String
    private(set) var lastError: String
    private(set) var errorCount: Int?
    private(set) var publishTo: PublisherPublishTo?
    
    open var publishToSource: (isG4: Bool, source: SourceType, index: Int, Bus: String) {
        return HelperMethods.findSource(sourceAddress: publishTo!.subscription.address!)
    }
    
    override open var description: String {
        return publisherElement.xml
    }
    
    required public init(publisherData: AEXMLElement) {
        publisherElement = publisherData
        
        id = publisherElement["id"].int!
        state = publisherElement["state"].string
        lastError = publisherElement["lasterror"].string
        errorCount = publisherElement["numbererrors"].int
        
        if publisherElement["publishto"]["ip"].value != nil {
            publishTo = PublisherPublishTo(publishToData: publisherElement["publishto"])
        }
    }
}
