//
//  SessionManager.swift
//  WristDash
//
//  Created by Nader Alfares on 4/1/26.
//
import SwiftUI
import WatchConnectivity

@Observable
class SessionManager : NSObject {
    override init() {
        super.init()
        if WCSession.isSupported() {
            let session = WCSession.default
            session.delegate = self
            session.activate()
        }
    }
    
    
    func sendUpdate(number: Int, color: Color, iconName: String, message : String) {
        guard WCSession.default.activationState == .activated else { return }
        let context: [String: Any] = [
            "number": number,
            "colorName": color.description,
            "iconName": iconName,
            "message": message
        ]
        
        
        // updateApplicationContext persists the latest state for when the watch wakes
        do {
            try WCSession.default.updateApplicationContext(context)
        } catch {
            print("error updating context: \(error)")
        }
        
        
        // sendMessage delivers immediately if the watch is reachable
        if WCSession.default.isReachable {
            WCSession.default.sendMessage(context, replyHandler: nil)
        }
        
    }
}


extension SessionManager : WCSessionDelegate {
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: (any Error)?) {
    }
    
    func sessionDidBecomeInactive(_ session: WCSession) {
    }
    
    func sessionDidDeactivate(_ session: WCSession) {
    }
    
    
}

