import Networking


protocol SessionManager {
    func setUserToken(_ token: String)
    func removeUserToken()
}

class TokenSessionManager: SessionManager {
    
    // Singleton to enforce one token per session
    static var shared: TokenSessionManager = TokenSessionManager()
    
    func setUserToken(_ token: String) {
        Authentication.token = token
    }
    
    func removeUserToken() {
        Authentication.token = nil
    }
    
    //TODO: Set 5 minute timeout
}
