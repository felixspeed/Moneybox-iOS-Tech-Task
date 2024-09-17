import XCTest
import Networking

@testable import MoneyBox

final class LoginViewModelTests: XCTest {
    
    private var viewDelegate: LoginViewControllerDelegateMock!
    
    private var dataProvider: DataProviderLogicMock!
    private var tokenSessionManager: TokenSessionManagerMock!
    private var userModel: UserDefaultsMock!
    
    private var loginViewModel: LoginViewModel!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        viewDelegate = LoginViewControllerDelegateMock()
        dataProvider = DataProviderLogicMock()
        tokenSessionManager = TokenSessionManagerMock()
        userModel = UserDefaultsMock()
        
        loginViewModel = LoginViewModel(dataProvider: dataProvider,
                                        tokenSessionManager: tokenSessionManager,
                                        userModel: userModel)
        loginViewModel.viewDelegate = viewDelegate
    }
    
    func test_LoginViewModel_auth_success_tokenSaved() throws {
        var token: String!
        StubData.read(file: "LoginSucceed") { (result: Result<LoginResponse, Error>) in
            switch result {
            case .success(let success):
                self.dataProvider.loginResponse = .success(success)
                token = success.session.bearerToken
            case .failure(let failure):
                XCTFail("Error reading StubData: \(failure.localizedDescription)")
            }
        }
        
        self.loginViewModel.auth(email: "test@email.com", pass: "testpassword")
        
        XCTAssertEqual(tokenSessionManager.getToken(), token)
    }
}

class LoginViewControllerDelegateMock: LoginViewControllerDelegate {
    func showError(_ error: String) {}
}
