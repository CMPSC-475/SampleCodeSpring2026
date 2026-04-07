//
//  SessionManager.swift
//  WristDash
//
//  Created by Nader Alfares on 4/1/26.
//
import SwiftUI
import WatchConnectivity

@Observable
class SessionManager: NSObject {
    
    override init() {
        super.init()
        if WCSession.isSupported() {
            let session = WCSession.default
            session.delegate = self
            session.activate()
        }
    }
    
    func sendUpdate(number: Int, color:  Color, iconName: String, message: String) {
        guard WCSession.default.activationState == .activated else { return }
        
        let context : [String: Any] = [
            "number" : number,
            "colorName" : color.description,
            "iconName" : iconName,
            "message" : message
        ]
        
        do {
            try WCSession.default.updateApplicationContext(context)
        } catch {
            print("error update context")
        }
        
        if WCSession.default.isReachable {
            WCSession.default.sendMessage(context, replyHandler: nil)
        }
        
        
        
    }
    
}


extension SessionManager : WCSessionDelegate {
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        
    }
    
    func sessionDidBecomeInactive(_ session: WCSession) {
        
    }
    
    func sessionDidDeactivate(_ session: WCSession) {
        
    }
}

