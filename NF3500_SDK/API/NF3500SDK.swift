//
//  NF3500SDK.swift
//  NF3500_SDK
//
//  Created by Michael Dorak on 7/10/17.
//  Copyright © 2017 Michael Dorak. All rights reserved.
//

import Alamofire
import AEXML

open class NF3500SDK: NSObject{
    open static let shared = NF3500SDK()
    
    private let reachabilityManager = Comms.shared.reachabilityManager
    
    open var isWifiReachable: Bool{
        return NF3500SDK.shared.reachabilityManager.isReachableOnEthernetOrWiFi
    }
    
    open func setIpAddressAndPassword(ipAddress: String, password: String) {
        let baseUrl = "http://\(ipAddress)"
        Comms.shared.setUrlAndPasswrod(url: baseUrl, password: password)
    }
    
    // MARK: - Zone API Calls
    
    open func retrieveZone(index: Int, success: ((Zone)->Void)?, failure: ((Error)->Void)?, completed: (()->Void)?) {
        if (index < 1) || (index > 256) {
            if let failure = failure {
                failure(NF3500SdkError.zoneIndexOutOfRange)
            }
            if let completed = completed {
                completed()
            }
            
            return
        }
        
        let request = Comms.RestCalls.getZoneData("\(index)").request
        Comms.shared.executeRequest(request: request, requiredValidSession: false,
            success: { zoneData in
                var passed = true
                let zoneElement: AEXMLElement
                do{
                    let xmlDoc = try AEXMLDocument(xml: zoneData)
                    zoneElement = xmlDoc.root["zone"]
                    print(xmlDoc.xml)
                }
                catch {
                    debugPrint("\(error)")
                    if let failure = failure {
                        failure(error)
                    }
                    zoneElement = AEXMLElement(name: "")
                    passed = false
                }

                if passed {
                    let zone = Zone(zoneData: zoneElement)
                    if let success = success {
                        success(zone)
                    }
                }
            },
            failure: { errorObject in
                if let failure = failure {
                    failure(errorObject)
                }
            },
            completed: {
                if let completed = completed {
                    completed()
                }
            })

    }
    
    open func retrieveZones(success: (([Zone])->Void)?, failure: ((Error)->Void)?, completed: (()->Void)?) {
        let request = Comms.RestCalls.getZoneData("0").request
        Comms.shared.executeRequest(request: request, notificationName: nil, requiredValidSession: false,
            success: { zonesData in
                var passed = true
                let zonesDoc: AEXMLDocument
                var zones = [Zone]()
                
                do{
                    zonesDoc = try AEXMLDocument(xml: zonesData)
                    print(zonesDoc.xml)
                }
                catch {
                    debugPrint("\(error)")
                    if let failure = failure {
                        failure(error)
                    }
                    zonesDoc = AEXMLDocument()
                    passed = false
                }
                
                if passed {
                    for index in 1...(zonesDoc.root.children.count - 1) {
                        zones.append(Zone(zoneData: zonesDoc.root.children[index]))
                    }
                    
                    if let success = success {
                        success(zones)
                    }
                }
            },
            failure: { errorObject in
                if let error = failure {
                    error(errorObject)
                }
            },
            completed: {
                if let completed = completed {
                    completed()
                }
            })
    }
    
    open func overrideZone(index: Int, state: ZoneOverrideState, success: ((SourceState)->Void)?, failure: ((Error)->Void)?, completed: (()->Void)?) {
        let request = Comms.RestCalls.overrideZoneState("\(index)", state.rawValue).request
        Comms.shared.executeRequest(request: request, requiredValidSession: false,
            success: { stateData in
                var passed = true
                let sourceElement: AEXMLElement
                
                do{
                    let xmlDoc = try AEXMLDocument(xml: stateData)
                    sourceElement = xmlDoc.root["zone"]
                    print(xmlDoc.xml)
                }
                catch {
                    print("\(error)")
                    if let failure = failure {
                        failure(error)
                    }
                    sourceElement = AEXMLElement(name: "")
                    passed = false
                }
                
                if passed {
                    let zoneState = SourceState(sourceState: sourceElement)
                    if let success = success {
                        success(zoneState)
                    }
                }
            },
            failure: { errorObject in
                if let failure = failure {
                    failure(errorObject)
                }
            },
            completed: {
                if let completed = completed {
                    completed()
                }
            })
    }
    
