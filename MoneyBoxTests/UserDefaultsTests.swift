import XCTest
import Networking

@testable import MoneyBox

final class UserDefaultsTests: XCTestCase {
    
    private var user: User!
    
    private var userModel: UserDefaultsHelper!
    
    override func setUp() {
        super.setUp()
        userModel = UserDefaults.standard
        
        StubData.read(file: "LoginSucceed") { (result: Result<LoginResponse, any Error>) in
            switch result {
            case .success(let success):
                self.user = success.user
            case .failure(let failure):
                XCTFail("Error reading StubData: \(failure.localizedDescription)")
            }
        }
    }
    
    func test_UserDefaults_setUser_success() throws {
        userModel.saveUser(user)
        
        var savedUser = userModel.getUser()
        XCTAssertEqual(savedUser?.firstName, user.firstName)
        XCTAssertEqual(savedUser?.lastName, user.lastName)
    }
}
