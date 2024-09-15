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
    
    func navToHome() {
        let homeCoordinator = HomeCoordinator(navigationController: navigationController, delegate: self)
        navTo(homeCoordinator)
    }
}


extension AppCoordinator: LoginCoordinatorDelegate {
    func delegateFinish(_ coordinator: LoginCoordinator) {
        navToHome()
        removeChild(coordinator)
    }
}

extension AppCoordinator: HomeCoordinatorDelegate {
    func delegateFinish(_ coordinator: HomeCoordinator) {
        print("Home Finished")
    }
}