    // MARK: - Terminal API Calls
    
    open func retrieveTerminal(index: Int, success: ((Terminal)->Void)?, failure: ((Error)->Void)?, completed: (()->Void)?) {
        if (index < 1) || (index > 16) {
            if let failure = failure {
                failure(NF3500SdkError.terminalIndexOutOfRange)
            }
            if let completed = completed {
                completed()
            }
            
            return
        }
        let request = Comms.RestCalls.getTerminalData("\(index)").request
        Comms.shared.executeRequest(request: request, requiredValidSession: false,
            success: { terminalData in
                var passed = true
                let terminalElement: AEXMLElement
                do{
                    let xmlDoc = try AEXMLDocument(xml: terminalData)
                    terminalElement = xmlDoc.root["terminal"]
                    print(xmlDoc.xml)
                }
                catch {
                    debugPrint("\(error)")
                    if let failure = failure {
                        failure(error)
                    }
                    terminalElement = AEXMLElement(name: "")
                    passed = false
                }
                                        
                if passed {
                    let terminal = Terminal(terminalData: terminalElement)
                    if let success = success {
                        success(terminal)
                    }
                }
            },
            failure: { errorObject in
                if let failure = failure {
                    failure(errorObject)
                }
            },
            completed: {
                if let completed = completed {
                    completed()
                }
            })
        
    }
    
    open func retrieveTerminals(success: (([Terminal])->Void)?, failure: ((Error)->Void)?, completed: (()->Void)?) {
        let request = Comms.RestCalls.getTerminalData("0").request
        Comms.shared.executeRequest(request: request, notificationName: nil, requiredValidSession: false,
            success: { terminalsData in
                var passed = true
                let terminalsDoc: AEXMLDocument
                var terminals = [Terminal]()
                                        
                do{
                    terminalsDoc = try AEXMLDocument(xml: terminalsData)
                    print(terminalsDoc.xml)
                }
                catch {
                    debugPrint("\(error)")
                    if let failure = failure {
                        failure(error)
                    }
                    terminalsDoc = AEXMLDocument()
                    passed = false
                }
                                        
                if passed {
                    for index in 1...(terminalsDoc.root.children.count - 1) {
                        terminals.append(Terminal(terminalData: terminalsDoc.root.children[index]))
                    }
                    
                    if let success = success {
                        success(terminals)
                    }
                }
            },
            failure: { errorObject in
                if let error = failure {
                    error(errorObject)
                }
            },
            completed: {
                if let completed = completed {
                    completed()
                }
            })
    }
    
    // MARK: - Input API Calls
    
    open func retrieveInput(index: Int, success: ((Input)->Void)?, failure: ((Error)->Void)?, completed: (()->Void)?) {
        if (index < 1) || (index > 256) {
            if let failure = failure {
                failure(NF3500SdkError.inputIndexOutOfRange)
            }
            if let completed = completed {
                completed()
            }
            
            return
        }
        
        let request = Comms.RestCalls.getInputData("\(index)").request
        Comms.shared.executeRequest(request: request, requiredValidSession: false,
            success: { inputData in
                var passed = true
                let inputElement: AEXMLElement
                
                do{
                    let xmlDoc = try AEXMLDocument(xml: inputData)
                    inputElement = xmlDoc.root["input"]
                    print(xmlDoc.xml)
                }
                catch {
                    debugPrint("\(error)")
                    if let failure = failure {
                        failure(error)
                    }
                    inputElement = AEXMLElement(name: "")
                    passed = false
                }
                                        
                if passed {
                    let input = Input(inputData: inputElement)
                    if let success = success {
                        success(input)
                    }
                }
            },
            failure: { errorObject in
                if let failure = failure {
                    failure(errorObject)
                }
            },
            completed: {
                if let completed = completed {
                    completed()
                }
            })
    }
    
