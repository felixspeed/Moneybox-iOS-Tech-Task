import UIKit
import Networking

class AccountsViewModel {
    
    var coordinator: AccountsCoordinator?
    var viewDelegate: AccountsViewControllerDelegate?

    private let dataProvider: DataProviderLogic
    
    var account: AccountResponse?
    
    convenience init() {
        self.init(dataProvider: DataProvider())
    }
    
    init(dataProvider: DataProviderLogic) {
        self.dataProvider = dataProvider
    }
    
    var greetingTitle: String {
        if let name = UserDefaults.standard.getUser()?.firstName {
            return "Hello \(name)!"
        } else {
            return "Hello!"
        }
    }
    
    var totalPlanValue: String {
        return String(account?.totalPlanValue ?? 0.0).asCurrency
    }   
    
    func getAccounts() {
        viewDelegate?.loading(true)
        dataProvider.fetchProducts { result in
            switch result {
            case .success(let success):
                self.setAccount(success)
            case .failure(let failure):
                self.viewDelegate?.showError(failure.localizedDescription)
            }
            self.viewDelegate?.loading(false)
        }
    }
    
    func setAccount(_ result: AccountResponse) {
        account = result
        viewDelegate?.updatePlanValueLabel(String(result.totalPlanValue ?? 0.0).asCurrency)
        if let products = result.productResponses {
            viewDelegate?.displayAccounts(products)
        }
    }
    
    func accountTapped(withTag: Int) {
        if let product = account?.productResponses?.first(where: { $0.id == withTag }) {
            coordinator?.goToProduct(product: product)
        }
    }
    
    func logout() {
        coordinator?.finish()
    }
}
