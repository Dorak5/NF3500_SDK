//
//  NF3500_SDKTests.swift
//  NF3500_SDKTests
//
//  Created by Michael Dorak on 7/7/17.
//  Copyright © 2017 Michael Dorak. All rights reserved.
//

import XCTest
import Alamofire
import AEXML

@testable import NF3500_SDK

class NF3500_SDKTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        //NF3500SDK.shared.setIpAddressAndPassword(ipAddress: "192.168.1.35", password: "admin")
        NF3500SDK.shared.setIpAddressAndPassword(ipAddress: "10.167.244.201", password: "admin")
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    // MARK: - Zone tests
    
    func testApiGetZone() {
        let expectation = self.expectation(description: "Zone data")
        
        NF3500SDK.shared.retrieveZone(index: 1,
            success: { zone in
                print(zone.description)
            },
            failure: { error in
                print(error)
                XCTFail("Error response from server. 💩")
            },
            completed: {
                expectation.fulfill()
            })
        
        waitForExpectations(timeout: 30, handler: nil)
    }
    
    func testApiGetZones(){
        let expectation = self.expectation(description: "Zone data")
        
        NF3500SDK.shared.retrieveZones(
            success: { zones in
                print(zones[255].description)
            },
            failure: { error in
                print(error)
                XCTFail("Error response from server. 💩")
            },
            completed: {
                expectation.fulfill()
            })
        
        waitForExpectations(timeout: 30, handler: nil)
    }
    
    func testApiOverrideZone() {
        var expectation = self.expectation(description: "Override Zone On")

        NF3500SDK.shared.overrideZone(index: 1, state: ZoneOverrideState.on,
            success: {zoneState in
                print(zoneState.description)
            },
            failure: { error in
                print(error)
                XCTFail("Error response from server. 💩")
            },
            completed: {
                expectation.fulfill()
            })
        
        waitForExpectations(timeout: 30, handler: nil)
        
        expectation = self.expectation(description: "Override Zone Off")
        
        NF3500SDK.shared.overrideZone(index: 1, state: ZoneOverrideState.off,
            success: {zoneState in
                print(zoneState.description)
            },
            failure: { error in
                print(error)
                XCTFail("Error response from server. 💩")
            },
            completed: {
                expectation.fulfill()
            })
        
        waitForExpectations(timeout: 30, handler: nil)
        
        expectation = self.expectation(description: "Override Zone Release")
        
        NF3500SDK.shared.overrideZone(index: 1, state: ZoneOverrideState.release,
            success: {zoneState in
                print(zoneState.description)
            },
            failure: { error in
                print(error)
                XCTFail("Error response from server. 💩")
            },
            completed: {
                expectation.fulfill()
            })
        
        waitForExpectations(timeout: 30, handler: nil)
    }
    
    func testCommsGetZone() {
        let expectation = self.expectation(description: "Zone data")
        
        let request = Comms.RestCalls.getZoneData("2").request
        Comms.shared.executeRequest(request: request, notificationName: nil, requiredValidSession: false,
            success: { zoneData in
                do {
                    let xmlDoc = try AEXMLDocument(xml: zoneData)
                                            
                    print(xmlDoc.xml)
                    let zone = xmlDoc.root["zone"]
                    print("id = \(zone["id"].string)")
                    print("Override State = \(zone["override"]["state"].string)")
                }
                catch {
                    print("\(error)")
                }
            },
            failure: { error in
                print(error)
                XCTFail("Error response from server. 💩")
            },
            completed: {
                expectation.fulfill()
            })
        
        waitForExpectations(timeout: 30, handler: nil)
    }
    
    func testCommsGetZones() {
        let expectation = self.expectation(description: "Zones data")
        
        let request = Comms.RestCalls.getZoneData("0").request
        Comms.shared.executeRequest(request: request, notificationName: nil, requiredValidSession: false,
            success: { zonesData in
                do {
                    let xmlDoc = try AEXMLDocument(xml: zonesData)
                    
                    //print(xmlDoc.xml)
                    print(xmlDoc.root.children[2].xml)
                    //let zone = xmlDoc.root["zone"]
                    //print("id = \(zone["id"].string)")
                    //print("Override State = \(zone["override"]["state"].string)")
                }
                catch {
                    print("\(error)")
                }
            },
            failure: { error in
                print(error)
                XCTFail("Error response from server. 💩")
            },
            completed: {
                expectation.fulfill()
            })
        
        waitForExpectations(timeout: 30, handler: nil)
    }
    
    func testCommsOverrideZone() {
        var expectation = self.expectation(description: "Override Zone On")
        
        var request = Comms.RestCalls.overrideZoneState("1", ZoneOverrideState.on.rawValue).request
        Comms.shared.executeRequest(request: request, requiredValidSession: false,
            success: {zoneState in
                //print(zoneState.base64EncodedString().fromBase64())
                do {
                    let xmlDoc = try AEXMLDocument(xml: zoneState)
                    
                    print(xmlDoc.xml)
                }
                catch {
                    print("\(error)")
                }
            },
            failure: { error in
                print(error)
                XCTFail("Error response from server. 💩")
            },
            completed: {
                expectation.fulfill()
            })
        
        waitForExpectations(timeout: 30, handler: nil)
        
        expectation = self.expectation(description: "Override Zone Off")
        
        request = Comms.RestCalls.overrideZoneState("1", ZoneOverrideState.off.rawValue).request
        Comms.shared.executeRequest(request: request, requiredValidSession: false,
            success: {zoneState in
                //print(zoneState.base64EncodedString().fromBase64())
                do {
                    let xmlDoc = try AEXMLDocument(xml: zoneState)
                                            
                    print(xmlDoc.xml)
                }
                catch {
                    print("\(error)")
                }
            },
            failure: { error in
                print(error)
                XCTFail("Error response from server. 💩")
            },
            completed: {
                expectation.fulfill()
            })
        
        waitForExpectations(timeout: 30, handler: nil)
        
        expectation = self.expectation(description: "Override Zone Release")
        
        request = Comms.RestCalls.overrideZoneState("1", ZoneOverrideState.release.rawValue).request
        Comms.shared.executeRequest(request: request, requiredValidSession: false,
            success: {zoneState in
                //print(zoneState.base64EncodedString().fromBase64())
                do {
                    let xmlDoc = try AEXMLDocument(xml: zoneState)
                                            
                    print(xmlDoc.xml)
                }
                catch {
                    print("\(error)")
                }
            },
            failure: { error in
                print(error)
                XCTFail("Error response from server. 💩")
            },
            completed: {
                expectation.fulfill()
            })
        
        waitForExpectations(timeout: 30, handler: nil)
    }
    
    // MARK: - Terminal tests
    
    func testApiGetTerminal() {
        let expectation = self.expectation(description: "Terminal data")
        
        NF3500SDK.shared.retrieveTerminal(index: 1,
            success: { terminal in
                print(terminal.description)
            },
            failure: { error in
                print(error)
                XCTFail("Error response from server. 💩")
            },
            completed: {
                expectation.fulfill()
            })
        
        waitForExpectations(timeout: 30, handler: nil)
    }
    
    func testApiGetTerminals(){
        let expectation = self.expectation(description: "Terminals data")
        
        NF3500SDK.shared.retrieveTerminals(
            success: { terminals in
                print(terminals[terminals.count - 1].description)
            },
            failure: { error in
                print(error)
                XCTFail("Error response from server. 💩")
            },
            completed: {
                expectation.fulfill()
            })
        
        waitForExpectations(timeout: 30, handler: nil)
    }

    
    func testCommsGetTerminal() {
        let expectation = self.expectation(description: "Terminal data")
        
        let request = Comms.RestCalls.getTerminalData("1").request
        Comms.shared.executeRequest(request: request, notificationName: nil, requiredValidSession: false,
            success: { terminalData in
                do {
                    let xmlDoc = try AEXMLDocument(xml: terminalData)
                    print(xmlDoc.xml)
                }
                catch {
                    print("\(error)")
                }
            },
            failure: { error in
                print(error)
                XCTFail("Error response from server. 💩")
            },
            completed: {
                expectation.fulfill()
            })
        
        waitForExpectations(timeout: 30, handler: nil)
    }
    
    func testCommsGetTerminals() {
        let expectation = self.expectation(description: "terminals data")
        
        let request = Comms.RestCalls.getTerminalData("0").request
        Comms.shared.executeRequest(request: request, notificationName: nil, requiredValidSession: false,
            success: { terminalsData in
                do {
                    let xmlDoc = try AEXMLDocument(xml: terminalsData)
                    print(xmlDoc.xml)
                    print(xmlDoc.root.children[2].xml)
                }
                catch {
                    print("\(error)")
                }
            },
            failure: { error in
                print(error)
                XCTFail("Error response from server. 💩")
            },
            completed: {
                expectation.fulfill()
            })
        
        waitForExpectations(timeout: 30, handler: nil)
    }
    
    // MARK: - Input tests
    
    func testApiGetInput() {
        let expectation = self.expectation(description: "Input data")
        
        NF3500SDK.shared.retrieveInput(index: 1,
            success: { input in
                print(input.description)
            },
            failure: { error in
                print(error)
                XCTFail("Error response from server. 💩")
            },
            completed: {
                expectation.fulfill()
            })
        
        waitForExpectations(timeout: 30, handler: nil)
    }
    
    func testApiGetInputs(){
        let expectation = self.expectation(description: "Inputs data")
        
        NF3500SDK.shared.retrieveInputs(
            success: { inputs in
                print(inputs[255].description)
        },
            failure: { error in
                print(error)
                XCTFail("Error response from server. 💩")
        },
            completed: {
                expectation.fulfill()
        })
        
        waitForExpectations(timeout: 30, handler: nil)
    }
    
    func testApiChangeInputDigitalState() {
        var expectation = self.expectation(description: "Change Input Digital State On")
        
        NF3500SDK.shared.changeInputDigitalState(index: 1, state: true,
            success: {inputState in
                print(inputState.description)
            },
            failure: { error in
                print(error)
                XCTFail("Error response from server. 💩")
            },
            completed: {
                expectation.fulfill()
            })
        
        waitForExpectations(timeout: 30, handler: nil)
        
        expectation = self.expectation(description: "Change Input Digital State Off")
        
        NF3500SDK.shared.changeInputDigitalState(index: 1, state: false,
            success: {inputState in
                print(inputState.description)
            },
            failure: { error in
                print(error)
                XCTFail("Error response from server. 💩")
            },
            completed: {
                expectation.fulfill()
            })
        
        waitForExpectations(timeout: 30, handler: nil)
    }

    func testApiChangeInputAnalogState() {
        var expectation = self.expectation(description: "Change Input Analog State 75")
        
        NF3500SDK.shared.changeInputAnalogState(index: 1, state: 75,
            success: {inputState in
                print(inputState.description)
            },
            failure: { error in
                print(error)
                XCTFail("Error response from server. 💩")
            },
            completed: {
                expectation.fulfill()
            })
        
        waitForExpectations(timeout: 30, handler: nil)
        
        expectation = self.expectation(description: "Change Input Analog State 0")
        
        NF3500SDK.shared.changeInputAnalogState(index: 1, state: 0,
            success: {inputState in
                print(inputState.description)
            },
            failure: { error in
                print(error)
                XCTFail("Error response from server. 💩")
            },
            completed: {
                expectation.fulfill()
            })
        
        waitForExpectations(timeout: 30, handler: nil)
        
        expectation = self.expectation(description: "Change Input Analog State 110")
        
        NF3500SDK.shared.changeInputAnalogState(index: 1, state: 110,
            success: {inputState in
                print(inputState.description)
                XCTFail("Test should fail with state of 110. 💩")
            },
            failure: { error in
                print(error)
            },
            completed: {
                expectation.fulfill()
            })
        
        waitForExpectations(timeout: 30, handler: nil)
        
        expectation = self.expectation(description: "Change Input Analog State -1")
        
        NF3500SDK.shared.changeInputAnalogState(index: 1, state: -1,
            success: {inputState in
                print(inputState.description)
                XCTFail("Test should fail with state of 110. 💩")
            },
            failure: { error in
                print(error)
            },
            completed: {
                expectation.fulfill()
            })
        
        waitForExpectations(timeout: 30, handler: nil)
    }
    
    func testApiChangeInputInhibitState() {
        var expectation = self.expectation(description: "Change Input Inhibit State On")
        
        NF3500SDK.shared.changeInputInhibitState(index: 1, state: true,
            success: {inputState in
                print(inputState.description)
            },
            failure: { error in
                print(error)
                XCTFail("Error response from server. 💩")
            },
            completed: {
                expectation.fulfill()
            })
        
        waitForExpectations(timeout: 30, handler: nil)
        
        expectation = self.expectation(description: "Change Input Inhibit State Off")
        
        NF3500SDK.shared.changeInputInhibitState(index: 1, state: false,
            success: {inputState in
                print(inputState.description)
            },
            failure: { error in
                print(error)
                XCTFail("Error response from server. 💩")
            },
            completed: {
                expectation.fulfill()
            })
        
        waitForExpectations(timeout: 30, handler: nil)
    }
    
    func testCommsGetInput() {
        let expectation = self.expectation(description: "Input data")
        
        let request = Comms.RestCalls.getInputData("100").request
        Comms.shared.executeRequest(request: request, notificationName: nil, requiredValidSession: false,
            success: { inputData in
                do {
                    let xmlDoc = try AEXMLDocument(xml: inputData)
                    print(xmlDoc.xml)
                }
                catch {
                    print("\(error)")
                }
            },
            failure: { error in
                print(error)
                XCTFail("Error response from server. 💩")
            },
            completed: {
                expectation.fulfill()
            })
        
        waitForExpectations(timeout: 30, handler: nil)
    }
    
    func testCommsGetInputs() {
        let expectation = self.expectation(description: "Inputs data")
        
        let request = Comms.RestCalls.getInputData("0").request
        Comms.shared.executeRequest(request: request, notificationName: nil, requiredValidSession: false,
            success: { inputsData in
                do {
                    let xmlDoc = try AEXMLDocument(xml: inputsData)
                    print(xmlDoc.root.children[2].xml)
                }
                catch {
                    print("\(error)")
                }
            },
            failure: { error in
                print(error)
                XCTFail("Error response from server. 💩")
            },
            completed: {
                expectation.fulfill()
            })
        
        waitForExpectations(timeout: 30, handler: nil)
    }
    
    func testCommsChangeInputBinaryState() {
        var expectation = self.expectation(description: "Change Input binary state On")
        
        var request = Comms.RestCalls.setDigitalInputState("1", "ON").request
        Comms.shared.executeRequest(request: request, requiredValidSession: false,
            success: {inputState in
                //print(inputState.base64EncodedString().fromBase64())
                do {
                    let xmlDoc = try AEXMLDocument(xml: inputState)
                    print(xmlDoc.xml)
                }
                catch {
                    print("\(error)")
                }
            },
            failure: { error in
                print(error)
                XCTFail("Error response from server. 💩")
            },
            completed: {
                expectation.fulfill()
            })
        
        waitForExpectations(timeout: 30, handler: nil)
        
        expectation = self.expectation(description: "Override Zone Off")
        
        request = Comms.RestCalls.setDigitalInputState("1", "OFF").request
        Comms.shared.executeRequest(request: request, requiredValidSession: false,
            success: {inputState in
                //print(zoneState.base64EncodedString().fromBase64())
                do {
                    let xmlDoc = try AEXMLDocument(xml: inputState)
                    print(xmlDoc.xml)
                }
                catch {
                    print("\(error)")
                }
            },
            failure: { error in
                print(error)
                XCTFail("Error response from server. 💩")
            },
            completed: {
                expectation.fulfill()
            })
        
        waitForExpectations(timeout: 30, handler: nil)
    }
    
    func testCommsChangeInputAnalogState() {
        var expectation = self.expectation(description: "Change Input binary state On")
        
        var request = Comms.RestCalls.setAnalogInputState("1", "50").request
        Comms.shared.executeRequest(request: request, requiredValidSession: false,
            success: {inputState in
                //print(inputState.base64EncodedString().fromBase64())
                do {
                    let xmlDoc = try AEXMLDocument(xml: inputState)
                    print(xmlDoc.xml)
                }
                catch {
                    print("\(error)")
                }
            },
            failure: { error in
                print(error)
                XCTFail("Error response from server. 💩")
            },
            completed: {
                expectation.fulfill()
            })
        
        waitForExpectations(timeout: 30, handler: nil)
        
        expectation = self.expectation(description: "Override Zone Off")
        
        request = Comms.RestCalls.setAnalogInputState("1", "0").request
        Comms.shared.executeRequest(request: request, requiredValidSession: false,
            success: {inputState in
                //print(zoneState.base64EncodedString().fromBase64())
                do {
                    let xmlDoc = try AEXMLDocument(xml: inputState)
                    print(xmlDoc.xml)
                }
                catch {
                    print("\(error)")
                }
            },
            failure: { error in
                print(error)
                XCTFail("Error response from server. 💩")
            },
            completed: {
                expectation.fulfill()
            })
        
        waitForExpectations(timeout: 30, handler: nil)
    }
    
    func testCommsChangeInputInhibitState() {
        var expectation = self.expectation(description: "Change Input binary state On")
        
        var request = Comms.RestCalls.setInputInhibitState("1", "ON").request
        Comms.shared.executeRequest(request: request, requiredValidSession: false,
            success: {inputInhibitState in
                //print(inputState.base64EncodedString().fromBase64())
                do {
                    let xmlDoc = try AEXMLDocument(xml: inputInhibitState)
                    print(xmlDoc.xml)
                }
                catch {
                    print("\(error)")
                }
            },
            failure: { error in
                print(error)
                XCTFail("Error response from server. 💩")
            },
            completed: {
                expectation.fulfill()
            })
        
        waitForExpectations(timeout: 30, handler: nil)
        
        expectation = self.expectation(description: "Override Zone Off")
        
        request = Comms.RestCalls.setInputInhibitState("1", "OFF").request
        Comms.shared.executeRequest(request: request, requiredValidSession: false,
            success: {inputInhibitState in
                //print(zoneState.base64EncodedString().fromBase64())
                do {
                    let xmlDoc = try AEXMLDocument(xml: inputInhibitState)
                    print(xmlDoc.xml)
                }
                catch {
                    print("\(error)")
                }
            },
            failure: { error in
                print(error)
                XCTFail("Error response from server. 💩")
            },
            completed: {
                expectation.fulfill()
            })
        
        waitForExpectations(timeout: 30, handler: nil)
    }
    
    // MARK: - Schedule Tests
    
    func testApiGetSchedule() {
        let expectation = self.expectation(description: "Schedule data")
        
        NF3500SDK.shared.retrieveSchedule(index: 1,
            success: { schedule in
                print(schedule.description)
            },
            failure: { error in
                print(error)
                XCTFail("Error response from server. 💩")
            },
            completed: {
                expectation.fulfill()
            })
        
        waitForExpectations(timeout: 30, handler: nil)
    }
    
    func testApiGetSchedules(){
        let expectation = self.expectation(description: "Zone data")
        
        NF3500SDK.shared.retrieveSchedules(
            success: { schedule in
                print(schedule[0].description)
        },
            failure: { error in
                print(error)
                XCTFail("Error response from server. 💩")
        },
            completed: {
                expectation.fulfill()
        })
        
        waitForExpectations(timeout: 30, handler: nil)
    }
    
    func testCommsGetSchedule() {
        let expectation = self.expectation(description: "Schedule data")
        
        let request = Comms.RestCalls.getScheduleData("1").request
        Comms.shared.executeRequest(request: request, notificationName: nil, requiredValidSession: false,
            success: { scheduleData in
                do {
                    let xmlDoc = try AEXMLDocument(xml: scheduleData)
                    print(xmlDoc.xml)
                }
                catch {
                    print("\(error)")
                    XCTFail("Error converting to xml. 💩")
                }
            },
            failure: { error in
                print(error)
                XCTFail("Error response from server. 💩")
            },
            completed: {
                expectation.fulfill()
            })
        
        waitForExpectations(timeout: 30, handler: nil)
    }
    
    func testCommsGetSchedules() {
        let expectation = self.expectation(description: "Schedules data")
        
        let request = Comms.RestCalls.getScheduleData("0").request
        Comms.shared.executeRequest(request: request, notificationName: nil, requiredValidSession: false,
            success: { scheduleData in
                do {
                    let xmlDoc = try AEXMLDocument(xml: scheduleData)
                    print(xmlDoc.xml)
                }
                catch {
                    print("\(error)")
                    XCTFail("Error converting to xml. 💩")
                }
            },
            failure: { error in
                print(error)
                XCTFail("Error response from server. 💩")
            },
            completed: {
                expectation.fulfill()
            })
        
        waitForExpectations(timeout: 30, handler: nil)
    }
    
    // MARK: - Period Tests
    
    func testCommsGetPeriod() {
        let expectation = self.expectation(description: "Period data")
        
        let request = Comms.RestCalls.getPeriodData("1").request
        Comms.shared.executeRequest(request: request, notificationName: nil, requiredValidSession: false,
            success: { periodData in
                do {
                    let xmlDoc = try AEXMLDocument(xml: periodData)
                                            
                    print(xmlDoc.xml)
                }
                catch {
                    print("\(error)")
                    XCTFail("Error converting to xml. 💩")
                }
            },
            failure: { error in
                print(error)
                XCTFail("Error response from server. 💩")
            },
            completed: {
                expectation.fulfill()
            })
        
        waitForExpectations(timeout: 30, handler: nil)
    }
    
    func testCommsGetPeriods() {
        let expectation = self.expectation(description: "Periods data")
        
        let request = Comms.RestCalls.getPeriodData("0").request
        Comms.shared.executeRequest(request: request, notificationName: nil, requiredValidSession: false,
            success: { periodData in
                do {
                    let xmlDoc = try AEXMLDocument(xml: periodData)
                    print(xmlDoc.xml)
                }
                catch {
                    print("\(error)")
                    XCTFail("Error converting to xml. 💩")
                }
            },
            failure: { error in
                print(error)
                XCTFail("Error response from server. 💩")
            },
            completed: {
                expectation.fulfill()
            })
        
        waitForExpectations(timeout: 30, handler: nil)
    }
    
    // MARK: - Special Day Tests
    
    func testCommsGetSpecialDay() {
        let expectation = self.expectation(description: "Spceial day data")
        
        let request = Comms.RestCalls.getSpecialDayData("1").request
        Comms.shared.executeRequest(request: request, notificationName: nil, requiredValidSession: false,
            success: { sDayData in
                do {
                    let xmlDoc = try AEXMLDocument(xml: sDayData)
                    print(xmlDoc.xml)
                }
                catch {
                    print("\(error)")
                    XCTFail("Error converting to xml. 💩")
                }
            },
            failure: { error in
                print(error)
                XCTFail("Error response from server. 💩")
            },
            completed: {
                expectation.fulfill()
            })
        
        waitForExpectations(timeout: 30, handler: nil)
    }
    
    func testCommsGetSpecialDays() {
        let expectation = self.expectation(description: "Spceial day data")
        
        let request = Comms.RestCalls.getSpecialDayData("0").request
        Comms.shared.executeRequest(request: request, notificationName: nil, requiredValidSession: false,
            success: { sDaysData in
                do {
                    let xmlDoc = try AEXMLDocument(xml: sDaysData)
                    print(xmlDoc.xml)
                }
                catch {
                    print("\(error)")
                    XCTFail("Error converting to xml. 💩")
                }
            },
            failure: { error in
                print(error)
                XCTFail("Error response from server. 💩")
            },
            completed: {
                expectation.fulfill()
            })
        
        waitForExpectations(timeout: 30, handler: nil)
    }
    
    // MARK: - Cbus tests
    
    func testApiGetCbus() {
        let expectation = self.expectation(description: "Cbus data")
        
        NF3500SDK.shared.retrieveCbus(index: 1,
            success: { cbus in
                print(cbus.description)
            },
            failure: { error in
                print(error)
                XCTFail("Error response from server. 💩")
            },
            completed: {
                expectation.fulfill()
            })
        
        waitForExpectations(timeout: 30, handler: nil)
    }
    
    func testApiGetCbuses(){
        let expectation = self.expectation(description: "Cbus data")
        
        NF3500SDK.shared.retrieveCbuses(
            success: { cbuses in
                print(cbuses[255].description)
        },
            failure: { error in
                print(error)
                XCTFail("Error response from server. 💩")
        },
            completed: {
                expectation.fulfill()
        })
        
        waitForExpectations(timeout: 30, handler: nil)
    }

    
    func testCommsGetCbus() {
        let expectation = self.expectation(description: "Spceial day data")
        
        let request = Comms.RestCalls.getCbusData("1").request
        Comms.shared.executeRequest(request: request, notificationName: nil, requiredValidSession: false,
            success: { cbusData in
                do {
                    let xmlDoc = try AEXMLDocument(xml: cbusData)
                    print(xmlDoc.xml)
                }
                catch {
                    print("\(error)")
                    XCTFail("Error converting to xml. 💩")
                }
            },
            failure: { error in
                print(error)
                XCTFail("Error response from server. 💩")
            },
            completed: {
                expectation.fulfill()
            })
        
        waitForExpectations(timeout: 30, handler: nil)
    }
    
    func testCommsGetCbuses() {
        let expectation = self.expectation(description: "Spceial day data")
        
        let request = Comms.RestCalls.getCbusData("0").request
        Comms.shared.executeRequest(request: request, notificationName: nil, requiredValidSession: false,
            success: { cbusData in
                do {
                    let xmlDoc = try AEXMLDocument(xml: cbusData)
                    print(xmlDoc.xml)
                }
                catch {
                    print("\(error)")
                    XCTFail("Error converting to xml. 💩")
                }
            },
            failure: { error in
                print(error)
                XCTFail("Error response from server. 💩")
            },
            completed: {
                expectation.fulfill()
            })
        
        waitForExpectations(timeout: 30, handler: nil)
    }
    
    // MARK: - Remote Sources tests
    
    func testApiGetSubscriber() {
        let expectation = self.expectation(description: "Subscriber data")
		
        
        NF3500SDK.shared.retrieveSubscriber(index: 5,
            success: { subscriber in
                print(subscriber.description)
                print("Subscribed To is G4: \(subscriber.subscribeToSource.isG4), Source: \(subscriber.subscribeToSource.source), Index: \(subscriber.subscribeToSource.index), has bus: \(subscriber.subscribeToSource.Bus).")
                print("Published To is G4: \(subscriber.publishToSource.isG4), Source: \(subscriber.publishToSource.source), Index: \(subscriber.publishToSource.index), has bus: \(subscriber.publishToSource.Bus).")
            },
            failure: { error in
                print(error)
                XCTFail("Error response from server. 💩")
            },
            completed: {
                expectation.fulfill()
            })
        
        waitForExpectations(timeout: 30, handler: nil)
    }
    
    func testApiGetSubscribers(){
        let expectation = self.expectation(description: "Subscriber data")
        
        NF3500SDK.shared.retrieveSubscribers(
            success: { subscribers in
                print(subscribers[1].description)
        },
            failure: { error in
                print(error)
                XCTFail("Error response from server. 💩")
        },
            completed: {
                expectation.fulfill()
        })
        
        waitForExpectations(timeout: 30, handler: nil)
    }

    
    func testCommsGetSubscriber() {
        let expectation = self.expectation(description: "Subscriber data")
        
        let request = Comms.RestCalls.getSubscriberData("1").request
        Comms.shared.executeRequest(request: request, notificationName: nil, requiredValidSession: false,
            success: { subscriberData in
                do {
                    let xmlDoc = try AEXMLDocument(xml: subscriberData)
                    print(xmlDoc.xml)
                }
                catch {
                    print("\(error)")
                }
            },
            failure: { error in
                print(error)
                XCTFail("Error response from server. 💩")
            },
            completed: {
                expectation.fulfill()
            })
        
        waitForExpectations(timeout: 30, handler: nil)
    }
    
    func testCommsGetSubscribers() {
        let expectation = self.expectation(description: "Subscribers data")
        
        let request = Comms.RestCalls.getSubscriberData("0").request
        Comms.shared.executeRequest(request: request, notificationName: nil, requiredValidSession: false,
            success: { subscribersData in
                do {
                    let xmlDoc = try AEXMLDocument(xml: subscribersData)
                    print(xmlDoc.xml)
                }
                catch {
                    print("\(error)")
                }
            },
            failure: { error in
                print(error)
                XCTFail("Error response from server. 💩")
            },
            completed: {
                expectation.fulfill()
            })
        
        waitForExpectations(timeout: 30, handler: nil)
    }
    
    func testApiGetPublisher() {
        let expectation = self.expectation(description: "Publisher data")
        
        NF3500SDK.shared.retrievePublisher(index: 1,
            success: { publisher in
                print(publisher.description)
                print("Published To is G4: \(publisher.publishToSource.isG4), Source: \(publisher.publishToSource.source), Index: \(publisher.publishToSource.index), has bus: \(publisher.publishToSource.Bus).")
            },
            failure: { error in
                print(error)
                XCTFail("Error response from server. 💩")
            },
            completed: {
                expectation.fulfill()
            })
        
        waitForExpectations(timeout: 30, handler: nil)
    }
    
    func testApiGetPublishers(){
        let expectation = self.expectation(description: "Publishers data")
        
        NF3500SDK.shared.retrievePublishers(
            success: { publishers in
                print(publishers[1].description)
            },
            failure: { error in
                print(error)
                XCTFail("Error response from server. 💩")
            },
            completed: {
                expectation.fulfill()
            })
        
        waitForExpectations(timeout: 30, handler: nil)
    }


    func testCommsGetPublisher() {
        let expectation = self.expectation(description: "Publisher data")
        
        let request = Comms.RestCalls.getPublisherData("1").request
        Comms.shared.executeRequest(request: request, notificationName: nil, requiredValidSession: false,
            success: { publisherData in
                do {
                    let xmlDoc = try AEXMLDocument(xml: publisherData)
                    print(xmlDoc.xml)
                }
                catch {
                    print("\(error)")
                }
            },
            failure: { error in
                print(error)
                XCTFail("Error response from server. 💩")
            },
            completed: {
                expectation.fulfill()
            })
        
        waitForExpectations(timeout: 30, handler: nil)
    }

    // MARK: - Panel tests
    
    func testApiGetPanel() {
        let expectation = self.expectation(description: "Zone data")
        
        NF3500SDK.shared.retrievePanel(index: 0,
            success: { panel in
                print(panel.description)
            },
            failure: { error in
                print(error)
                XCTFail("Error response from server. 💩")
            },
            completed: {
                expectation.fulfill()
            })
        
        waitForExpectations(timeout: 30, handler: nil)
    }
    
    func testCommsGetPanel() {
        let expectation = self.expectation(description: "Panel data")
        
        let request = Comms.RestCalls.getPanelData("0").request
        Comms.shared.executeRequest(request: request, notificationName: nil, requiredValidSession: false,
            success: { panelData in
                do {
                    let xmlDoc = try AEXMLDocument(xml: panelData)
                    print(xmlDoc.xml)
                }
                catch {
                    print("\(error)")
                }
            },
            failure: { error in
                print(error)
                XCTFail("Error response from server. 💩")
            },
            completed: {
                expectation.fulfill()
            })
        
        waitForExpectations(timeout: 30, handler: nil)
    }
    
    // MARK: - Controller tests
    
    func testAPIGetController() {
        let expectation = self.expectation(description: "Controller data")
        
        NF3500SDK.shared.retrieveController(
            success: { controller in
                print(controller.description)
        },
            failure: { error in
                print(error)
                XCTFail("Error response from server. 💩")
        },
            completed: {
                expectation.fulfill()
        })
        
        waitForExpectations(timeout: 30, handler: nil)
    }
    
    func testCommsGetController() {
        let expectation = self.expectation(description: "Controller data")
        
        let request = Comms.RestCalls.getControllerData("1").request
        Comms.shared.executeRequest(request: request, notificationName: nil, requiredValidSession: false,
            success: { controllerData in
                do {
                    let xmlDoc = try AEXMLDocument(xml: controllerData)
                    print(xmlDoc.xml)
                }
                catch {
                    print("\(error)")
                    XCTFail("Error converting to xml. 💩")
                }
            },
            failure: { error in
                print(error)
                XCTFail("Error response from server. 💩")
            },
            completed: {
                expectation.fulfill()
            })
        
        waitForExpectations(timeout: 30, handler: nil)
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