    open func retrieveInputs(success: (([Input])->Void)?, failure: ((Error)->Void)?, completed: (()->Void)?) {
        let request = Comms.RestCalls.getInputData("0").request
        Comms.shared.executeRequest(request: request, notificationName: nil, requiredValidSession: false,
            success: { inputsData in
                var passed = true
                let inputsDoc: AEXMLDocument
                var inputs = [Input]()
                                        
                do{
                    inputsDoc = try AEXMLDocument(xml: inputsData)
                    print(inputsDoc.xml)
                }
                catch {
                    debugPrint("\(error)")
                    if let failure = failure {
                        failure(error)
                    }
                    inputsDoc = AEXMLDocument()
                    passed = false
                }
                                        
                if passed {
                    for index in 1...(inputsDoc.root.children.count - 1) {
                        inputs.append(Input(inputData: inputsDoc.root.children[index]))
                    }
                                            
                    if let success = success {
                        success(inputs)
                    }
                }
            },
            failure: { errorObject in
                if let error = failure {
                    error(errorObject)
                }
            },
            completed: {
                if let completed = completed {
                    completed()
                }
            })
    }

    open func changeInputDigitalState(index: Int, state: Bool, success: ((SourceState)->Void)?, failure: ((Error)->Void)?, completed: (()->Void)?) {
        let request = Comms.RestCalls.setDigitalInputState("\(index)", (state ? "ON" : "OFF")).request
        Comms.shared.executeRequest(request: request, requiredValidSession: false,
            success: { stateData in
                var passed = true
                let sourceElement: AEXMLElement
                                        
                do{
                    let xmlDoc = try AEXMLDocument(xml: stateData)
                    sourceElement = xmlDoc.root["input"]
                    print(xmlDoc.xml)
                }
                catch {
                    print("\(error)")
                    if let failure = failure {
                        failure(error)
                    }
                    sourceElement = AEXMLElement(name: "")
                    passed = false
                }
                                        
                if passed {
                    let inputDigitalState = SourceState(sourceState: sourceElement)
                        if let success = success {
                            success(inputDigitalState)
                        }
                    }
            },
            failure: { errorObject in
                if let failure = failure {
                    failure(errorObject)
                }
            },
            completed: {
                if let completed = completed {
                    completed()
                }
            })
    }

    open func changeInputAnalogState(index: Int, state: Int, success: ((SourceState)->Void)?, failure: ((Error)->Void)?, completed: (()->Void)?) {
        
        if (state < 0) || (state > 100) {
            if let failure = failure {
                failure(NF3500SdkError.analogStateOutOfRange)
            }
            if let completed = completed {
                completed()
            }
            
            return
        }
        
        let request = Comms.RestCalls.setAnalogInputState("\(index)", "\(state)").request
        Comms.shared.executeRequest(request: request, requiredValidSession: false,
            success: { stateData in
                var passed = true
                let sourceElement: AEXMLElement
                                        
                do{
                    let xmlDoc = try AEXMLDocument(xml: stateData)
                    sourceElement = xmlDoc.root["input"]
                    print(xmlDoc.xml)
                }
                catch {
                    print("\(error)")
                    if let failure = failure {
                        failure(error)
                    }
                    sourceElement = AEXMLElement(name: "")
                    passed = false
                }
                                        
                if passed {
                    let inputDigitalState = SourceState(sourceState: sourceElement)
                    if let success = success {
                        success(inputDigitalState)
                    }
                }
            },
            failure: { errorObject in
                if let failure = failure {
                    failure(errorObject)
                }
            },
            completed: {
                if let completed = completed {
                    completed()
                }
            })
    }

    open func changeInputInhibitState(index: Int, state: Bool, success: ((SourceState)->Void)?, failure: ((Error)->Void)?, completed: (()->Void)?) {
        let request = Comms.RestCalls.setInputInhibitState("\(index)", (state ? "ON" : "OFF")).request
        Comms.shared.executeRequest(request: request, requiredValidSession: false,
            success: { stateData in
                var passed = true
                let sourceElement: AEXMLElement
                                        
                do{
                    let xmlDoc = try AEXMLDocument(xml: stateData)
                    sourceElement = xmlDoc.root["input"]
                    print(xmlDoc.xml)
                }
                catch {
                    print("\(error)")
                    if let failure = failure {
                        failure(error)
                    }
                    sourceElement = AEXMLElement(name: "")
                    passed = false
                }
                                        
                if passed {
                    let inputDigitalState = SourceState(sourceState: sourceElement)
                    if let success = success {
                        success(inputDigitalState)
                    }
                }
            },
            failure: { errorObject in
                if let failure = failure {
                    failure(errorObject)
                }
            },
            completed: {
                if let completed = completed {
                    completed()
                }
            })
    }
    
