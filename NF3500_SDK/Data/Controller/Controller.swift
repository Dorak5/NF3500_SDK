//
//  Controller.swift
//  NF3500_SDK
//
//  Created by Michael Dorak on 7/17/17.
//  Copyright © 2017 Michael Dorak. All rights reserved.
//

import AEXML

open class Controller: NSObject {
    private var controllerElement: AEXMLElement
    private(set) var id: Int
    private(set) var nametag: String
    private(set) var frontPanelEnabled: Bool
    private(set) var haltModeEnabled: Bool
    private(set) var commsLossEnabled: Bool
    
    private(set) var eventEnables: (inputs: Bool, zones: Bool, zoneOverride: Bool, config: Bool, firmware: Bool, specialDay: Bool, schedule: Bool, breaker: Bool, breakerLearning: Bool, reset: Bool, bus: Bool, breakerPresent:Bool)
    
    private(set) var breakerTimer: (blinkToOff: Int, staggerDelay: Int, verificationDelay: Int, pulseDuration: Int, pulseRepeat: Int)
    
    //Not sure what this is???
    private(set) var frontPanelTo: Int
    
    private(set) var commsLoss: (setTime: Int, status: Int)
    private(set) var controllerStatus: (tempC: Int, tempF: Int, processorUsage: Int)
    private(set) var manufacturingData: (model: String, hwSeries: String, serialNumber: String, domMonth: String, domDay: String, domYear: String)
    private(set) var firmware: (boot: String, download: String, app: String, beta: String)
    private(set) var communications: Communications
    private(set) var clock: Clock
    
    override open var description: String{
        return controllerElement.xml
    }
    
    required public init(controllerData: AEXMLElement) {
        controllerElement = controllerData
        
        id = controllerElement["id"].int!
        nametag = controllerElement["nametag"].string
        frontPanelEnabled = controllerElement["frntpnlenable"].string == "YES"
        haltModeEnabled = controllerElement["haltmodenable"].string == "YES"
        commsLossEnabled = controllerElement["commslossenable"].string == "YES"
        
        eventEnables = (controllerElement["eventcntrlenable"]["eventenableinputs"].string == "YES",
                        controllerElement["eventcntrlenable"]["eventenablezones"].string == "YES",
                        controllerElement["eventcntrlenable"]["eventenablezoneovr"].string == "YES",
                        controllerElement["eventcntrlenable"]["eventenableconfig"].string == "YES",
                        controllerElement["eventcntrlenable"]["eventenablefirmware"].string == "YES",
                        controllerElement["eventcntrlenable"]["eventenablespecday"].string == "YES",
                        controllerElement["eventcntrlenable"]["eventenablesched"].string == "YES",
                        controllerElement["eventcntrlenable"]["eventenablebreaker"].string == "YES",
                        controllerElement["eventcntrlenable"]["eventenablelearn"].string == "YES",
                        controllerElement["eventcntrlenable"]["eventenablereset"].string == "YES",
                        controllerElement["eventcntrlenable"]["eventenablebus"].string == "YES",
                        controllerElement["eventcntrlenable"]["eventenablebrkrprsnt"].string == "YES")
        
        breakerTimer = (controllerElement["breaker"]["blinktoff"].int!, controllerElement["breaker"]["stagdelay"].int!,
                        controllerElement["breaker"]["brkrverdlay"].int!, controllerElement["sweepswitch"]["sweeppulse"].int!, controllerElement["sweepswitch"]["sweeprepeat"].int!)
        
        frontPanelTo = controllerElement["frntpnlto"].int!
        
        commsLoss = (controllerElement["commsloss"]["settime"].int!, controllerElement["commsloss"]["status"].int!)
        
        controllerStatus = (controllerElement["controllerstatus"]["tempc"].int!,
                            controllerElement["controllerstatus"]["tempf"].int!,
                            controllerElement["controllerstatus"]["procusage"].int!)
        
        manufacturingData = (controllerElement["manufacturingdata"]["model"].string,
                             controllerElement["manufacturingdata"]["hwseries"].string,
                             controllerElement["manufacturingdata"]["serialnumber"].string,
                             controllerElement["manufacturingdata"]["dom"]["month"].string,
                             controllerElement["manufacturingdata"]["dom"]["day"].string,
                             controllerElement["manufacturingdata"]["dom"]["year"].string)
        
        firmware = (controllerElement["firmware"]["boot"].string,
                    controllerElement["firmware"]["download"].string,
                    controllerElement["firmware"]["app"].string,
                    controllerElement["firmware"]["beta"].string)
        
        communications = Communications(commsData: controllerElement["comms"])
        clock = Clock(clockData: controllerElement["clock"])
    }
}
