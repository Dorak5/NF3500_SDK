//
//  Panel.swift
//  NF3500_SDK
//
//  Created by Michael Dorak on 7/19/17.
//  Copyright © 2017 Michael Dorak. All rights reserved.
//

import AEXML

open class Panel: Source {
    private var panelElement: AEXMLElement
    //private(set) var length: Int
    //private(set) var width: Int
    //private(set) var startingPostion: Int
    private(set) var firstBreakerNumber: Int
    private(set) var sequence: Int
    private(set) var buses: [Bus]?
    private(set) var leftSide: [Component]?
    private(set) var rightSide: [Component]?
    
    override open var description: String {
        return panelElement.xml
    }
    
    required public init(panelData: AEXMLElement) {
        panelElement = panelData
        
        //length = panelElement["length"].int!
        //width = panelElement["width"].int!
        //startingPostion = panelElement["posnumberstart"].int!
        firstBreakerNumber = panelElement["firstbrkrnumber"].int!
        sequence = panelElement["brkrseqnumber"].int!
        
        if panelElement["busses"]["bus"].all!.count != 0 {
            buses = [Bus]()
            
            for bus in panelElement["busses"]["bus"].all! {
                buses!.append(Bus(busData: bus))
            }
        }
        
        if panelElement["left"]["component"].all!.count != 0 {
            leftSide = [Component]()
            
            var powerSupplyData = [AEXMLElement]()
            
            for component in panelElement["left"]["component"].all! {
                switch ComponentType(rawValue: component["type"].string)! {
                case ComponentType.powerSupply:
                    powerSupplyData.append(component)
                    
                    if powerSupplyData.count == 3 {
                        leftSide!.append(PowerSupply(powerSupplyData: powerSupplyData))
                    }
                    break
                case ComponentType.emptySlot:
                    leftSide!.append(EmptySlot(emptySlotData: component))
                    break
                default:
                    if component["position"].all!.count == 1 {
                        if component["position"]["breaker"]["eltype"].string != "YES" {
                            leftSide!.append(OnePoleBreaker(onePoleBreakerData: component))
                        }
                        else {
                            let emptySlot = leftSide!.last as! EmptySlot
                            var elBreakerData = [AEXMLElement]()
                            elBreakerData.append(emptySlot.emptySlotData)
                            elBreakerData.append(component)
                        
                            leftSide!.remove(at: leftSide!.count - 1)
                                                    
                            leftSide!.append(ElBreakerLeft(elBreakerData: elBreakerData))
                        }
                    }
                    else if component["position"].all!.count == 2 {
                        leftSide!.append(TwoPoleBreakerLeft(twoPoleBreakerData: component))
                    }
                    else if component["position"].all!.count == 3 {
                        leftSide!.append(ThreePoleBreaker(threePoleBreakerData: component))
                    }
                    else {
                        leftSide!.append(EmptySlot(emptySlotData: component))
                    }
                    break
                }
            }
        }
        
        if panelElement["right"]["component"].all!.count != 0 {
            rightSide = [Component]()
            
            var controllerData = [AEXMLElement]()
            var elBreakerData = [AEXMLElement]()
            var isElBreaker = false
            
            for component in panelElement["right"]["component"].all! {
                switch ComponentType(rawValue: component["type"].string)! {
                case ComponentType.controller:
                    controllerData.append(component)
                    
                    if controllerData.count == 3 {
                        rightSide!.append(ControllerComponent(controllerData: controllerData))
                    }
                    break
                case ComponentType.emptySlot:
                    if isElBreaker {
                        isElBreaker = false
                        elBreakerData.append(component)
                        
                        rightSide!.append(ElBreakerRight(elBreakerData: elBreakerData))
                        
                        elBreakerData = [AEXMLElement]()
                    }
                    else {
                        rightSide!.append(EmptySlot(emptySlotData: component))
                    }

                    break
                default:
                    if component["position"].all!.count == 1 {
                        if component["position"]["breaker"]["eltype"].string != "YES" {
                            rightSide!.append(OnePoleBreaker(onePoleBreakerData: component))
                        }
                        else {
                            isElBreaker = true
                            elBreakerData.append(component)
                        }
                    }
                    else if component["position"].all!.count == 2 {
                        rightSide!.append(TwoPoleBreakerRight(twoPoleBreakerData: component))
                    }
                    else if component["position"].all!.count == 3 {
                        rightSide!.append(ThreePoleBreaker(threePoleBreakerData: component))
                    }
                    else {
                        rightSide!.append(EmptySlot(emptySlotData: component))
                    }
                    break
                }
            }
        }
        
//        if panelElement["left"]["component"].all!.count != 0 {
//            leftSide = [Component]()
//            
//            var powerSupplyData = [AEXMLElement]()
//            
//            for component in panelElement["left"]["component"].all! {
//                switch ComponentType(rawValue: component["type"].string)! {
//                case ComponentType.powerSupply:
//                    powerSupplyData.append(component)
//                    
//                    if powerSupplyData.count == 3 {
//                        leftSide!.append(PowerSupply(powerSupplyData: powerSupplyData))
//                    }
//                    break
//                case ComponentType.onePoleBreaker:
//                    if component["position"]["breaker"]["eltype"].string != "YES" {
//                        leftSide!.append(OnePoleBreaker(onePoleBreakerData: component))
//                    }
//                    else {
//                        let emptySlot: EmptySlot = leftSide!.last as! EmptySlot
//                        var elBreakerData = [AEXMLElement]()
//                        elBreakerData.append(emptySlot.emptySlotData)
//                        elBreakerData.append(component)
//                        
//                        leftSide!.remove(at: leftSide!.count - 1)
//                        
//                        leftSide!.append(ElBreakerLeft(elBreakerData: elBreakerData))
//                    }
//                    break
//                case ComponentType.twoPoleBreaker:
//                    leftSide!.append(TwoPoleBreakerLeft(twoPoleBreakerData: component))
//                    break
//                case ComponentType.threePoleBreaker:
//                    leftSide!.append(ThreePoleBreaker(threePoleBreakerData: component))
//                    break
//                default:
//                    leftSide!.append(EmptySlot(emptySlotData: component))
//                    break
//                }
//            }
//        }
        
//        if panelElement["right"]["component"].all!.count != 0 {
//            rightSide = [Component]()
//            
//            var controllerData = [AEXMLElement]()
//            var elBreakerData = [AEXMLElement]()
//            var isElBreaker = false
//            
//            for component in panelElement["right"]["component"].all! {
//                switch ComponentType(rawValue: component["type"].string)! {
//                case ComponentType.controller:
//                    controllerData.append(component)
//                    
//                    if controllerData.count == 3 {
//                        rightSide!.append(ControllerComponent(controllerData: controllerData))
//                    }
//                    break
//                case ComponentType.onePoleBreaker:
//                    if component["position"]["breaker"]["eltype"].string != "YES" {
//                        rightSide!.append(OnePoleBreaker(onePoleBreakerData: component))
//                    }
//                    else {
//                        isElBreaker = true
//                        elBreakerData.append(component)
//                    }
//                    break
//                case ComponentType.twoPoleBreaker:
//                    rightSide!.append(TwoPoleBreakerRight(twoPoleBreakerData: component))
//                    break
//                case ComponentType.threePoleBreaker:
//                    rightSide!.append(ThreePoleBreaker(threePoleBreakerData: component))
//                    break
//                default:
//                    if isElBreaker {
//                        isElBreaker = false
//                        elBreakerData.append(component)
//                        
//                        rightSide!.append(ElBreakerRight(elBreakerData: elBreakerData))
//                        
//                        elBreakerData = [AEXMLElement]()
//                    }
//                    else {
//                        rightSide!.append(EmptySlot(emptySlotData: component))
//                    }
//                }
//            }
//        }
    }
}
