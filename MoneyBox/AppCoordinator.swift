import UIKit

class AppCoordinator: Coordinator {
    
    override func start() {
        navToLogin()
    }
    
    
}

extension AppCoordinator {
    func navToLogin() {
        let loginCoordinator = LoginCoordinator(navigationController: navigationController)
        addChild(loginCoordinator)
        loginCoordinator.start()
    }
}


extension AppCoordinator: LoginCoordinatorDelegate {
    func delegateFinish(_ coordinator: Coordinator) {
        // TODO: Login finished so go to home page  { navToHome() }
        removeChild(coordinator)
    }
}
