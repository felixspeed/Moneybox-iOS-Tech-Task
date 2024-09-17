import Networking

@testable import MoneyBox

class TokenSessionManagerMock: TokenSessionManager {
    func getToken() -> String? {
        return Authentication.token
    }
}
