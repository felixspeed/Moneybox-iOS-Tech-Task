import UIKit

protocol AccountsCoordinatorDelegate: AnyObject {
    func delegateFinish(_ coordinator: AccountsCoordinator)
}

class AccountsCoordinator: Coordinator {
    
    private let navigationController: UINavigationController
    private var delegate: AccountsCoordinatorDelegate?
    
    init(navigationController: UINavigationController, delegate: AccountsCoordinatorDelegate) {
        self.navigationController = navigationController
        self.delegate = delegate
    }
    
    override func start() {
        displayAccounts()
    }
    
    override func finish() {
        delegate?.delegateFinish(self)
    }
    
}

extension AccountsCoordinator {
    private func displayAccounts() {
        let accountsViewController = AccountsViewController()
        let accountsViewModel = AccountsViewModel()
        accountsViewModel.coordinator = self
        accountsViewModel.viewDelegate = accountsViewController
        accountsViewController.accountsViewModel = accountsViewModel
        navigationController.viewControllers = [accountsViewController]
    }
}
