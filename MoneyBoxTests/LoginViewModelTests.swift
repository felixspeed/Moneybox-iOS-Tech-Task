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
        
        loginViewModel = LoginViewModel()
        loginViewModel.viewDelegate = viewDelegate
    }
    
    func test_LoginViewModel_auth_success() throws {
        
    }
}

class LoginViewControllerDelegateMock: LoginViewControllerDelegate {
    func showError(_ error: String) {}
}
