//
//  TerminalSource.swift
//  NF3500_SDK
//
//  Created by Michael Dorak on 7/10/17.
//  Copyright © 2017 Michael Dorak. All rights reserved.
//

import AEXML

public class TerminalSource: NSObject {
    private var sourceElement: AEXMLElement
    private(set) public var source: SourceType
    private(set) public var id: Int
    private(set) public var panel: Int?
    private(set) public var state: String?
    
    required public init(sourceElement: AEXMLElement) {
        self.sourceElement = sourceElement
        
        if let source = SourceType(rawValue: sourceElement["src"].string) {
            self.source = source
        }
        else {
            source = SourceType.undefined
        }
        
        id = sourceElement["id"].int!
        panel = sourceElement["panel"].int
        state = sourceElement["state"].string
    }
}
