//
//  BMPanel.swift
//  NF3500_SDK
//
//  Created by Michael Dorak on 7/26/17.
//  Copyright © 2017 Michael Dorak. All rights reserved.
//

import AEXML

open class BMPanel: NSObject {
    private var panelElement: AEXMLElement
    private(set) var id: Int
    private(set) var type: String
    private(set) var breakers: [(id: Int, nametag: String, state: String)]?
    
    required public init(panelData: AEXMLElement) {
        panelElement = panelData
        
        id = panelElement["id"].int!
        type = panelElement["type"].string
        
        if !panelElement["breakers"]["breaker"].all!.isEmpty {
            breakers = [(id: Int, nametag: String, state: String)]()
            
            for breaker in panelElement["breakers"]["breaker"].all! {
                breakers!.append((breaker["id"].int!, breaker["nametag"].string, breaker["state"].string))
            }
        }
    }
}
