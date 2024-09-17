import XCTest
import Networking

@testable import MoneyBox

final class AccountsViewModelTests: XCTestCase {
    private var viewDelegate: AccountsViewControllerDelegateMock!
    
    private var dataProvider: DataProviderLogicMock!
    
    private var accountsViewModel: AccountsViewModel!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        viewDelegate = AccountsViewControllerDelegateMock()
        dataProvider = DataProviderLogicMock()
        
        accountsViewModel = AccountsViewModel(dataProvider: dataProvider)
        accountsViewModel.viewDelegate = viewDelegate
    }
    
    func test_AccountsViewModel_getAccounts_success() throws {
        StubData.read(file: "Accounts") { (result: Result<AccountResponse, Error>) in
            switch result {
            case .success(let success):
                self.dataProvider.fetchProductsResponse = .success(success)
            case .failure(let failure):
                XCTFail("Error reading StubData: \(failure.localizedDescription)")
            }
        }
        
        accountsViewModel.getAccounts()
        
        XCTAssertNotNil(accountsViewModel.account)
    }
    
    func test_AccountsViewModel_getAccounts_failure_apiCallFailure() throws {
        dataProvider.fetchProductsResponse = .failure(MockError.apiCallFailure)
        
        accountsViewModel.getAccounts()
        
        XCTAssertNil(accountsViewModel.account)
        XCTAssertEqual(viewDelegate.errorMessage, MockError.apiCallFailure.localizedDescription)
    }
    
    func test_AccountsViewModel_greetingTitle_withUser() throws {
        let userModel = UserDefaults()
        StubData.read(file: "LoginSucceed") { (result: Result<LoginResponse, Error>) in
            switch result {
            case .success(let success):
                userModel.saveUser(success.user)
            case .failure(let failure):
                XCTFail("Error reading StubData: \(failure.localizedDescription)")
            }
        }
        
        XCTAssertEqual(accountsViewModel.greetingTitle, "Hello \(userModel.getUser()?.firstName ?? "")!")
    }
    
    func test_AccountsViewModel_greetingTitle_withoutUser() throws {
        UserDefaultsMock().setUserAsNil()
        
        XCTAssertEqual(accountsViewModel.greetingTitle, "Hello!")
    }
    
}

class AccountsViewControllerDelegateMock: AccountsViewControllerDelegate {
    var planValue: String?
    var errorMessage: String?
    
    func loading(_ state: Bool) {}
    
    func updatePlanValueLabel(_ value: String) {
        planValue = value
    }
    
    func displayAccounts(_ accounts: [Networking.ProductResponse]?) {}
    
    func accountTapped(withTag: Int) {}
    
    func showError(_ error: String) {
        errorMessage = error
    }
    
    
}