    // MARK: - Schedule API Calls
    
    open func retrieveSchedule(index: Int, success: ((Schedule)->Void)?, failure: ((Error)->Void)?, completed: (()->Void)?) {
        if (index < 1) || (index > 64) {
            if let failure = failure {
                failure(NF3500SdkError.zoneIndexOutOfRange)
            }
            if let completed = completed {
                completed()
            }
            
            return
        }
        
        let request = Comms.RestCalls.getScheduleData("\(index)").request
        Comms.shared.executeRequest(request: request, requiredValidSession: false,
            success: { scheduleData in
                var passed = true
                let scheduleElement: AEXMLElement
                do{
                    let xmlDoc = try AEXMLDocument(xml: scheduleData)
                    scheduleElement = xmlDoc.root["sched"]
                    print(xmlDoc.xml)
                }
                catch {
                    debugPrint("\(error)")
                    if let failure = failure {
                        failure(error)
                    }
                    scheduleElement = AEXMLElement(name: "")
                    passed = false
                }
                                        
                if passed {
                    let schedule = Schedule(scheduleData: scheduleElement)
                    if let success = success {
                        success(schedule)
                    }
                }
            },
            failure: { errorObject in
                if let failure = failure {
                    failure(errorObject)
                }
            },
            completed: {
                if let completed = completed {
                    completed()
                }
            })
    }
    
    open func retrieveSchedules(success: (([Schedule])->Void)?, failure: ((Error)->Void)?, completed: (()->Void)?) {
        let request = Comms.RestCalls.getScheduleData("0").request
        Comms.shared.executeRequest(request: request, notificationName: nil, requiredValidSession: false,
            success: { scheduleData in
                var passed = true
                let scheduleDoc: AEXMLDocument
                var schedules = [Schedule]()
                                        
                do{
                    scheduleDoc = try AEXMLDocument(xml: scheduleData)
                    print(scheduleDoc.xml)
                }
                catch {
                    debugPrint("\(error)")
                    if let failure = failure {
                        failure(error)
                    }
                    scheduleDoc = AEXMLDocument()
                    passed = false
                }
                
                if passed {
                    for index in 1...(scheduleDoc.root.children.count - 1) {
                        schedules.append(Schedule(scheduleData: scheduleDoc.root.children[index]))
                    }
                                            
                    if let success = success {
                        success(schedules)
                    }
                }
            },
            failure: { errorObject in
                if let error = failure {
                    error(errorObject)
                }
            },
            completed: {
                if let completed = completed {
                    completed()
                }
            })
    }
    

    // MARK: - Cbus API Calls
    
    open func retrieveCbus(index: Int, success: ((Cbus)->Void)?, failure: ((Error)->Void)?, completed: (()->Void)?) {
        if (index < 1) || (index > 256) {
            if let failure = failure {
                failure(NF3500SdkError.zoneIndexOutOfRange)
            }
            if let completed = completed {
                completed()
            }
            
            return
        }
        
        let request = Comms.RestCalls.getCbusData("\(index)").request
        Comms.shared.executeRequest(request: request, requiredValidSession: false,
            success: { cbusData in
                var passed = true
                let cbusElement: AEXMLElement
                do{
                    let xmlDoc = try AEXMLDocument(xml: cbusData)
                    cbusElement = xmlDoc.root["cbusout"]
                    print(xmlDoc.xml)
                }
                catch {
                    debugPrint("\(error)")
                    if let failure = failure {
                        failure(error)
                    }
                    cbusElement = AEXMLElement(name: "")
                    passed = false
                }
                                        
                if passed {
                    let cbus = Cbus(cbusData: cbusElement)
                    if let success = success {
                        success(cbus)
                    }
                }
            },
            failure: { errorObject in
                if let failure = failure {
                    failure(errorObject)
                }
            },
            completed: {
                if let completed = completed {
                    completed()
                }
            })
    }
    
