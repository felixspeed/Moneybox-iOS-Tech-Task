import UIKit
import Networking

typealias Account = AccountResponse

class AccountsViewModel {
    
    var coordinator: AccountsCoordinator?
    var viewDelegate: AccountsViewControllerDelegate?

    private let dataProvider: DataProviderLogic
    
    @Published var account: Account?
    
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
    
    var totalPlanValue: String {
        return String(format: "£%.2f", account?.totalPlanValue ?? 0.0)
    }   
    
    func getAccounts() {
        viewDelegate?.loading(true)
        dataProvider.fetchProducts { result in
            switch result {
            case .success(let success):
                self.setAccount(success)
            case .failure(let failure):
                // TODO: Handle account get error
                print("Failed to retrieve accounts")
            }
            self.viewDelegate?.loading(false)
        }
    }
    
    func setAccount(_ result: Account) {
        account = result
        viewDelegate?.updatePlanValueLabel(String(format: "£%.2f", result.totalPlanValue ?? 0.0))
    }
    
    func logout() {
        coordinator?.finish()
    }
}
