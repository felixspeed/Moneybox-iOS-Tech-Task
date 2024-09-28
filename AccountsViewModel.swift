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
        // You could make this testable without having to use actual user defaults by injecting
        // your `UserDefaultsHelper` protocol into your classes. That way you don't need to
        // manipulate the user defaults in your unit tests, you can just use your test class
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
        var totalMoneybox = 0.0
        if let products = result.productResponses {
            for product in products {
                totalMoneybox += product.moneybox ?? 0
            }
        }
        viewDelegate?.updateValues(planValue: String(result.totalPlanValue ?? 0.0).asCurrency,
                                   moneyboxValue: String(totalMoneybox.description.asCurrency))
        if let products = result.productResponses {
            viewDelegate?.displayAccounts(products)
        }
    }
    
    func elementTapped(withTag: Int) {
        if let product = account?.productResponses?.first(where: { $0.id == withTag }) {
            coordinator?.goToProduct(product: product)
        }
    }
    
    func logout() {
        coordinator?.finish()
    }
}
