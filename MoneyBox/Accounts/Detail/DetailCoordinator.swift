import UIKit
import Networking

protocol DetailCoordinatorDelegate: AnyObject {
    func delegateFinish(_ coordinator: DetailCoordinator)
}

// Generally it's good to have smaller self-contained classes, but it might be a little overkill
// to have one coordinator per screen in this case - I'd collapse this into your accounts coordinator
class DetailCoordinator: Coordinator {
    
    private let navigationController: UINavigationController
    private let detailCoordinatorDelegate: DetailCoordinatorDelegate
    
    var product: ProductResponse
    
    init(navigationController: UINavigationController, detailCoordinatorDelegate: DetailCoordinatorDelegate, product: ProductResponse) {
        self.navigationController = navigationController
        self.detailCoordinatorDelegate = detailCoordinatorDelegate
        self.product = product
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
        let detailViewModel = DetailViewModel(product: product)
        detailViewModel.coordinator = self
        detailViewModel.viewDelegate = detailViewController
        detailViewController.detailViewModel = detailViewModel
        navigationController.pushViewController(detailViewController, animated: true)
    }
}
