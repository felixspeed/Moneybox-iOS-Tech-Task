import Foundation
import Combine
import Networking

protocol TokenSessionManagerDelegate: AnyObject {
    func logout()
}

protocol SessionManager {
    func setUserToken(_ token: String)
    func removeUserToken()
}

class TokenSessionManager: SessionManager {
    var delegate: TokenSessionManagerDelegate?
    
    private var timer: Timer?
    
    // Singleton to enforce one token per session
    static var shared: TokenSessionManager = TokenSessionManager()
    
    func setUserToken(_ token: String) {
        Authentication.token = token
        startTimer()
    }
    
    func removeUserToken() {
        Authentication.token = nil
    }
    
    private func startTimer() {
        let timeout: TimeInterval = 300
        timer = Timer.scheduledTimer(timeInterval: timeout,
                                     target: self,
                                     selector: #selector(logoutUser),
                                     userInfo: nil,
                                     repeats: false
        )
    }
    
    @objc private func logoutUser() {
        self.removeUserToken()
        self.delegate?.logout()
    }
}
