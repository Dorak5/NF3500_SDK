//
//  Subscriber.swift
//  NF3500_SDK
//
//  Created by Michael Dorak on 7/21/17.
//  Copyright © 2017 Michael Dorak. All rights reserved.
//

import AEXML

open class Subscriber: Source {
    private var subscriberElement: AEXMLElement
    private(set) open var defaultActionStatus: Bool?
    private(set) open var lastError: String
    private(set) open var errorCount: Int?
    private(set) open var subscribeTo: SubscribeTo?
    private(set) open var publishTo: SubscriberPublishTo?
    private(set) open var defaultAction: String
    
    open var subscribeToSource: (isG4: Bool, source: SourceType, index: Int, Bus: String) {
        return HelperMethods.findSource(sourceAddress: subscribeTo!.sourceAddress.state!)
    }
    
    open var publishToSource: (isG4: Bool, source: SourceType, index: Int, Bus: String) {
        return HelperMethods.findSource(sourceAddress: publishTo!.sourceAddress.state!)
    }
    
    override open var description: String {
        return subscriberElement.xml
    }
    
    required public init(subscriberData: AEXMLElement) {
        subscriberElement = subscriberData
        
        if subscriberElement["defaultactionstatus"].value != nil {
            defaultActionStatus = self.subscriberElement["defaultactionstatus"].string == "ON"
        }
        
        lastError = subscriberElement["lasterror"].string
        errorCount = subscriberElement["numbererrors"].int!
        
        if subscriberElement["subscribeto"]["ip"].value != nil {
            subscribeTo = SubscribeTo(subscribeTo: subscriberElement["subscribeto"])
        }
        
        if subscriberElement["publishto"]["heartbeat"].value != nil {
            publishTo = SubscriberPublishTo(publishToData: subscriberElement["publishto"])
        }
        
        if subscriberElement["defaultaction"]["binary"].value != nil {
            defaultAction = subscriberElement["defaultaction"]["binary"].string
        }
        else if subscriberElement["defaultaction"]["analog"].value != nil {
            defaultAction = subscriberElement["defaultaction"]["analog"].string
        }
        else {
            defaultAction = ""
        }
        
        super.init()
        
        id = Int(subscriberData["id"].string)!
        nametag = subscriberData["nametag"].string
        defined = (subscriberData["defined"].string == "YES" ? true : false)
        active = (subscriberData["active"].string == "YES" ? true : false)
        state = subscriberData["state"].string
    }
    
//    private func findSource(sourceAddress: Int) -> (isG4: Bool, source: SourceType, index: Int, Bus: String) {
//        var source = SourceType.undefined
//        var isG4 = true
//        var index = 0
//        var bus = ""
//        
//        if (sourceAddress >= 4001) && (sourceAddress <= 4004) {
//            source = SourceType.terminal
//            isG4 = true
//            index = sourceAddress - 4000
//        }
//        else if (sourceAddress >= 4457) && (sourceAddress <= 4712) {
//            source = SourceType.input
//            isG4 = true
//            index = sourceAddress - 4456
//        }
//        else if (sourceAddress >= 4801) && (sourceAddress <= 4864) {
//            source = SourceType.remoteSource
//            isG4 = true
//            index = sourceAddress - 4800
//        }
//        else if (sourceAddress >= 10001) && (sourceAddress <= 10064) {
//            source = SourceType.input
//            isG4 = false
//            index = sourceAddress - 10000
//        }
//        else if (sourceAddress >= 10500) && (sourceAddress <= 10515) {
//            source = SourceType.schedule
//            isG4 = false
//            index = sourceAddress - 10499
//        }
//        else if (sourceAddress >= 12000) && (sourceAddress <= 12063) {
//            source = SourceType.zone
//            isG4 = false
//            index = sourceAddress - 11999
//        }
//        else if (sourceAddress >= 20001) && (sourceAddress <= 20016) {
//            source = SourceType.terminal
//            isG4 = true
//            index = sourceAddress - 20000
//        }
//        else if (sourceAddress >= 20201) && (sourceAddress <= 20456) {
//            source = SourceType.input
//            isG4 = true
//            index = sourceAddress - 20200
//        }
//        else if (sourceAddress >= 22101) && (sourceAddress <= 22356) {
//            source = SourceType.zone
//            isG4 = true
//            index = sourceAddress - 22100
//        }
//        else if (sourceAddress >= 24001) && (sourceAddress <= 24064) {
//            source = SourceType.schedule
//            isG4 = true
//            index = sourceAddress - 24000
//        }
//        else if (sourceAddress >= 26189) && (sourceAddress <= 26444) {
//            source = SourceType.input
//            isG4 = true
//            index = sourceAddress - 26188
//        }
//        else if (sourceAddress >= 26445) && (sourceAddress <= 26700) {
//            source = SourceType.input
//            isG4 = true
//            index = sourceAddress - 26444
//        }
//        else if (sourceAddress >= 26701) && (sourceAddress <= 27212) {
//            source = SourceType.breaker
//            isG4 = true
//            index = ((sourceAddress - 26701) % 32) + 1
//            let busIndex = ((sourceAddress - 26701) / 32)
//            
//            switch busIndex {
//            case 0:
//                bus = "A"
//                break
//            case 1:
//                bus = "B"
//                break
//            case 2:
//                bus = "C"
//                break
//            case 3:
//                bus = "D"
//                break
//            case 4:
//                bus = "E"
//                break
//            case 5:
//                bus = "F"
//                break
//            case 6:
//                bus = "G"
//                break
//            case 7:
//                bus = "H"
//                break
//            case 8:
//                bus = "I"
//                break
//            case 9:
//                bus = "J"
//                break
//            case 10:
//                bus = "K"
//                break
//            case 11:
//                bus = "L"
//                break
//            case 12:
//                bus = "M"
//                break
//            case 13:
//                bus = "N"
//                break
//            case 14:
//                bus = "O"
//                break
//            case 15:
//                bus = "P"
//                break
//            default:
//                bus = "UnKnown"
//            }
//        }
//        
//        return (isG4, source, index, bus)
//    }
}
