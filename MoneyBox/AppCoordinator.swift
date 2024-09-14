import UIKit

class AppCoordinator: Coordinator {
    
    override func start() {
        navToLogin()
    }
    
}

extension AppCoordinator {
    func navigateTo(_ coordinator: Coordinator) {
        coordinator.parent = self
        addChild(coordinator)
        coordinator.start()
    }
    
    func navToLogin() {
        let loginCoordinator = LoginCoordinator(navigationController: navigationController)
        navigateTo(loginCoordinator)
    }
    
    func navToHome() {
        let homeCoordinator = HomeCoordinator(navigationController: navigationController)
        navigateTo(homeCoordinator)
    }
}


extension AppCoordinator: LoginCoordinatorDelegate {
    func delegateFinish(_ coordinator: LoginCoordinator) {
        navToHome()
        removeChild(coordinator)
    }
}