    open func retrieveCbuses(success: (([Cbus])->Void)?, failure: ((Error)->Void)?, completed: (()->Void)?) {
        let request = Comms.RestCalls.getCbusData("0").request
        Comms.shared.executeRequest(request: request, notificationName: nil, requiredValidSession: false,
            success: { cbusData in
                var passed = true
                let cbusDoc: AEXMLDocument
                var cbuses = [Cbus]()
                
                do{
                    cbusDoc = try AEXMLDocument(xml: cbusData)
                    print(cbusDoc.xml)
                }
                catch {
                    debugPrint("\(error)")
                    if let failure = failure {
                        failure(error)
                    }
                    cbusDoc = AEXMLDocument()
                    passed = false
                }
                                        
                if passed {
                    for index in 1...(cbusDoc.root.children.count - 1) {
                        cbuses.append(Cbus(cbusData: cbusDoc.root.children[index]))
                    }
                                            
                    if let success = success {
                        success(cbuses)
                    }
                }
            },
            failure: { errorObject in
                if let error = failure {
                    error(errorObject)
                }
            },
            completed: {
                if let completed = completed {
                    completed()
                }
            })
    }
    
    // MARK: - Remote Sources API Calls
    
    open func retrieveSubscriber(index: Int, success: ((Subscriber)->Void)?, failure: ((Error)->Void)?, completed: (()->Void)?) {
        if (index < 1) || (index > 128) {
            if let failure = failure {
                failure(NF3500SdkError.zoneIndexOutOfRange)
            }
            if let completed = completed {
                completed()
            }
            
            return
        }
        
        let request = Comms.RestCalls.getSubscriberData("\(index)").request
        Comms.shared.executeRequest(request: request, requiredValidSession: false,
            success: { subscriberData in
                var passed = true
                let subscriberElement: AEXMLElement
                do{
                    let xmlDoc = try AEXMLDocument(xml: subscriberData)
                    subscriberElement = xmlDoc.root["subscriber"]
                    print(xmlDoc.xml)
                }
                catch {
                    debugPrint("\(error)")
                    if let failure = failure {
                        failure(error)
                    }
                    subscriberElement = AEXMLElement(name: "")
                    passed = false
                }
                                        
                if passed {
                    let subscriber = Subscriber(subscriberData: subscriberElement)
                    if let success = success {
                        success(subscriber)
                    }
                }
            },
            failure: { errorObject in
                if let failure = failure {
                    failure(errorObject)
                }
            },
            completed: {
                if let completed = completed {
                    completed()
                }
            })
    }
    
    open func retrieveSubscribers(success: (([Subscriber])->Void)?, failure: ((Error)->Void)?, completed: (()->Void)?)
    {
        let request = Comms.RestCalls.getSubscriberData("0").request
        Comms.shared.executeRequest(request: request, notificationName: nil, requiredValidSession: false,
            success: { subscriberData in
                var passed = true
                let subscriberDoc: AEXMLDocument
                var subscribers = [Subscriber]()
                                        
                do{
                    subscriberDoc = try AEXMLDocument(xml: subscriberData)
                    print(subscriberDoc.xml)
                }
                catch {
                    debugPrint("\(error)")
                    if let failure = failure {
                        failure(error)
                    }
                    subscriberDoc = AEXMLDocument()
                    passed = false
                }
                                        
                if passed {
                    for index in 1...(subscriberDoc.root.children.count - 1) {
                        subscribers.append(Subscriber(subscriberData: subscriberDoc.root.children[index]))
                    }
                                            
                    if let success = success {
                        success(subscribers)
                    }
                }
            },
            failure: { errorObject in
                if let error = failure {
                    error(errorObject)
                }
            },
            completed: {
                if let completed = completed {
                    completed()
                }
            })
    }
    
