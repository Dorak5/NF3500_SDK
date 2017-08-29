//
//  Comms.swift
//  NF3500_SDK
//
//  Created by Michael Dorak on 7/7/17.
//  Copyright © 2017 Michael Dorak. All rights reserved.
//

import Foundation
import Alamofire

class Comms {
    static let shared = Comms()
    
    private var baseURLString = ""
    private var password = ""
    
    lazy var sessionManager: SessionManager = {
        let configuration = URLSessionConfiguration.default
        configuration.urlCache = nil
        configuration.timeoutIntervalForRequest = 30
        let sessionManager = Alamofire.SessionManager(configuration: configuration)
        return sessionManager
    }()
    
    lazy var reachabilityManager: NetworkReachabilityManager = {
        let reachability = NetworkReachabilityManager(host: "www.apple.com")
        
        reachability!.listener = { status in
            debugPrint("Reachability Manager Status Changed to: \(status).")
        }
        reachability?.startListening()
        
        return reachability!
    }()
    
    enum RestCalls {
        case getZoneData(String)
        case setZoneState(String, String)
        case overrideZoneState(String, String)
        
        case getTerminalData(String)
        
        case getInputData(String)
        case setDigitalInputState(String, String)
        case setAnalogInputState(String, String)
        case setInputInhibitState(String, String)
        
        case getScheduleData(String)
        case getPeriodData(String)
        case getSpecialDayData(String)
        case getSubscriberData(String)
        case getPublisherData(String)
        case getPanelData(String)
        case getControllerData(String)
        case getCbusData(String)
        
        
        
        var method: Alamofire.HTTPMethod {
            switch self {
            case .getZoneData, .getTerminalData, .getInputData, .getScheduleData, .getPeriodData,
                 .getSpecialDayData, .getSubscriberData, .getPublisherData, .getPanelData,
                 .getControllerData, .getCbusData :
                return .get
            case .setZoneState, .overrideZoneState, .setDigitalInputState, .setAnalogInputState,
                 .setInputInhibitState:
                return .post
            }
            
        }
        
        var path: String {
            switch self {
            case .getZoneData(let id):
                return "/GetZoneResponse?id=\(id)"
            case .setZoneState(let id, let state):
                return "/PostZoneState?id=\(id)&State=\(state)"
            case .overrideZoneState(let id, let state):
                return "/PostZoneOverrideState?id=\(id)&State=\(state)"
                
            case .getTerminalData(let id):
                return "/GetTerminalResponse?id=\(id)"
                
            case .getInputData(let id):
                return "/GetInputResponse?id=\(id)"
            case .setDigitalInputState(let id, let state):
                return "/PostInputBinState?id=\(id)&State=\(state)"
            case .setAnalogInputState(let id, let state):
                return "/PostInputAnalogState?id=\(id)&State=\(state)"
            case .setInputInhibitState(let id, let state):
                return "/PostInputInhibitState?id=\(id)&State=\(state)"
                
            case .getScheduleData(let id):
                return "/GetSchedResponse?id=\(id)"
            case .getPeriodData(let id):
                return "/GetPeriodResponse?id=\(id)"
            case .getSpecialDayData(let id):
                return "/GetSpecDayResponse?id=\(id)"
            case .getSubscriberData(let id):
                return "/GetSubscriberResponse?id=\(id)"
            case .getPublisherData(let id):
                return "/GetPublisherResponse?id=\(id)"
            case .getPanelData(let id):
                return "/GetPanelResponse?id=\(id)"
            case .getControllerData(let id):
                return "/GetControllerResponse?id=\(id)"
            case .getCbusData(let id):
                return "/GetCBusResponse?id=\(id)"
            }
        }
        
        var request: DataRequest {
            let baseURLString = Comms.shared.baseURLString
            let theSessionManager = Comms.shared.sessionManager
            let password = Comms.shared.password
            
            guard let url = URL(string: baseURLString + path) else {
                debugPrint("bad URL \(baseURLString + path)")
                fatalError()
            }
            
            let request = theSessionManager.request(url, method: method, parameters: nil, encoding: URLEncoding.default, headers: nil)
            
            switch self {
            case .setZoneState, .overrideZoneState, .setDigitalInputState, .setAnalogInputState,
                 .setInputInhibitState:
                let credential = URLCredential(user: "admin", password: password, persistence: .none)
                request.authenticate(usingCredential: credential)
                
                return request
            default:
                return request
            }
        }
    }
    
    func setUrlAndPasswrod(url: String, password: String) {
        baseURLString = url
        self.password = password
    }
    
    func executeRequest(request: DataRequest, notificationName: NSNotification.Name? = nil,
                        requiredValidSession: Bool = true, success: ((Data)->Void)? = nil,
                        failure: ((Error)->Void)? = nil, completed: (()->Void)? = nil){
        
        if requiredValidSession {
            if (baseURLString == ""){
                let err = NF3500SdkError.badBaseURL
                if let callback = failure {
                    callback(err)
                }
                if let callback = completed {
                    callback()
                }
                return
            }
        }
        
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        
        request.responseData(completionHandler: { response in
            debugPrint("All Response Info: \(response)")
            
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
            
            switch response.result {
            case .success(let value):
                debugPrint("Request Passed!!!  \(value)")
                
                if let callback = success {
                    DispatchQueue.main.async {
                        callback(value)
                    }
                }
            case .failure(let err):
                debugPrint("Request Failed!!!  \(err)")
                
                if let callback = failure {
                    DispatchQueue.main.async {
                        callback(err)
                    }
                }
            }
            
            if let callback = completed {
                DispatchQueue.main.async {
                    callback()
                }
            }
        })
    }
}

extension String {
    
    func fromBase64() -> String? {
        guard let data = Data(base64Encoded: self) else {
            return nil
        }
        
        return String(data: data, encoding: .utf8)
    }
    
    func toBase64() -> String {
        return Data(self.utf8).base64EncodedString()
    }
}
