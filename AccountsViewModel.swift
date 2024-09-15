import UIKit
import Networking

typealias Accounts = AccountResponse

class AccountsViewModel {
    
    var coordinator: AccountsCoordinator?

    private let dataProvider: DataProviderLogic
    
    @Published var accounts: Accounts?
    
    init() {
        self.dataProvider = DataProvider()
    }
    
    var greetingTitle: String {
        if let name = UserDefaults.standard.getUser()?.firstName {
            return "Hello \(name)!"
        } else {
            return "Hello!"
        }
    }
    
    func getAccounts() {
        dataProvider.fetchProducts { result in
            switch result {
            case .success(let success):
                self.accounts = success
            case .failure(let failure):
                // TODO: Handle account get error
                print("Failed to retrieve accounts")
            }
        }
    }
    
    func logout() {
        coordinator?.finish()
    }
    
}
