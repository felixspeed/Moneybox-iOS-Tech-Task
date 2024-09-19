import UIKit

class AppCoordinator: Coordinator {
    
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    override func start() {
        navToLogin()
    }
    
}

extension AppCoordinator {
    func navTo(_ coordinator: Coordinator) {
        addChild(coordinator)
        coordinator.start()
    }
    
    func navToLogin() {
        let loginCoordinator = LoginCoordinator(navigationController: navigationController, delegate: self)
        navTo(loginCoordinator)
        
    }
    
    func navToAccounts() {
        let accountsCoordinator = AccountsCoordinator(navigationController: navigationController, delegate: self)
        navTo(accountsCoordinator)
    }
}


extension AppCoordinator: LoginCoordinatorDelegate {
    func delegateFinish(_ coordinator: LoginCoordinator) {
        navToAccounts()
        removeChild(coordinator)
    }
    
    func logout() {
        for child in self.children {
            removeChild(child)
        }
        navToLogin()
    }
}

extension AppCoordinator: AccountsCoordinatorDelegate {
    func delegateFinish(_ coordinator: AccountsCoordinator) {
        navToLogin()
        removeChild(coordinator)
    }
}

