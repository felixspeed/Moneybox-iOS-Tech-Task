import XCTest
import Networking

@testable import MoneyBox

final class TokenSessionManagerTests: XCTestCase {
    
    override class func setUp() {
        super.setUp()
        TokenSessionManager.shared.removeUserToken()
    }
    
    func test_TokenSessionManager_setUserToken_success() throws {
        TokenSessionManager.shared.setUserToken("testtoken")
        
        XCTAssertEqual(Authentication.token, "testtoken")
    }
}
