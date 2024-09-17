import XCTest
import Networking

@testable import MoneyBox

final class LoginViewModelTests: XCTestCase {
    
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
    
    func test_LoginViewModel_auth_success_userSaved() throws {
        var user: User!
        StubData.read(file: "LoginSucceed") { (result: Result<LoginResponse, Error>) in
            switch result {
            case .success(let success):
                self.dataProvider.loginResponse = .success(success)
                user = success.user
            case .failure(let failure):
                XCTFail("Error reading StubData: \(failure.localizedDescription)")
            }
        }
        
        self.loginViewModel.auth(email: "test@email.com", pass: "testpassword")
        
        XCTAssertEqual(userModel.getUser()?.firstName, user.firstName)
        XCTAssertEqual(userModel.getUser()?.lastName, user.lastName)
    }
}

class LoginViewControllerDelegateMock: LoginViewControllerDelegate {
    var errorMessage: String?
    func showError(_ error: String) {
        errorMessage = error
    }
}