    open func retrievePublisher(index: Int, success: ((Publisher)->Void)?, failure: ((Error)->Void)?, completed: (()->Void)?) {
        if (index < 1) || (index > 512) {
            if let failure = failure {
                failure(NF3500SdkError.zoneIndexOutOfRange)
            }
            if let completed = completed {
                completed()
            }
            
            return
        }
        
        let request = Comms.RestCalls.getPublisherData("\(index)").request
        Comms.shared.executeRequest(request: request, requiredValidSession: false,
            success: { publisherData in
                var passed = true
                let publisherElement: AEXMLElement
                do{
                    let xmlDoc = try AEXMLDocument(xml: publisherData)
                    publisherElement = xmlDoc.root["publisher"]
                    print(xmlDoc.xml)
                }
                catch {
                    debugPrint("\(error)")
                    if let failure = failure {
                        failure(error)
                    }
                    publisherElement = AEXMLElement(name: "")
                    passed = false
                }
                                        
                if passed {
                    let publisher = Publisher(publisherData: publisherElement)
                    if let success = success {
                        success(publisher)
                    }
                }
            },
            failure: { errorObject in
                if let failure = failure {
                    failure(errorObject)
                }
            },
            completed: {
                if let completed = completed {
                    completed()
                }
            })
    }
    
    open func retrievePublishers(success: (([Publisher])->Void)?, failure: ((Error)->Void)?, completed: (()->Void)?)
    {
        let request = Comms.RestCalls.getPublisherData("0").request
        Comms.shared.executeRequest(request: request, notificationName: nil, requiredValidSession: false,
            success: { publisherData in
                var passed = true
                let publisherDoc: AEXMLDocument
                var publishers = [Publisher]()
                
                do{
                    publisherDoc = try AEXMLDocument(xml: publisherData)
                    print(publisherDoc.xml)
                }
                catch {
                    debugPrint("\(error)")
                    if let failure = failure {
                        failure(error)
                    }
                    publisherDoc = AEXMLDocument()
                    passed = false
                }
                                        
                if passed {
                    for index in 1...(publisherDoc.root.children.count - 1) {
                        publishers.append(Publisher(publisherData: publisherDoc.root.children[index]))
                    }
                                            
                    if let success = success {
                        success(publishers)
                    }
                }
            },
            failure: { errorObject in
                if let error = failure {
                    error(errorObject)
                }
            },
            completed: {
                if let completed = completed {
                    completed()
                }
            })
    }
    
    // MARK: - Panel API Calls
    
    open func retrievePanel(index: Int, success: ((Panel)->Void)?, failure: ((Error)->Void)?, completed: (()->Void)?) {
        if (index < 0) || (index > 7) {
            if let failure = failure {
                failure(NF3500SdkError.panelIndexOutOfRange)
            }
            if let completed = completed {
                completed()
            }
            
            return
        }
        
        let request = Comms.RestCalls.getPanelData("\(index)").request
        Comms.shared.executeRequest(request: request, requiredValidSession: false,
            success: { panelData in
                var passed = true
                let panelElement: AEXMLElement
                do{
                    let xmlDoc = try AEXMLDocument(xml: panelData)
                    panelElement = xmlDoc.root["panel"]
                    print(xmlDoc.xml)
                }
                catch {
                    debugPrint("\(error)")
                    if let failure = failure {
                        failure(error)
                    }
                    panelElement = AEXMLElement(name: "")
                    passed = false
                }
                                        
                if passed {
                    let panel = Panel(panelData: panelElement)
                    if let success = success {
                        success(panel)
                    }
                }
            },
            failure: { errorObject in
                if let failure = failure {
                    failure(errorObject)
                }
            },
            completed: {
                if let completed = completed {
                    completed()
                }
            })
    }
    
    // MARK: - Controller API Calls
    
    open func retrieveController(success: ((Controller)->Void)?, failure: ((Error)->Void)?, completed: (()->Void)?) {
        let request = Comms.RestCalls.getControllerData("1").request
        Comms.shared.executeRequest(request: request, requiredValidSession: false,
            success: { controllerData in
                var passed = true
                let controllerElement: AEXMLElement
                do{
                    let xmlDoc = try AEXMLDocument(xml: controllerData)
                    controllerElement = xmlDoc.root["controller"]
                    print(xmlDoc.xml)
                }
                catch {
                    debugPrint("\(error)")
                    if let failure = failure {
                        failure(error)
                    }
                    controllerElement = AEXMLElement(name: "")
                    passed = false
                }
                                        
                if passed {
                    let contoller = Controller(controllerData: controllerElement)
                    if let success = success {
                        success(contoller)
                    }
                }
            },
            failure: { errorObject in
                if let failure = failure {
                    failure(errorObject)
                }
            },
            completed: {
                if let completed = completed {
                    completed()
                }
            })
    }
}
