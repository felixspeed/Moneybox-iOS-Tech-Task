import UIKit
import Networking

protocol DetailCoordinatorDelegate: AnyObject {
    func delegateFinish(_ coordinator: DetailCoordinator)
}

class DetailCoordinator: Coordinator {
    
    private let navigationController: UINavigationController
    private let detailCoordinatorDelegate: DetailCoordinatorDelegate
    
    var account: ProductResponse
    
    init(navigationController: UINavigationController, detailCoordinatorDelegate: DetailCoordinatorDelegate, account: ProductResponse) {
        self.navigationController = navigationController
        self.detailCoordinatorDelegate = detailCoordinatorDelegate
        self.account = account
    }
    
    
    override func start() {
        displayDetail()
    }
    
    override func finish() {
        detailCoordinatorDelegate.delegateFinish(self)
    }
}

extension DetailCoordinator {
    private func displayDetail() {
        let detailViewController = DetailViewController()
        let detailViewModel = DetailViewModel(account: account)
        detailViewModel.coordinator = self
        detailViewController.detailViewModel = detailViewModel
        navigationController.pushViewController(detailViewController, animated: true)
    }
}
