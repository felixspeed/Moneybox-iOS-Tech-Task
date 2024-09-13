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
