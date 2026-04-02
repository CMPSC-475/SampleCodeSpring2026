
@Observable
class SessionManager : NSObject {
    
    var number: Int = 50
    var color: Color = .blue
    var iconName: String = "star.fill"
    var message: String = "Hello Watch!"


    private func update(from context: [String: Any]) {

    }
    
    
    func color(name: String) -> Color {
        switch name {
            case "red":
            return .red
        case "green":
            return .green
        case "blue":
            return .blue
        case "purple":
            return .purple
        case "orange":
            return .orange
        case "yellow":
            return .yellow
        default:
            return .white
        }
    }
    
}


extension SessionManager: WCSessionDelegate {
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: (any Error)?) {
        // Load any previously sent application context
        if !session.receivedApplicationContext.isEmpty {
            update(from: session.receivedApplicationContext)
        }
    }
    
    func session(_ session: WCSession, didReceiveApplicationContext applicationContext: [String : Any]) {
        update(from: applicationContext)
    }
    
    func session(_ session: WCSession, didReceiveMessage message: [String : Any]) {
        update(from: message)
    }
    
    
}
