import UIKit

class AppCoordinator: Coordinator {
    
    override func start() {
        navToLogin()
    }
}

extension AppCoordinator {
    func navToLogin() {
        let loginCoordinator = LoginCoordinator(root: root)
        addChild(loginCoordinator)
        loginCoordinator.start()
    }
}
